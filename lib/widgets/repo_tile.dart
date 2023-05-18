import 'package:flutter/material.dart';
import 'package:github_app/core/app_theme.dart';

class RepoTile extends StatelessWidget {
  const RepoTile({
    super.key,
    required this.name,
    required this.isFavorite,
    required this.onTap,
  });

  final String name;
  final bool isFavorite;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(left: 16, right: 28),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.colors.primaryLayerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Image.asset(
              'assets/images/favorite_active.png',
              color: isFavorite
                  ? AppTheme.colors.primaryAccentColor
                  : AppTheme.colors.primaryPlaceHolderTextColor,
              fit: BoxFit.contain,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
