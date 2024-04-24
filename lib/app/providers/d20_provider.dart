import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class D20Provider extends ChangeNotifier {
  bool _toogleBottomBar = true;
  bool _isSelectionMode = false;
  int _currentIndex = 0;
  String _currentRoute = "Iniciativas";

  bool get toogleBottomBar => _toogleBottomBar;
  bool get isSelectionMode => _isSelectionMode;
  int get currentIndex => _currentIndex;
  String get currentRoute => _currentRoute;

  void turnOffOrOnBottomBar() {
    _toogleBottomBar = !_toogleBottomBar;
    notifyListeners();
  }

  void toogleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    notifyListeners();
  }

  void updateBottomMenuState(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void updateCurrentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }

  bool areAllSelectedFromThatScreen(String screen, BuildContext context) {
    switch (screen) {
      case "Iniciativas":
        return context.read<PlayersProvider>().areEveryoneSelected();
      case "Dados":
        return false;
      case "Anotações":
        return context.read<NotesProvider>().areEveryoneSelected();
      default:
        return false;
    }
  }
}
