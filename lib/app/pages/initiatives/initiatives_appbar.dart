// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:d20_project/app/pages/initiatives/widgets/Sheet/initiatives_sheet.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:flutter/material.dart';

import 'package:d20_project/app/models/players.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:provider/provider.dart';

class BarraApp extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const BarraApp({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<BarraApp> createState() => _BarraAppState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _BarraAppState extends State<BarraApp> {
  final horizontalPadding = 18.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: !context.read<InitiativesProvider>().isSelectionMode
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
                      onPressed: () {
                        context.read<PlayersProvider>().toggleSelectionMode();
                      },
                      icon: Icon(
                        context
                                .read<PlayersProvider>()
                                .playersList
                                .any((element) => element.isSelected)
                            ? Icons.radio_button_checked
                            : InitiativesProvider().icon,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("Todos", style: TextStyles.instance.regular),
                  ),
                ],
              ),
            ),
      centerTitle: false,
      actions: [
        context.read<InitiativesProvider>().isSelectionMode
            ? const SizedBox()
            : Row(
                children: [
                  IconButton(
                    tooltip: "Adicionar",
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      displayBottomSheet(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: horizontalPadding),
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.sort,
                        color: Colors.white,
                      ),
                      tooltip: "Ordenar",
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: ColorsApp.instance.secondaryColor,
                      onSelected: (value) {
                        sortList(
                            value, context.read<PlayersProvider>().playersList);
                      },
                      itemBuilder: (BuildContext context) {
                        return ['Nome', 'Decrescente', "Crescente", 'Classe']
                            .map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                              style: TextStyles.instance.regular,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}

void sortList(String value, List<Players> playersList) {
  if (value == "Nome") {
    playersList.sort((a, b) => a.playerName.compareTo(b.playerName));
  } else if (value == "Decrescente") {
    playersList.sort((a, b) => b.initiatives.compareTo(a.initiatives));
  } else if (value == "Crescente") {
    playersList.sort((a, b) => a.initiatives.compareTo(b.initiatives));
  } else {
    playersList.sort((a, b) => a.playerClass.compareTo(b.playerClass));
  }
}
