import 'dart:math';

import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:d20_project/app/widgets/popup_buttons.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppFunctions {
  static void callFunction(String textLabel, BuildContext context) {
    switch (textLabel) {
      case "Limpar":
        clearSelection(context);
        context.read<D20Provider>().turnOffOrOnBottomBar();
        break;
      case "Rolar":
        rollDices(context);
        screenPopUp(
          context, 
          "Soma total dos dados: ${context.read<DicesProvider>().totalResult.toString()}",
          context.read<DicesProvider>().formatResultList(context.read<DicesProvider>().resultList),
          ["Ok"],
          [() => context.read<DicesProvider>().clearResult()]
        );
        break;
      case "Excluir":
        screenPopUp(
          context, 
          "Excluir", 
          "Deseja excluir os itens selecionados?",
          ["Cancelar", "Excluir"],
          [ 
            () => context.read<PlayersProvider>().removePlayer(),
            () => context.read<InitiativesProvider>().setIcon(Icons.radio_button_off),
            () => context.read<D20Provider>().toogleSelectionMode(),
            () => context.read<D20Provider>().turnOffOrOnBottomBar()
          ]
        );
        break;
      default:
    }
  }

  static void rollDices(BuildContext context) {
    final dicesProvider = context.read<DicesProvider>();
    final random = Random();

    dicesProvider.clearResult();
    dicesProvider.clearDicesSelected();

    dicesProvider.addJustSelectedDices(dicesProvider.dicesList);
    for (var dice in dicesProvider.justSelectedDices) {
      List<int> numbersRolled = [];
      for (var i = 0; i < dice.numberOfDicesToRoll; i++) {
        int result = random.nextInt(int.parse(dice.diceName.substring(1)) + 1);
        numbersRolled.add(result);
      }
      dicesProvider.addResult({dice.diceName: numbersRolled});
    }

    context.read<DicesProvider>().totalResultForTheRoll();
    // print(dicesProvider.resultList);
    // print(dicesProvider.totalResult);
  }

  static void clearSelection(BuildContext context) {
    context.read<DicesProvider>().clearNumberOfDicesToRoll();
  }

  static Future<dynamic> screenPopUp(
      context, String title, String content, List<String> textLabel, List<Function> listOfComands) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsApp.instance.secondaryColor,
        title: Text(
          title,
          style: TextStyles.instance.regular,
        ),
        content: Text(
          content,
          style: TextStyles.instance.regular,
        ),
        actions: [
          for (var item in textLabel)
            PopupButtons(
              context: context,
              textLabel: item,
              listOfComands: [
                for (var command in listOfComands) command,
              ],
            ),
        ],
      ),
    );
  }
}
