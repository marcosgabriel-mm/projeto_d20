import 'package:d20_project/src/views/components/bottom_button_menu.dart';
import 'package:flutter/material.dart';

class SelectionBottomMenu extends StatelessWidget {
  final Function callback;

  const SelectionBottomMenu({
    super.key, 
    required this.callback, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomButtonMenu(
            textLabel: "Editar", 
            icon: Icons.edit,
            onPressedCallback: () { callback(); },            
          ),
          BottomButtonMenu(
            textLabel: "Excluir", 
            icon: Icons.delete,
            onPressedCallback: () { callback(); },
          ),
        ],
      ),
    );
  }
}