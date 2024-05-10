import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScrollListerner extends StatelessWidget {
  final ScrollController scrollController;
  final BuildContext context;
  final Widget child;

  const ScrollListerner({
    super.key, 
    required this.scrollController, 
    required this.child, 
    required this.context
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollUpdateNotification) {
          if (scrollController.position.pixels == scrollController.position.minScrollExtent) {
            if (!context.read<D20Provider>().showFloatingButton) {
              context.read<D20Provider>().toggleFloatingButton();
            }
          } else {
            if (context.read<D20Provider>().showFloatingButton) {
              context.read<D20Provider>().toggleFloatingButton();
            }
          }
        }
        return true;
      },
      child: child
    );
  }
}