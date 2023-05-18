import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_app/core/app_theme.dart';

class NavBackButton extends StatelessWidget {
  const NavBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        alignment: Alignment.center,
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: AppTheme.colors.primaryAccentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          'assets/images/left.png',
          fit: BoxFit.contain,
          height: 20,
        ),
      ),
    );
  }
}
