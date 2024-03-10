import 'package:d20_project/src/views/initiatives_view.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      home: const InitiativeView(),
    );
  }
}