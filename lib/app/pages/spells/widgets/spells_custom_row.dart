import 'package:d20_project/app/pages/spells/widgets/spells_text.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SpellsRow extends StatelessWidget {

  final String nameOfSpell;
  final String castingTime;
  final String levelOfSpell;

  const SpellsRow({
    super.key, 
    required this.nameOfSpell, 
    required this.castingTime, 
    required this.levelOfSpell
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(vertical: verticalPadding),
            padding: const EdgeInsets.fromLTRB(horizontalPadding, verticalPadding, horizontalPadding, verticalPadding),
            alignment: AlignmentDirectional.centerStart,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white60, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SpellColumnText(
                  labelTextOne: nameOfSpell, 
                  labelTextTwo: "$castingTime | $levelOfSpell", 
                  textAlignment: TextAlign.start,
                  boxAlignment: Alignment.centerLeft,
                ),
                IconButton(
                  onPressed: (){},
                  icon: SvgPicture.asset("assets/svg/add-spell.svg"),
                )
              ],
            ),
          );
  }
}