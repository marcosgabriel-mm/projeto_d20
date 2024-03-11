// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:d20_project/app/pages/initiatives/widgets/initiatives_sheet.dart';
import 'package:flutter/material.dart';


import 'package:d20_project/app/models/players.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';

class BarraApp extends StatefulWidget implements PreferredSizeWidget {
  final ValueNotifier<int> refreshNotifier;
  final bool isSelectionMode;
  final IconData icon;
  final Function(IconData) onIconChanged;

  const BarraApp({
    Key? key,
    required this.refreshNotifier,
    required this.icon,
    this.isSelectionMode = false, 
    required this.onIconChanged,
  }) : super(key: key);

  @override
  State<BarraApp> createState() => _BarraAppState();
  
  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _BarraAppState extends State<BarraApp> {
  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: !widget.isSelectionMode 
        ? Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Text("Iniciativas", style: TextStyles.instance.regular),
        ) 
        : Padding(
          padding: const EdgeInsets.only(left: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.icon == Icons.radio_button_off) {
                      for (var element in playersList) {
                        element.isSelected = true;
                      }
                      widget.onIconChanged(Icons.radio_button_on);
                    }
                    else {
                      for (var element in playersList) {
                        element.isSelected = false;
                      }
                      widget.onIconChanged(Icons.radio_button_off);
                    }
                    widget.refreshNotifier.value++;
                  });
                },
                icon: Icon(widget.icon)
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text("Todos", style: TextStyles.instance.regular),
              ),
            ],
          ),
        ),
      centerTitle: false,
      actions: [
        IconButton(
          tooltip: "Adicionar nova iniciativa",
          icon: const Icon(Icons.add),
          onPressed: ()  async { displayBottomSheet(context, () => widget.refreshNotifier.value++);},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: IconButton(
            tooltip: "Ordenar iniciativas",
            onPressed: () {},
            icon: PopupMenuButton<String>(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: ColorsApp.instance.secondaryColor,
              icon: const Icon(Icons.sort, color: Colors.white,),
              onSelected: (value) {
                setState(() {
                  if (value == "Nome") {
                    playersList.sort((a, b) => a.playerName.compareTo(b.playerName));
                  } else if (value == "Decrescente") {
                    playersList.sort((a, b) => b.initiatives.compareTo(a.initiatives));
                  } else if (value == "Crescente") {
                    playersList.sort((a, b) => a.initiatives.compareTo(b.initiatives));
                  } else {
                    playersList.sort((a, b) => a.playerClass.compareTo(b.playerClass));
                  }
                  widget.refreshNotifier.value++;
                });
              },
              itemBuilder: (BuildContext context) {
                return ['Nome', 'Decrescente', "Crescente", 'Classe'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice, style: TextStyles.instance.regular,),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }
}