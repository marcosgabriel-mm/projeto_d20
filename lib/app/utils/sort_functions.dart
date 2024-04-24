import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortFunctions {

  static void verifyScreenToSort(String value, BuildContext context) {
    if (context.read<D20Provider>().currentRoute == "Iniciativas") {
      context.read<PlayersProvider>().sortPlayers(value);
    } else if (context.read<D20Provider>().currentRoute == "Dados") {
      context.read<DicesProvider>().sortDices(value);
    } else if (context.read<D20Provider>().currentRoute == "Anotações") {
      context.read<NotesProvider>().sortNotes(value);
    }
  }

}