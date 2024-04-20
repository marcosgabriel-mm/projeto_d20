import 'package:d20_project/app/models/players.dart';
import 'package:flutter/material.dart';

class InitiativesProvider extends ChangeNotifier {
  
  IconData _icon = Icons.radio_button_off;

  IconData get icon => _icon;



  void setIcon(IconData icon) {
    _icon = icon;
    notifyListeners();
  }

  void onSelectionMode(Players player) {
    player.isSelected = !player.isSelected;
    notifyListeners();
  }
}
