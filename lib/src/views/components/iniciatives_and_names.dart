// ignore_for_file: file_names

import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class ItensNames extends StatelessWidget {
  final String nameItem;
  final TextAlign alignText;
  final Color color;
  final int valorDaIniciativa;

  final double height = 100;

  const ItensNames({
    super.key, 
    required this.nameItem, 
    required this.color, 
    required this.alignText, 
    required this.valorDaIniciativa
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            padding: const EdgeInsets.fromLTRB(18, 26, 18, 26),
            alignment: AlignmentDirectional.centerStart,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),  
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nameItem,
                  textAlign: alignText,
                  style: TextStyles.instance.regular,
                ),
                Text(
                  "INICIATIVA\n $valorDaIniciativa",
                  textAlign: alignText,
                  style: TextStyles.instance.regular,
                ),
              ],
            ),
    );
  }
}
