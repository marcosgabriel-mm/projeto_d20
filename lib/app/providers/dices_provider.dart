import 'dart:math';

import 'package:d20_project/app/models/dices.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/utils/app_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DicesProvider extends ChangeNotifier {
  int _totalResult = 0;
  List<Map<dynamic, dynamic>> _resultList = [];
  List<Dices> _justSelectedDices = [];
  List<Dices> _dicesList = [
    Dices(
        diceName: "D4",
        diceDescription: "Dado de 4 faces",
        numberOfDicesToRoll: 0,
        diceIcon: "assets/images/dice-d4.png"),
    Dices(
        diceName: "D6",
        diceDescription: "Dado de 6 faces",
        numberOfDicesToRoll: 0,
        diceIcon: "assets/images/dice-d6.png"),
    Dices(
        diceName: "D8",
        diceDescription: "Dado de 8 faces",
        numberOfDicesToRoll: 0,
        diceIcon: "assets/images/dice-d8.png"),
    Dices(
        diceName: "D10",
        diceDescription: "Dado de 10 faces",
        numberOfDicesToRoll: 0,
        diceIcon: "assets/images/dice-d10.png"),
    Dices(
        diceName: "D12",
        diceDescription: "Dado de 12 faces",
        numberOfDicesToRoll: 0,
        diceIcon: "assets/images/dice-d12.png"),
    Dices(
        diceName: "D20",
        diceDescription: "Dado de 20 faces",
        numberOfDicesToRoll: 0,
        diceIcon: "assets/images/dice-d20.png"),
    Dices(
        diceName: "D100",
        diceDescription: "Dado de 100 faces",
        numberOfDicesToRoll: 0,
        diceIcon: "assets/images/dice-d10.png"),
  ];
  List<Dices> get dicesList => _dicesList;
  List<Map<dynamic, dynamic>> get resultList => _resultList;
  List<Dices> get justSelectedDices => _justSelectedDices;
  int get totalResult => _totalResult;

  void addJustSelectedDices(List<Dices> dice) {
    for (var dices in dicesList) {
      if (dices.numberOfDicesToRoll > 0) {
        _justSelectedDices.add(dices);
      }
    }
    notifyListeners();
  }

  void sortDices(String value){
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
    notifyListeners();
  }

  void clearDicesSelected() {
    _justSelectedDices.clear();
    notifyListeners();
  }

  void addResult(Map value) {
    _resultList.add(value);
    notifyListeners();
  }

  String formatResultList(List<Map<dynamic, dynamic>> resultList) {
  return resultList.map((result) {
    final diceName = result.keys.first;
    final numbersRolled = result[diceName]?.join(', ');
    final totalForEachDice = result[diceName].fold(0, (previousValue, element) => previousValue + element);
    return '$diceName:  $numbersRolled  =>  $totalForEachDice';
  }).join('\n\n');
}

  void clearResult() {
    _resultList.clear();
    notifyListeners();
  }

  void totalResultForTheRoll() {
    _totalResult = 0;

    for (var result in _resultList) {
      for (var key in result.keys) {
        for (var value in result[key]) {
          _totalResult += value as int;
        }
      }
    }
    notifyListeners();
  }

  void addDice(List<TextEditingController> controllers){
    _dicesList.add(Dices(
      diceName: "D${controllers[0].text}",
      diceDescription: controllers[1].text,
      numberOfDicesToRoll: 0,
    ));
    dicesList.sort((a, b) {
      int numberA = int.parse(a.diceName.substring(1));
      int numberB = int.parse(b.diceName.substring(1));
      return numberA.compareTo(numberB);
    });
    notifyListeners();
  }

  void removeDices() {
    _dicesList.removeWhere((element) => element.isSelected);
    notifyListeners();
  }

  void selectDice(int index) {
    _dicesList[index].isSelected = !_dicesList[index].isSelected;
    notifyListeners();
  }
  
  void turnAllUnselected(){
    for (var element in _dicesList) {
          element.isSelected = false;
        }
    notifyListeners();
  }

  void addDiceToRoll(int index) {
    _dicesList[index].numberOfDicesToRoll++;
    notifyListeners();
  }

  void removeDiceToRoll(int index) {
    if (_dicesList[index].numberOfDicesToRoll > 0) {
      _dicesList[index].numberOfDicesToRoll--;
      notifyListeners();
    }
  }

  bool get isAnyDiceSelected {
    for (var dice in _dicesList) {
      if (dice.numberOfDicesToRoll > 0) {
        return true;
      }
    }
    return false;
  }

  void clearNumberOfDicesToRoll(BuildContext context) {
    for (var dice in _dicesList) {
      dice.numberOfDicesToRoll = 0;
    }
    context.read<D20Provider>().turnOffOrOnBottomBar();
    notifyListeners();
  }

  void rollDices(BuildContext context) {
    final random = Random();

    addJustSelectedDices(dicesList);
    for (var dice in justSelectedDices) {
      List<int> numbersRolled = [];
      for (var i = 0; i < dice.numberOfDicesToRoll; i++) {
        int result = random.nextInt(int.parse(dice.diceName.substring(1)) + 1);
        if (result == 0) {
          result = 1;
        }
        numbersRolled.add(result);
      }
      addResult({dice.diceName: numbersRolled});
    }

    totalResultForTheRoll();
    AppFunctions.screenPopUp(
      context, 
      "Soma total dos dados: ${totalResult.toString()}",
      formatResultList(resultList),
      ["Ok"],
    );
    clearResult();
    clearDicesSelected();
  }

  bool areEveryoneSelected() {
    for (var dice in _dicesList) {
      if (!dice.isSelected) {
        return false;
      }
    }
    return true;
  }

  void selectOrUnselectAll() {
    if (areEveryoneSelected()) {
      turnAllUnselected();
    } else {
      for (var dice in _dicesList) {
        dice.isSelected = true;
      }
    }
    notifyListeners();
  }
}
