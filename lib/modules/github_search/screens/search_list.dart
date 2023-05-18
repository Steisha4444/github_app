import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:github_app/modules/github_search/controllers/github_controller.dart';
import 'package:github_app/widgets/empty_list_text.dart';
import 'package:github_app/widgets/repo_tile.dart';

class SearchList extends StatelessWidget {
  const SearchList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GitHubController>(
      builder: (controller) {
        final searchList = controller.searchList;

        if (searchList == null) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (searchList.isEmpty) {
          return const Expanded(
            child: Center(
              child: EmptyListText(
                text: 'You have empty history',
                details: 'Click on search to start the journey!',
              ),
            ),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (BuildContext context, int index) {
                final searchItem = searchList[index];

                return RepoTile(
                  name: searchItem,
                  isFavorite: false,
                  onTap: () {},
                );
              },
            ),
          );
        }
      },
    );
  }
}
