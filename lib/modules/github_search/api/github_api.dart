import 'dart:convert';

import 'package:get/get.dart';
import 'package:github_app/modules/github_search/models/repo_model.dart';
import 'package:http/http.dart' as http;

class GitHubApi {
  static const _baseUrl = 'https://api.github.com';
  static final http.Client client = http.Client();

  Future<List<Repo>> getRepos(String query, int currentPage) async {
    final url =
        '$_baseUrl/search/repositories?q=$query&sort=stars&order=desc&page=$currentPage&per_page=15';

    final http.Response response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      return List<Repo>.from(
        decoded['items'].map((repo) => Repo.fromJson(repo)),
      );
    } else {
      printError(info: 'Failed to load data');
      return [];
    }
  }
}
