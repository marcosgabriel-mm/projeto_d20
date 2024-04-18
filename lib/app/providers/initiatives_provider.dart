import 'package:d20_project/app/models/players.dart';
import 'package:flutter/material.dart';

class InitiativesProvider extends ChangeNotifier {
  bool _isSelectionMode = false;
  IconData _icon = Icons.radio_button_off;
  List<Widget> _initiatives = [];

  bool get isSelectionMode => _isSelectionMode;
  List<Widget> get initiatives => _initiatives;
  IconData get icon => _icon;

  void toogleSelectionMode() {
    _isSelectionMode = !_isSelectionMode;
    notifyListeners();
  }

  void setIcon(IconData icon) {
    _icon = icon;
    notifyListeners();
  }

  void onSelectionMode(Players player) {
    player.isSelected = !player.isSelected;
    notifyListeners();
  }

  void refreshScreen() {
    notifyListeners();
  }
}
