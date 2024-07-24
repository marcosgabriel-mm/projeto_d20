// ignore_for_file: prefer_final_fields
import 'package:d20_project/app/providers/files_provider.dart';
import 'package:flutter/material.dart';

class AttacksProvider extends ChangeNotifier {

  final String _defaultAttackName = "Novo Ataque";
  final String _defaultDice = "1d20";

  
  List<Map<String, String>> listOfAttacks = [];
  List<int> indexes = [];

  void addNewAttack(String attackName, String dice) async {

    dice = dice.isEmpty ? _defaultDice : dice;
    attackName = attackName.isEmpty ? _defaultAttackName : attackName;

    listOfAttacks.add({
      "name": attackName,
      "dice": dice
    });

    await FilesProvider().saveAttacks(listOfAttacks);
    notifyListeners();
  }

  void deleteAttacks() {
    
    if (indexes.isEmpty) return;
    for (var index in indexes) { 
      listOfAttacks.removeAt(index);
    }

    indexes.clear();
    FilesProvider().saveAttacks(listOfAttacks);
    notifyListeners();
  }

  void loadAttacks() async {
    List attacks = await FilesProvider().loadAttacks();
    for (var attack in attacks) {
      if (!listOfAttacks.any((element) => element["name"] == attack["name"])) {
        listOfAttacks.add({
          "name": attack["name"],
          "dice": attack["dice"]
        });
      }
    }
    notifyListeners();
  }

  void saveAttacks() async { 
    await FilesProvider().saveAttacks(listOfAttacks);
    notifyListeners();  
  }

  void addIndex(int index) {
    indexes.add(index);
    notifyListeners();
  }

  void removeIndex(int index) {
    indexes.remove(index);
    notifyListeners();
  }

  bool areEveryoneSelected() {
    if (indexes.isEmpty) {return false;}
    return indexes.length == listOfAttacks.length;
  }

  void selectEveryone() {
    if (areEveryoneSelected()) {
      indexes.clear();
    } else {
      for (var index = 0; index < listOfAttacks.length; index++) {
        indexes.add(index);
      }
    }
    notifyListeners();
  }

  void sortAttacks(String field) {
    switch (field) {
      case "name":
        listOfAttacks.sort((a, b) => a["name"]!.compareTo(b["name"]!));
        break;
      case "dice":
        listOfAttacks.sort((a, b) => a["dice"]!.compareTo(b["dice"]!));
        break;
      default:
        listOfAttacks.sort((a, b) => a["name"]!.compareTo(b["name"]!));
        break;
    }
    notifyListeners();
  }
}