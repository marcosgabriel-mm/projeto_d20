import 'package:d20_project/app/models/players.dart';
import 'package:flutter/material.dart';

class PlayersProvider extends ChangeNotifier {
  List<Players> _playersList = [];

  List<Players> get playersList => _playersList;

  void sortPlayers(String value){
    if (value == "Nome") {
      playersList.sort((a, b) => a.playerName.compareTo(b.playerName));
    } else if (value == "Decrescente") {
      playersList.sort((a, b) => b.initiatives.compareTo(a.initiatives));
    } else if (value == "Crescente") {
      playersList.sort((a, b) => a.initiatives.compareTo(b.initiatives));
    } else {
      playersList.sort((a, b) => a.playerClass.compareTo(b.playerClass));
    }
    notifyListeners();
  }

  void addPlayer(List<TextEditingController> controllers) {
    _playersList.add(Players(
      playerName: controllers[0].text,
      playerClass: controllers[1].text,
      initiatives: int.parse(controllers[2].text),
      isSelected: false,
    ));
    _playersList.sort((a, b) => b.initiatives.compareTo(a.initiatives));
    notifyListeners();
  }

  void removePlayer() {
    _playersList.removeWhere((element) => element.isSelected);
    notifyListeners();
  }

  void playerSelect(int index) {
    _playersList[index].isSelected = !_playersList[index].isSelected;
    notifyListeners();
  }

  void turnAllUnselected() {
    for (var element in _playersList) {
      element.isSelected = false;
    }
    notifyListeners();
  }

  void selectOrUnselectAll() {
    if (_playersList.every((player) => player.isSelected)) {
      for (var player in _playersList) {
        player.isSelected = false;
      }
    } else {
      for (var player in _playersList) {
        if (!player.isSelected) {
          player.isSelected = true;
        }
      }
    }
    notifyListeners();
  }

  bool areEveryoneSelected() {
    for (var element in _playersList) {
      if (!element.isSelected) {
        return false;
      }
    }
    return true;
  }

}
