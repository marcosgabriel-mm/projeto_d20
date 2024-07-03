import 'package:d20_project/app/pages/characters/widgets/fields.dart';
import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Atribute extends StatelessWidget {

  final ValueChanged<String> onTextChanged;
  final String atributeModificator;
  final String atributeName;
  final String atributeValue;
  final bool saveTrhow;
  final String titleMode;
  final Function() onTap;

  const Atribute({
    super.key, 
    required this.atributeModificator, 
    required this.atributeName, 
    required this.atributeValue, 
    required this.onTextChanged, 
    required this.saveTrhow, 
    required this.titleMode, required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (titleMode == "Salvaguardas") {
          onTap();
          debugPrint("Salvaguardas");
        }
      },
      child: SizedBox(
        width: 90,
        height: 150,
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/svg/character/atribute_card.svg", 
                fit: BoxFit.fill,
                colorFilter: titleMode == "Salvaguardas"
                  ? saveTrhow 
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) 
                  : const ColorFilter.mode(Colors.white30, BlendMode.srcIn)
                : const ColorFilter.mode(Colors.white, BlendMode.srcIn) 
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Center(
                child: Column(
                  children: [
                    titleMode == "Salvaguardas"
                    ? SizedBox(height: TextStyles.instance.regular.fontSize)
                    : Text(
                      atributeModificator,
                      style: TextStyles.instance.regular
                    ),
                    Column(
                      children: [
                        titleMode == "Salvaguardas" 
                        ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: verticalPadding+2),
                          child: Text(
                            saveTrhow ? (int.parse(atributeModificator)+context.read<CharacterProvider>().character.primaryStats['Bônus de Proficiência']!).toString() : atributeModificator,
                            style: TextStyles.instance.regular.copyWith(fontSize: 32),
                          ),
                        ) 
                        : Padding(
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
                                child: SvgPicture.asset(
                                  "assets/svg/character/atribute_inside_border.svg", 
                                  fit: BoxFit.fill,
                                  colorFilter: titleMode == "Salvaguardas"
                                    ? saveTrhow 
                                    ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) 
                                    : const ColorFilter.mode(Colors.white30, BlendMode.srcIn)
                                  : const ColorFilter.mode(Colors.white, BlendMode.srcIn) 
                                ),
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
      ),
    );
  }
}