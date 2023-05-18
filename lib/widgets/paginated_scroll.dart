import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';

class PaginatedScroll extends StatefulWidget {
  final String tag;
  final Widget child;
  final int currentPage;
  final Duration? debounceDuration;
  final ScrollController scrollController;
  // Function must return [true] if no elements left
  final Future<bool> Function() onNextPageReached;

  const PaginatedScroll({
    super.key,
    this.debounceDuration,
    required this.currentPage,
    required this.tag,
    required this.child,
    required this.scrollController,
    required this.onNextPageReached,
  });

  @override
  State<PaginatedScroll> createState() => _PaginatedScrollState();
}

class _PaginatedScrollState extends State<PaginatedScroll> {
  bool _loading = false;
  bool _reachedMax = false;
  late final _scroll = widget.scrollController;

  @override
  void initState() {
    _scroll.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (widget.currentPage == 1) _reachedMax = false;

    if (_reachedMax || _loading) return;

    final position = _scroll.position;

    if (position.pixels >= position.maxScrollExtent) {
      EasyDebounce.debounce(
        widget.tag,
        widget.debounceDuration ?? const Duration(milliseconds: 500),
        () async {
          _loading = true;
          _reachedMax = await widget.onNextPageReached();
          _loading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
