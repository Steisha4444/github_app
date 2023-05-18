import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:github_app/modules/github_search/models/repo_model.dart';

class FirebaseApi {
  static final _db = FirebaseFirestore.instance;

  Future<void> addFavoriteRepo(Repo repo) async {
    final doc = _db.collection('favoriteRepos').doc(repo.id.toString());
    final json = repo.toMap();
    await doc.set(json);
  }

  Future<List<Repo>> getFavoriteRepos() async {
    final snapshot = await _db.collection('favoriteRepos').get();

    return snapshot.docs.map((e) => Repo.fromSnapshot(e)).toList();
  }

  Future<void> deleteFavoriteRepo(Repo repo) async {
    final doc = _db.collection('favoriteRepos').doc(repo.id.toString());

    await doc.delete();
  }
}
