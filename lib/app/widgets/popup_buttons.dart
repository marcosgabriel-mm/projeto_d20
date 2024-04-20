import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class PopupButtons extends StatelessWidget {
  final String textLabel;
  final BuildContext context;
  final List<Function>? listOfComands;

  const PopupButtons({
    super.key, 
    required this.textLabel, 
    this.listOfComands, 
    required this.context
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
          onPressed: () {
            if (listOfComands != null) {
              for (var comand in listOfComands!) {
                comand();
              }
            }
            Navigator.pop(context);
          },
          child: Text(
            textLabel,
            style: TextStyles.instance.boldItalic,
          ),
        );
  }
}