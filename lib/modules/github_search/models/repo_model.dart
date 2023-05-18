// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Repo {
  final int id;
  final String name;

  bool isFavorite = false;

  Repo({
    required this.id,
    required this.name,
    this.isFavorite = false,
  });

  Repo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Repo copyWith({
    int? id,
    String? name,
  }) {
    return Repo(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(covariant Repo other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  factory Repo.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Repo(
      id: data['id'],
      name: data['name'],
      isFavorite: true,
    );
  }
  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isFavorite': isFavorite,
    };
  }

  factory Repo.fromMap(Map<String, dynamic> map) {
    return Repo(
      id: map['id'] as int,
      name: map['name'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());
}
