import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function? function;

  const AddButton({super.key, this.function});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Adicionar",
      icon: const Icon(Icons.add),
      onPressed: () async { function!(); },
    );
  }
}


// displayBottomSheet(
        //   context, 
        //   // "Iniciativas", 
        //   // [["Nome", "Ex: Geraldo"],
        //   //   ["Classe", "Ex: Guerreiro"],
        //   //   ["Iniciativa", "Ex: 15"],]
        //   "Novo dado", 
        //   [["Nome", "Ex: D12"],
        //     ["Descrição", "Ex: Dados de 12 faces"]]
        // );