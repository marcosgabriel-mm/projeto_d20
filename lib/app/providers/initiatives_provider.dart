import 'package:d20_project/app/models/initiatives.dart';
import 'package:d20_project/app/utils/app_functions.dart';
import 'package:d20_project/app/widgets/sheet/bottom_sheet.dart';
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

  set resistanceTypesSelected(List<String> value) {
    _resistanceTypesSelected = value;
    notifyListeners();
  }

  set weaknessTypesSelected(List<String> value) {
    _weaknessTypesSelected = value;
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

  void removeInitiative(BuildContext context) async {
    bool? shouldDelete = await AppFunctions.screenPopUp(context, "Excluir", "Deseja excluir as iniciativas selecionadas?", ["Cancelar", "Excluir"]);
    if (shouldDelete == true) {
      _initiativesList.removeWhere((element) => element.isSelected);
      notifyListeners();
    }
  }

  void selectInitiative(int index) {
    _initiativesList[index].isSelected = !_initiativesList[index].isSelected;
    notifyListeners();
  }

  void editInitiative(BuildContext context) async {
    int index = _initiativesList.indexWhere((element) => element.isSelected);
    List<TextEditingController>? controllers = await BottomSheetModal.addOrEditInitiative(context, true, _initiativesList[index]);

    if (controllers != null) {
      _initiativesList[index].playerName = controllers[0].text;
      _initiativesList[index].playerClass = controllers[1].text;
      _initiativesList[index].hitPoints = int.parse(controllers[2].text);

      _initiativesList[index].initiatives = int.parse(controllers[3].text);
      _initiativesList[index].spellClass = int.parse(controllers[4].text);
      _initiativesList[index].armorClass = int.parse(controllers[5].text);

      _initiativesList[index].resistanceTypes = List<String>.from(_resistanceTypesSelected);
      _initiativesList[index].weaknessTypes = List<String>.from(_weaknessTypesSelected);
    }

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
