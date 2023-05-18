import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_app/core/app_theme.dart';
import 'package:github_app/modules/github_search/screens/favorite_repos_screen.dart';

class StarButton extends StatelessWidget {
  StarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => const FavoriteReposScreen()),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          right: 16,
        ),
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: AppTheme.colors.primaryAccentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          'assets/images/favorite_active.png',
          fit: BoxFit.contain,
          height: 20,
        ),
      ),
    );
  }
}
