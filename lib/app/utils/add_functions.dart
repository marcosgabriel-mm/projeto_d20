import 'package:d20_project/app/pages/notes/widgets/notes_text.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/widgets/sheet/bottom_sheet.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFunctions {

  static Function addSomethingAccordingToScreen(BuildContext context){
    return () {
      if (context.read<D20Provider>().currentRoute == "Iniciativas") {
        displayBottomSheet(
          context, 
          "Nova iniciativa", 
          [["Nome", "Ex: Geraldo"],["Classe", "Ex: Guerreiro"],["Iniciativa", "Ex: 15"]],
          context.read<PlayersProvider>().addPlayer,
        );
      } else if (context.read<D20Provider>().currentRoute == "Dados") {
        displayBottomSheet(
          context, 
          "Novo dado", 
          [["Quantidade de lados", "Ex: 34"],["Descrição", "Ex: Dado de 34 faces"]],
          context.read<DicesProvider>().addDice,
        );
      } else if (context.read<D20Provider>().currentRoute == "Anotações") {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => NotesText(
              noteTitle: "",
              noteDescription: "",
              index: -1,
            ),
          ),
        );
      }
    };

  }

}