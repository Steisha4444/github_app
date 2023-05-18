import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:github_app/modules/github_search/controllers/github_controller.dart';
import 'package:github_app/widgets/empty_list_text.dart';
import 'package:github_app/widgets/repo_tile.dart';

class FavoriteRepoList extends StatelessWidget {
  const FavoriteRepoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GitHubController>(
      builder: (controller) {
        final favoriteRepos = controller.favoriteRepos;

        if (favoriteRepos == null) {
          return const Align(
            alignment: Alignment.topCenter,
            child: CupertinoActivityIndicator(),
          );
        } else if (favoriteRepos.isEmpty) {
          return const Center(
            child: EmptyListText(
              text: 'You have no favorites.',
              details: 'Click on star while searching to add first favorite.',
            ),
          );
        } else {
          return ListView.builder(
            itemCount: favoriteRepos.length,
            itemBuilder: (BuildContext context, int index) {
              final repo = favoriteRepos[index];

              return RepoTile(
                name: repo.name,
                isFavorite: true,
                onTap: () async => await controller.removeFavoriteRepo(repo),
              );
            },
          );
        }
      },
    );
  }
}
