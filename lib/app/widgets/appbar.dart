import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:d20_project/app/utils/add_functions.dart';
import 'package:d20_project/app/utils/sort_functions.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/sort_button.dart';
import 'package:flutter/material.dart';

import 'package:d20_project/styles/text_styles.dart';
import 'package:provider/provider.dart';

class ApplicationBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<String> listOfSorts;

  const ApplicationBar({
    Key? key,
    required this.title,
    required this.listOfSorts,
  }) : super(key: key);

  @override
  State<ApplicationBar> createState() => _ApplicationBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _ApplicationBarState extends State<ApplicationBar> {
  final horizontalPadding = 18.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: !context.watch<D20Provider>().isSelectionMode
          ? Padding(
              padding: EdgeInsets.only(left: horizontalPadding),
              child: Text(widget.title, style: TextStyles.instance.regular),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () { context.read<PlayersProvider>().turnEveryoneSelected(); },
                      icon: context.watch<PlayersProvider>().areEveryoneSelected() ? const Icon(Icons.radio_button_checked) : Icon(context.read<InitiativesProvider>().icon) 
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("Todos", style: TextStyles.instance.regular),
                  ),
                ],
              ),
            ),
      actions: [
        Row(
          children: [
            AddButton(
              function: AddFunctions.addSomethingAccordingToScreen(widget.title, context),
            ),
            SortButton(
              listOfSorts: widget.listOfSorts,
              padding: horizontalPadding,
              function: (value) {
                if (value != null) {
                  SortFunctions.verifyScreenToSort(value, widget.title ,context);
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
