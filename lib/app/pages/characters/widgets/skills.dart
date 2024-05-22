import 'package:d20_project/app/providers/characters_provider.dart';
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
  const Skill({
    super.key, 
    required this.skillName, 
    required this.skillValue, 
    required this.asset, 
    required this.colors
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
                          onLongPress: () {
                            context.read<CharacterProvider>().toggleProeficient(skillName);
                          },
                          child: SvgPicture.asset(
                            asset, 
                            colorFilter: ColorFilter.mode(
                              colors, BlendMode.srcIn
                            )
                          ),
                        ),
                      ),
                      Text(skillName, style: TextStyles.instance.regular.copyWith(fontSize: 10, color: colors))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: horizontalPadding/6),
                child: Text(skillValue, style: TextStyles.instance.regular.copyWith(fontSize: 12, color: colors)),
              )
            ],
          )
        ],
      )
    );
  }
}