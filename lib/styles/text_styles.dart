import 'package:flutter/material.dart';

class TextStyles {
  
  static TextStyles? _instance;

  TextStyles._();
	static TextStyles get instance{
		_instance??=  TextStyles._();
		return _instance!;
	}

  String get font => 'Fraunces';

  TextStyle get regular => TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: Colors.white,
    fontFamily: font
  );

  TextStyle get boldItalic => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Colors.white,
    fontFamily: font
  );

}