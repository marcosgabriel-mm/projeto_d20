import 'package:d20_project/app/models/players.dart';
import 'package:flutter/material.dart';

class PlayersProvider extends ChangeNotifier {
  List<Players> _playersList = [];

  List<Players> get playersList => _playersList;

  void addPlayer(Players player) {
    _playersList.add(player);
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

  void toggleSelectionMode() {
    for (var element in _playersList) {
      element.isSelected = !element.isSelected;
    }
    notifyListeners();
  }

}
