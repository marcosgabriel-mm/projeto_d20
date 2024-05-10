import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

//todo arruma quebras de linhas
class SpellDescription extends StatelessWidget {
  final String description;
  const SpellDescription({super.key, required this.description});
  
  @override
  Widget build(BuildContext context) {
    String descriptionWithLineBreaks = '';
    int count = 0;

    for (int i = 0; i < description.length; i++) {
      descriptionWithLineBreaks += description[i];
      if (description[i] == '.') {
        count++;
        if (count == 2) {
          descriptionWithLineBreaks += '\n\n';
          count = 0;
        }
      }
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(
          color: Colors.white
        ))
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        expandedAlignment: Alignment.centerLeft,
        title: Row(
          children: [
            const Icon(Icons.description, color: Colors.white,),
            Padding(
              padding: const EdgeInsets.only(left: horizontalPadding),
              child: Text("Descrição", style: TextStyles.instance.regular,),
            )
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.white,),
        children: [
          Padding(
            padding: const EdgeInsets.all(horizontalPadding),
            child: Text(
              descriptionWithLineBreaks,
              textAlign: TextAlign.start,
              style: TextStyles.instance.regular
            ),
          )
        ],
      ),
    );
  }
}