import 'package:flutter/material.dart';

class ColorsApp {
  
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primaryColor => const Color.fromARGB(255, 27, 30, 34);
  Color get secondaryColor => const Color.fromARGB(255, 39, 45, 51);

}

extension ColorsAppExcetions on BuildContext{
  ColorsApp get colors => ColorsApp.instance;
}