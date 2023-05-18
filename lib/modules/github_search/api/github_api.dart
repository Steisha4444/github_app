import 'dart:convert';

import 'package:github_app/modules/github_search/models/repo_model.dart';
import 'package:http/http.dart' as http;

class GitHubApi {
  Future<List<Repo>> getRepos(String query, int currentPage) async {
    try {
      final http.Client client = http.Client();

      String url =
          'https://api.github.com/search/repositories?q=$query&sort=stars&order=desc&page=$currentPage&per_page=15';
      final http.Response response = await client.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        return List<Repo>.from(
          decoded['items'].map((repo) {
            return Repo.fromJson(repo);
          }),
        );
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching repositories: $e');
    }
  }
}
