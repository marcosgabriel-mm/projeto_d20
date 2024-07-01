import 'package:flutter/material.dart';

class AttacksProvider extends ChangeNotifier {

  final String defaultAttackName = "Novo Ataque";
  final String defaultDice = "1d20";

  // ignore: prefer_final_fields
  List<Map<String, String>> _listOfAttacks = [];
  get listOfAttacks => _listOfAttacks;

  void addNewAttack(String attackName, String dice) {

    dice = dice.isEmpty ? defaultDice : dice;
    attackName = attackName.isEmpty ? defaultAttackName : attackName;

    _listOfAttacks.add({
      "name": attackName,
      "dice": dice
    });

    //TODO: Chamar função de salvar arquivo

    notifyListeners();
  }

  void deleteAttack(int index) {
    _listOfAttacks.removeAt(index);

    //TODO: Remover ataque e salvar arquivo

    notifyListeners();
  }

  void editAttack(int index, String attackName, String dice) {
    _listOfAttacks[index]["name"] = attackName;
    _listOfAttacks[index]["dice"] = dice;

    //TODO: Chamar função de salvar arquivo

    notifyListeners();
  }

  void loadAttacks() {

    //TODO: Carregar ataques do arquivo

    notifyListeners();
  }

  void saveAttacks() { 

    //TODO: Salvar ataques no arquivo json

    notifyListeners();  
  }
}