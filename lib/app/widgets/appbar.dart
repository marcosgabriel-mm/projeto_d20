import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/utils/app_functions.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

import 'package:d20_project/styles/text_styles.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool areAllSelected;
  final List<Widget>? actions;

  const ApplicationBar({
    Key? key,
    required this.areAllSelected,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _ApplicationBarState extends State<ApplicationBar> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: !context.watch<D20Provider>().isSelectionMode
          ? Padding(
              padding: const EdgeInsets.only(left: horizontalPadding),
              child: Text(widget.title, style: TextStyles.instance.regular),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        AppFunctions.checkScreenToSelectEveryone(context);
                      },
                      icon: widget.areAllSelected ? const Icon(Icons.radio_button_checked) : const Icon(Icons.radio_button_off)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("Todos", style: TextStyles.instance.regular),
                  ),
                ],
              ),
            ),
      actions: [
        Visibility(
          visible: !context.watch<D20Provider>().isSelectionMode,
          replacement: const SizedBox.shrink(),
          child: Row(
            children: [
              if (widget.actions != null) ...widget.actions!,
            ],
          ),
        ),
      ],
    );
  }
}
