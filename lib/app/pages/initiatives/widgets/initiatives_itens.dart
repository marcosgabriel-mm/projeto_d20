
import 'package:d20_project/app/pages/initiatives/widgets/initiatives_column_text.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class ItensNames extends StatelessWidget {
  final String playerName;
  final String playerClass;
  final TextAlign alignText;
  final int initiatives;
  final bool isSelectionMode;
  final IconData icon;


  const ItensNames({
    super.key, 
    required this.playerName, 
    required this.playerClass,
    required this.alignText, 
    required this.initiatives, 
    required this.isSelectionMode, 
    required this.icon, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(vertical: verticalPadding),
            padding: const EdgeInsets.fromLTRB(horizontalPadding, verticalPadding, horizontalPadding, verticalPadding),
            alignment: AlignmentDirectional.centerStart,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white60,
                  width: 1)
              )
            ),  
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextColumn(
                  isSelectionMode: isSelectionMode,
                  title: playerName, 
                  value: playerClass,
                  alignText: alignText,
                  icon: icon,
                ),
                CustomTextColumn(
                  isSelectionMode: false,
                  title: "Iniciativa", 
                  value: initiatives.toString(), 
                  alignText: alignText,
                  icon: icon,
                )
              ],
            ),
    );
  }
}