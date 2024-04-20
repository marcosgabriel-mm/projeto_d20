import 'package:d20_project/app/widgets/bottom_buttons.dart';
import 'package:flutter/material.dart';

class SelectionBottomMenu extends StatelessWidget {
  final List textLabel;
  final List<IconData> icons;
  const SelectionBottomMenu({
    super.key, required this.textLabel, required this.icons,
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
            ),
        ],
      ),
    );
  }
}
