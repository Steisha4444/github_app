import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:github_app/core/app_theme.dart';
import 'package:github_app/modules/github_search/screens/repo_list.dart';
import 'package:github_app/modules/github_search/screens/search_field.dart';
import 'package:github_app/modules/github_search/screens/search_list.dart';
import 'package:github_app/widgets/star_button.dart';
import 'package:github_app/modules/github_search/controllers/github_controller.dart';

class GitHubScreen extends StatelessWidget {
  GitHubScreen({super.key}) {
    Get.put(GitHubController());
  }

  Widget getList(bool showSearchHistory) {
    if (showSearchHistory) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Search History',
              style: TextStyle(
                color: AppTheme.colors.primaryAccentColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const SearchList()
        ],
      );
    }
    return RepoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          elevation: 0.4,
          title: Text(
            'Github repos list',
            style: TextStyle(
              color: AppTheme.colors.primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          actions: const [
            Center(
              child: StarButton(),
            ),
          ],
        ),
      ),
      body: GetBuilder<GitHubController>(
        builder: (value) {
          return Column(
            children: [
              const SearchField(),
              Expanded(
                child: getList(value.showSearchHistory),
              ),
            ],
          );
        },
      ),
    );
  }
}
