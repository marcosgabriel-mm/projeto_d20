import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomBar({
    super.key, 
    required this.currentIndex, 
    required this.onTap
  });

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {

  @override
  Widget build(BuildContext context) {
    
    String? selectedButton;
    var buttons = [
      "Iniciativas",
      "Dados",
      "Personagens",
      "Anotações",
      "Magias",
    ];

    for (var i = 0; i < buttons.length; i++) {
      if (i == widget.currentIndex) {
        selectedButton = buttons[i];
      }
    }

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
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  foregroundColor: WidgetStateProperty.all(
                    text == selectedButton ? Colors.white : Colors.white30,
                  ),
                  overlayColor: WidgetStateProperty.all(
                    text == selectedButton
                        ? Colors.white.withOpacity(0.1)
                        : null,
                  ),
                  textStyle:
                      WidgetStatePropertyAll(TextStyles.instance.regular)),
              child: Text(text),
              onPressed: () {
                setState(() {
                  selectedButton = text;
                  context.read<D20Provider>().updateCurrentRoute(selectedButton!);
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
