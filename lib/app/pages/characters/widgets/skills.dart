import 'package:d20_project/app/pages/characters/widgets/fields.dart';
import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Skill extends StatelessWidget {
  final String skillName;
  final String skillValue;
  final String asset;
  final Color colors;
  final ValueChanged<String> onTextChanged;

  const Skill({
    super.key, 
    required this.skillName, 
    required this.skillValue, 
    required this.asset, 
    required this.colors, 
    required this.onTextChanged
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset("assets/svg/character/skill_border.svg", fit: BoxFit.fill, colorFilter: ColorFilter.mode(colors, BlendMode.srcIn)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(horizontalPadding/2),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: horizontalPadding/2),
                        child: GestureDetector(
                          onTap: () {
                            context.read<CharacterProvider>().toggleProeficient(skillName);
                            context.read<CharacterProvider>().addProeficiencyModifier(skillName);
                          },
                          child: SvgPicture.asset(
                            asset, 
                            colorFilter: ColorFilter.mode(
                              colors, BlendMode.srcIn
                            )
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          String result = context.read<DicesProvider>().rollASingleDice("1d20", int.parse(skillValue));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              showCloseIcon: true,
                              content: Text(
                                "Resultado da Proeficiência: $result",
                                style: TextStyles.instance.regular
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          alignment: Alignment.centerLeft,
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        child: Text(skillName, style: TextStyles.instance.regular.copyWith(fontSize: 9, color: colors))
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: skillValue.length > 1 ? horizontalPadding/5 : horizontalPadding/3
                ),
                child: TextFields(
                  fontSize: TextStyles.instance.regular.copyWith(fontSize: 14).fontSize ?? 14, 
                  text: skillValue,
                  onTextChanged: onTextChanged
                ),
              )
            ],
          )
        ],
      )
    );
  }
}