import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  String? selectedButton = "Iniciativas";

  @override
  Widget build(BuildContext context) {
    var buttons = [
      "Iniciativas",
      "Dados",
      "Personagens",
      "Notas",
      "Equipamentos",
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        color: ThemeConfig.theme.primaryColor,
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: buttons.asMap().entries.map((entry) {
            var index = entry.key;
            var text = entry.value;

            return TextButton(
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
                  widget.onTap(index);
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}