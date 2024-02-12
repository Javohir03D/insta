import 'package:flutter/material.dart';
import 'package:smartrefresh/smartrefresh.dart';

class WRefresher extends StatelessWidget {
  final RefreshController controller;
  final Widget child;
  final VoidCallback onRefresh;

  const WRefresher({
    Key? key,
    required this.onRefresh,
    required this.child,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PullToRefresh(
      showChildOpacityTransition: false,
      tColor: Colors.transparent,
      onComplete: const SizedBox(),
      onFail: const SizedBox(),
      onRefresh: onRefresh,
      onLoading: const Text(
        "Loading...",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: child,
      refreshController: controller,
    );
  }
}
