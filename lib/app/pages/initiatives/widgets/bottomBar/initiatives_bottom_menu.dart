import 'package:d20_project/app/pages/initiatives/widgets/bottomBar/bottom_menu_button.dart';
import 'package:flutter/material.dart';

class SelectionBottomMenu extends StatelessWidget {
  const SelectionBottomMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomButtonMenu(
            textLabel: "Editar",
            icon: Icons.edit,
          ),
          BottomButtonMenu(
            textLabel: "Excluir",
            icon: Icons.delete,
          ),
        ],
      ),
    );
  }
}
