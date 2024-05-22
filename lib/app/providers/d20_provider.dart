import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class D20Provider extends ChangeNotifier {
  bool _toogleBottomBar = true;
  bool _isSelectionMode = false;
  bool _showFloatingButton = true;
  int _currentIndex = 0;
  String _currentRoute = "Iniciativas";

  bool get toogleBottomBar => _toogleBottomBar;
  bool get isSelectionMode => _isSelectionMode;
  bool get showFloatingButton => _showFloatingButton;
  int get currentIndex => _currentIndex;
  String get currentRoute => _currentRoute;

  void toggleFloatingButton() {
    _showFloatingButton = !_showFloatingButton;
    notifyListeners();
  }

  void turnOffOrOnBottomBar() {
    _toogleBottomBar = !_toogleBottomBar;
    notifyListeners();
  }

  void toogleSelectionModeAndBottomBar() {
    _isSelectionMode = !_isSelectionMode;
    _toogleBottomBar = !_toogleBottomBar;
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

  bool areAllSelectedFromThatScreen(BuildContext context) {
    switch (_currentRoute) {
      case "Iniciativas":
        return context.read<InitiativesProvider>().areEveryoneSelected();
      case "Dados":
        return false;
      case "Anotações":
        return context.read<NotesProvider>().areEveryoneSelected();
      default:
        return false;
    }
  }
}
