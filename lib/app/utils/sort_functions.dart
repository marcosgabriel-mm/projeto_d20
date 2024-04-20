import 'package:d20_project/app/models/dices.dart';
import 'package:d20_project/app/models/players.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortFunctions {

  static void verifyScreenToSort(String value, String screen, BuildContext context) {
    if (screen == "Iniciativas") {
      context.read<PlayersProvider>().sortPlayers(value);
    } else {
      context.read<DicesProvider>().sortDices(value);
    }
  }

  static Function sortInitiativesPlayerList(String value, List<Players> playersList) {
    return () {
      if (value == "Nome") {
        playersList.sort((a, b) => a.playerName.compareTo(b.playerName));
      } else if (value == "Decrescente") {
        playersList.sort((a, b) => b.initiatives.compareTo(a.initiatives));
      } else if (value == "Crescente") {
        playersList.sort((a, b) => a.initiatives.compareTo(b.initiatives));
      } else {
        playersList.sort((a, b) => a.playerClass.compareTo(b.playerClass));
      }
    };
  }

  static Function sortDices(String value, List<Dices> dicesList) {
  return () {
    if (value == "Decrescente") {
      dicesList.sort((a, b) {
        int numberA = int.parse(a.diceName.substring(1));
        int numberB = int.parse(b.diceName.substring(1));
        return numberB.compareTo(numberA);
      });
    } else {
      dicesList.sort((a, b) {
        int numberA = int.parse(a.diceName.substring(1));
        int numberB = int.parse(b.diceName.substring(1));
        return numberA.compareTo(numberB);
      });
    }
  };
}

  //todo implementar quando tiver a tela de notas
  static void sortNotes(){}

}