import 'package:d20_project/app/models/initiatives.dart';
import 'package:flutter/material.dart';

class InitiativesProvider extends ChangeNotifier {
  
  final List<String> _damageTypes = ["Concussão", "Corte", "Perfuração", "Elétrico", "Energia", "Fogo", "Frio", "Necrótico", "Ácido", "Psíquico", "Radiante", "Trovejante", "Veneno"];
  
  List<String> _resistanceTypesSelected = [];
  List<String> _weaknessTypesSelected = [];

  List<Initiatives> _initiativesList = [];

  List<Initiatives> get initiativesList => _initiativesList;
  List<String> get damageTypes => _damageTypes;

  List<String> get resistanceTypesSelected => _resistanceTypesSelected;
  List<String> get weaknessTypesSelected => _weaknessTypesSelected;

  void onSelectionMode(Initiatives player) {
    player.isSelected = !player.isSelected;
    notifyListeners();
  }

  void sortInitiatives(String value){
    if (value == "Nome") {
      initiativesList.sort((a, b) => a.playerName.compareTo(b.playerName));
    } else if (value == "Decrescente") {
      initiativesList.sort((a, b) => b.initiatives.compareTo(a.initiatives));
    } else if (value == "Crescente") {
      initiativesList.sort((a, b) => a.initiatives.compareTo(b.initiatives));
    } else {
      initiativesList.sort((a, b) => a.playerClass.compareTo(b.playerClass));
    }
    notifyListeners();
  }

  void addInitiative(List<TextEditingController> controllers) {
    _initiativesList.add(
      Initiatives(
        playerName: controllers[0].text,
        playerClass: controllers[1].text,
        hitPoints: int.parse(controllers[2].text),

        initiatives: int.parse(controllers[3].text),
        spellClass: int.parse(controllers[4].text),
        armorClass: int.parse(controllers[5].text),

        resistanceTypes: List<String>.from(_resistanceTypesSelected),
        weaknessTypes: List<String>.from(_weaknessTypesSelected),

        isSelected: false,
    ));
    _initiativesList.sort((a, b) => b.initiatives.compareTo(a.initiatives));
    notifyListeners();
  }

  void removeInitiative() {
    _initiativesList.removeWhere((element) => element.isSelected);
    notifyListeners();
  }

  void selectInitiative(int index) {
    _initiativesList[index].isSelected = !_initiativesList[index].isSelected;
    notifyListeners();
  }

  void selectOrUnselectAll() {
    if (_initiativesList.every((initiative) => initiative.isSelected)) {
      for (var initiative in _initiativesList) {
        initiative.isSelected = false;
      }
    } else {
      for (var initiative in _initiativesList) {
        if (!initiative.isSelected) {
          initiative.isSelected = true;
        }
      }
    }
    notifyListeners();
  }

  void turnAllUnselected() {
    for (var element in _initiativesList) {
      element.isSelected = false;
    }
    notifyListeners();
  }

  bool areEveryoneSelected() {
    for (var element in _initiativesList) {
      if (!element.isSelected) {
        return false;
      }
    }
    return true;
  }
}
