// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:github_app/modules/github_search/models/repo_model.dart';

// class Database {
//   final collection = FirebaseFirestore.instance.collection('favoriteRepos');

//   Stream<List<Repo>> get repos {
//     return collection.snapshots().map(_repoListFromSnapshot);
//   }

//   List<Repo> _repoListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc) {
//       return Repo.fromJson(doc.data() as Map<String, dynamic>);
//     }).toList();
//   }
// }
