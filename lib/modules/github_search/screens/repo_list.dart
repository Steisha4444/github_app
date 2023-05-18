import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:github_app/core/app_theme.dart';
import 'package:github_app/modules/github_search/controllers/github_controller.dart';
import 'package:github_app/widgets/empty_list_text.dart';
import 'package:github_app/widgets/paginated_scroll.dart';
import 'package:github_app/widgets/repo_tile.dart';

class RepoList extends StatelessWidget {
  RepoList({
    super.key,
  });

  final text = Padding(
    padding: const EdgeInsets.only(left: 16),
    child: Text(
      'What we have found',
      style: TextStyle(
        color: AppTheme.colors.primaryAccentColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GitHubController>(
      builder: (controller) {
        final repos = controller.repos;

        if (repos == null) {
          return const Align(
            alignment: Alignment.topCenter,
            child: CupertinoActivityIndicator(),
          );
        } else if (repos.isEmpty) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                text,
                const SizedBox(height: 16),
                const Expanded(
                  child: Center(
                    child: EmptyListText(
                      text: 'Nothing was found for your search.',
                      details: 'Please check the spelling.',
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text,
              const SizedBox(height: 16),
              Expanded(
                child: PaginatedScroll(
                  currentPage: controller.currentPage,
                  tag: 'repo-list',
                  scrollController: controller.scrollController,
                  onNextPageReached: () async {
                    await controller.getRepos();
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: repos.length,
                    controller: controller.scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      final repo = repos[index];

                      return RepoTile(
                        name: repo.name,
                        isFavorite: repo.isFavorite,
                        onTap: () async =>
                            await controller.toggleFavoriteRepo(repo, index),
                      );
                    },
                  ),
                ),
              ),
              if (controller.isDataFetching)
                const Center(child: CupertinoActivityIndicator()),
            ],
          );
        }
      },
    );
  }
}
