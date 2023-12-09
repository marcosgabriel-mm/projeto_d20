// ignore_for_file: file_names

import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class BattleItem extends StatelessWidget {
  final String nameItem;
  final TextAlign alignText;
  final Color color;
  final int valorDaIniciativa;

  final double height = 30;
  final double width = 70;

  const BattleItem({super.key, required this.nameItem, required this.color, required this.alignText, required this.valorDaIniciativa});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Text(
              nameItem,
              textAlign: alignText,
              style: TextStyles.instance.regular
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: Text(
              "INIC.\n $valorDaIniciativa",
              textAlign: alignText,
              style: TextStyles.instance.regular
            ),
          )
        ],
      ),
    );
  }
}
