import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:github_app/modules/github_search/api/github_api.dart';
import 'package:github_app/modules/github_search/models/repo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GitHubController extends GetxController {
  final _repository = GitHubApi();
  RxBool showSearchHistory = true.obs;

  final Rx<List<Repo>?> _repos = Rx<List<Repo>?>(null);
  List<Repo>? get repos => _repos.value;
  set repos(List<Repo>? repos) => _repos.value = repos;

  final Rx<List<Repo>?> _favoriteRepos = Rx<List<Repo>?>(null);
  List<Repo>? get favoriteRepos => _favoriteRepos.value;
  set favoriteRepos(List<Repo>? repos) => _favoriteRepos.value = repos;

  final Rx<List<String>?> _searchList = Rx<List<String>?>(null);
  List<String>? get searchList => _searchList.value;
  set searchList(List<String>? searches) => _searchList.value = searches;

  final _db = FirebaseFirestore.instance;
  int currentPage = 1;

  final int perPage = 15;
  String tempQuery = '';

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _initLists();
  }

  Future<void> _initLists() async {
    await getFavoriteRepos();
    await getSearchList();
  }

  void cleanSearch() {
    showSearchHistory.value = true;
    repos = [];
  }

  Future<void> getSearchList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    searchList = prefs.getStringList('search') ?? [];
  }

  Future<void> cacheSearch(String search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList('search') ?? [];
    searches.add(search);
    prefs.setStringList('search', searches);
  }

  Future<void> getFavoriteRepos() async {
    final snapshot = await _db.collection('favoriteRepos').get();

    favoriteRepos = snapshot.docs.map((e) => Repo.fromSnapshot(e)).toList();
  }

  Future<void> addFavoriteRepo(Repo repo) async {
    final doc = _db.collection('favoriteRepos').doc(repo.id.toString());
    repo.isFavorite = !repo.isFavorite;
    final json = repo.toMap();
    await doc.set(json);
    getFavoriteRepos();
    repos!.map((element) {
      {
        if (element.id == repo.id) element.isFavorite = true;
      }
      return element;
    });
    update();
  }

  Future<void> removeFavoriteRepo(Repo repo) async {
    final doc = _db.collection('favoriteRepos').doc(repo.id.toString());

    await doc.delete();
    getFavoriteRepos();
  }

  void checkIfFavorite() {
    if (repos != null) {
      repos!.map((element) {
        if (favoriteRepos != null) {
          if (favoriteRepos!.contains(element)) {
            element.isFavorite = true;
          }
        }

        return element;
      });
    }
  }

  Future<void> getRepos([String query = '']) async {
    showSearchHistory.value = false;
    query = tempQuery.isEmpty ? query : tempQuery;
    if (query.isNotEmpty) {
      repos ??= [];
      repos!.addAll(await _repository.getRepos(query, currentPage));

      checkIfFavorite();
    }
    tempQuery = query;
    currentPage++;

    update();
  }
}
