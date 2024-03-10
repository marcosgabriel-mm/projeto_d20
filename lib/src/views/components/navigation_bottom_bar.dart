import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String? selectedButton = "Iniciativas";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        color: ThemeConfig.theme.primaryColor,
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            "Iniciativas",
            "Personagens",
            "Dados",
            "Notas",
            "Equipamentos",
          ].map((text) => TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              foregroundColor: MaterialStateProperty.all(
                text == selectedButton ? Colors.white : Colors.white30,
              ),
              overlayColor: MaterialStateProperty.all(
                text == selectedButton ? Colors.white.withOpacity(0.1) : null,
              ),
              textStyle: MaterialStatePropertyAll(TextStyles.instance.regular)
            ),
            child: Text(text),
            onPressed: () {
              setState(() {
                selectedButton = text;
              });
            },
          )).toList(),
        ),
      ),
    );
  }
}