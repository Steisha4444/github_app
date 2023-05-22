import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:github_app/modules/github_search/api/firebase_api.dart';
import 'package:github_app/modules/github_search/api/github_api.dart';
import 'package:github_app/modules/github_search/models/repo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GitHubController extends GetxController {
  final _repository = GitHubApi();
  final _firebaseRepository = FirebaseApi();
  bool showSearchHistory = true;
  bool isDataFetching = false;

  List<Repo>? _repos;
  List<Repo>? get repos => _repos;
  set repos(List<Repo>? repos) => _repos = repos;

  List<Repo>? _favoriteRepos;
  List<Repo>? get favoriteRepos => _favoriteRepos;
  set favoriteRepos(List<Repo>? repos) => _favoriteRepos = repos;

  List<String>? _searchList;
  List<String>? get searchList => _searchList;
  set searchList(List<String>? searches) => _searchList = searches;

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
    if (repos != null) {
      showSearchHistory = true;
      repos = null;
      update();
    }
  }

  Future<void> getSearchList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    searchList = prefs.getStringList('search') ?? [];
    update();
  }

  Future<void> cacheSearch(String search) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searches = prefs.getStringList('search') ?? [];
    searches.add(search);
    prefs.setStringList('search', searches);
  }

  Future<void> getFavoriteRepos() async {
    favoriteRepos = await _firebaseRepository.getFavoriteRepos();
    update();
  }

  Future<void> addFavoriteRepo(Repo repo, int index) async {
    await _firebaseRepository.addFavoriteRepo(repo);

    repos![index].isFavorite = true;
    update();
  }

  Future<void> toggleFavoriteRepo(Repo repo, int index) async {
    if (repo.isFavorite) {
      await removeFavoriteRepo(repo);
    } else {
      await addFavoriteRepo(repo, index);
    }
  }

  Future<void> removeFavoriteRepo(Repo repo) async {
    await _firebaseRepository.deleteFavoriteRepo(repo);

    if (repos != null) {
      int repoIndex = repos!.indexOf(repo);
      if (repoIndex != -1) {
        repos![repoIndex].isFavorite = false;
        update();
      }
    }
    getFavoriteRepos();

    update();
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
    isDataFetching = true;
    update();
    showSearchHistory = false;
    String searchQuery = tempQuery.isEmpty ? query : tempQuery;

    if (searchQuery.isNotEmpty) {
      if (repos == null) {
        repos = await _repository.getRepos(searchQuery, currentPage);
      } else {
        repos!.addAll(await _repository.getRepos(searchQuery, currentPage));
      }

      checkIfFavorite();
    }
    tempQuery = searchQuery;
    currentPage++;

    isDataFetching = false;
    update();
  }
}
