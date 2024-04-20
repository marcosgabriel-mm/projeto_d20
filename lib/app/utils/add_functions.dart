import 'package:d20_project/app/widgets/sheet/bottom_sheet.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFunctions {

  static Function addSomethingAccordingToScreen(String screen, BuildContext context){
    return () {
      if (screen == "Iniciativas") {
        displayBottomSheet(
          context, 
          "Nova iniciativa", 
          [["Nome", "Ex: Geraldo"],["Classe", "Ex: Guerreiro"],["Iniciativa", "Ex: 15"]],
          context.read<PlayersProvider>().addPlayer,
        );
      } else {
        displayBottomSheet(
          context, 
          "Novo dado", 
          [["Quantidade de lados", "Ex: 34"],["Descrição", "Ex: Dado de 34 faces"]],
          context.read<DicesProvider>().addDice,
        );
      }
    };

  }

}