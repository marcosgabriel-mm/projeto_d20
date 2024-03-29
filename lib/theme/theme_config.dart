import 'package:flutter/material.dart';
import '../styles/colors_app.dart';
import '../styles/text_styles.dart';


class ThemeConfig {
  
  ThemeConfig._();
  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: const BorderSide(color: Colors.white)
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: ColorsApp.instance.primaryColor,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: ColorsApp.instance.primaryColor,
      iconTheme: const IconThemeData(color: Colors.white)
    ),
    primaryColor: ColorsApp.instance.primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.instance.primaryColor,
      primary: ColorsApp.instance.primaryColor,
      secondary: ColorsApp.instance.secondaryColor
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      isDense: true,
      fillColor: ColorsApp.instance.primaryColor,
      labelStyle: TextStyles.instance.regular.copyWith(color: Colors.white),
      errorStyle: TextStyles.instance.regular.copyWith(color: Colors.redAccent),
      contentPadding: const EdgeInsets.all(16),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    
  );
}

