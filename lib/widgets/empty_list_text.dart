import 'package:flutter/material.dart';
import 'package:github_app/core/app_theme.dart';

class EmptyListText extends StatelessWidget {
  const EmptyListText({super.key, required this.text, required this.details});
  final String text;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: AppTheme.colors.primaryPlaceHolderTextColor,
          ),
        ),
        Text(
          details,
          style: TextStyle(
            color: AppTheme.colors.primaryPlaceHolderTextColor,
          ),
        ),
      ],
    );
  }
}
