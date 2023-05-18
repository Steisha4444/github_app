import 'package:flutter/material.dart';
import 'package:github_app/core/app_theme.dart';
import 'package:github_app/widgets/favorite_list.dart';
import 'package:github_app/widgets/nav_back_button.dart';

class FavoriteReposScreen extends StatelessWidget {
  const FavoriteReposScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0.4,
          leadingWidth: 60,
          centerTitle: true,
          leading: const Padding(
            padding: EdgeInsets.only(left: 15, bottom: 4, top: 6),
            child: NavBackButton(),
          ),
          title: Text(
            'Favorite repos list',
            style: TextStyle(
              color: AppTheme.colors.primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: const FavoriteRepoList(),
    );
  }
}
