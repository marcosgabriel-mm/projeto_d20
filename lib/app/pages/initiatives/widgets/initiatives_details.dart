import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InitiativesDetails extends StatelessWidget {
  final List<String> damagesTypes;
  final String title;
  const InitiativesDetails({super.key, required this.damagesTypes, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title    |   ",
            style: TextStyles.instance.regular.copyWith(fontSize: 12),
            
          ),
          SizedBox(
            width: 100,
            child: Wrap(
              spacing: horizontalPadding/2,
              runSpacing: verticalPadding/2,
              children: [
                for (var resistance in damagesTypes)
                SizedBox(
                  width: 12,
                  height: 12,
                  child: SvgPicture.asset("assets/svg/damage_types/${resistance.toLowerCase()}.svg")
                ),
                if (damagesTypes.isEmpty)
                Text("Nenhuma", style: TextStyles.instance.regular.copyWith(fontSize: 12))
              ],
            ),
          )
        ],
      ),
    );
  }
}