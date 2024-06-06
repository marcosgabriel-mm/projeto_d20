import 'package:d20_project/app/widgets/bottom_buttons.dart';
import 'package:flutter/material.dart';

class SelectionBottomMenu extends StatelessWidget {
  final List textLabel;
  final List<IconData> icons;
  final List<Function> onPressed;
  const SelectionBottomMenu({
    super.key, 
    required this.textLabel, 
    required this.icons, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < textLabel.length; i++)
            BottomButtonMenu(
              textLabel: textLabel[i],
              icon: icons[i],
              onPressed: onPressed[i],
            ),
        ],
      ),
    );
  }
}
