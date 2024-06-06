import 'package:d20_project/app/pages/characters/widgets/fields.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Atribute extends StatelessWidget {
  final String atributeModificator;
  final String atributeName;
  final String atributeValue;
  final ValueChanged<String> onTextChanged;
  const Atribute({
    super.key, 
    required this.atributeModificator, 
    required this.atributeName, 
    required this.atributeValue, 
    required this.onTextChanged
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 150,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset("assets/svg/character/atribute_card.svg", fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Center(
              child: Column(
                children: [
                  Text(
                    atributeModificator,
                    style: TextStyles.instance.regular
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: verticalPadding+2),
                        child: TextFields( 
                          fontSize: TextStyles.instance.regular.copyWith(fontSize: 32).fontSize ?? 32, 
                          text: atributeValue,
                          onTextChanged: onTextChanged
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: verticalPadding),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: SvgPicture.asset("assets/svg/character/atribute_inside_border.svg", fit: BoxFit.fill),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding/2, vertical: 2),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  atributeName, 
                                  style: TextStyles.instance.regular.copyWith(fontSize: 12), 
                                  softWrap: false, overflow: TextOverflow.fade,
                                ),
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}