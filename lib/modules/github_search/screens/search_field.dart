import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_app/core/app_theme.dart';
import 'package:github_app/modules/github_search/controllers/github_controller.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final GitHubController controller = Get.find<GitHubController>();
  TextEditingController textController = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _isFocused = false;
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focus.hasFocus;
    });
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  Future<void> search() async {
    if (textController.text.isNotEmpty) {
      setState(() {
        _isEnabled = false;
      });

      await controller.cacheSearch(textController.text);
      controller.cleanSearch();
      await controller.getRepos(textController.text);
      setState(() {
        _isEnabled = true;
      });
    } else {
      controller.cleanSearch();
    }
  }

  Widget getSuffixIcon() {
    if (_isFocused) {
      return InkWell(
        onTap: () {
          textController.clear();
          controller.cleanSearch();
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 18, right: 14, top: 18, bottom: 20),
          child: Image.asset(
            _isEnabled ? 'assets/images/close.png' : 'assets/images/ban.png',
            width: 25,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        focusNode: _focus,
        enabled: _isEnabled,
        style: TextStyle(
            color: _isEnabled
                ? AppTheme.colors.primaryTextColor
                : AppTheme.colors.primaryPlaceHolderTextColor),
        onEditingComplete: search,
        controller: textController,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppTheme.colors.primaryAccentColor, width: 2.0),
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          focusColor: AppTheme.colors.secondaryAccentColor,
          suffixIcon: getSuffixIcon(),
          fillColor: _isFocused
              ? AppTheme.colors.secondaryAccentColor
              : AppTheme.colors.primaryLayerColor,
          hintText: 'Search',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(18),
            child: Image.asset(
              'assets/images/search.png',
              color: _isEnabled
                  ? AppTheme.colors.primaryAccentColor
                  : AppTheme.colors.primaryPlaceHolderTextColor,
              width: 20,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
