import 'package:d20_project/app/pages/characters/widgets/fields.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Elements extends StatelessWidget {
  final String title;
  final String firstSubtitle;
  final String secondSubtitle;
  final String asset;
  final ValueChanged<String>? onTextChangedFistSubtitle;
  final ValueChanged<String>? onTextChangedSecondSubtitle;

  final double? width;
  final bool? justText;

  const Elements({
    super.key, 
    required this.title, 
    required this.asset, 
    required this.firstSubtitle, 
    required this.secondSubtitle, 
    this.onTextChangedFistSubtitle, 
    this.onTextChangedSecondSubtitle, 
    this.width, 
    this.justText, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset("assets/svg/character/first_border.svg", fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.all(horizontalPadding/2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: horizontalPadding/2),
                  child: SvgPicture.asset(asset),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyles.instance.regular.copyWith(fontSize: 10),
                    ),
                    Row(
                      children: [
                        TextFields(
                          fontSize: 10, 
                          text: firstSubtitle,
                          onTextChanged: onTextChangedFistSubtitle??(value){},
                        ),
                        Text(
                          ' | ',
                          style: TextStyles.instance.regular.copyWith(fontSize: 10),
                        ),
                        justText!=true
                        ? TextFields(
                          fontSize: 10, 
                          text: secondSubtitle,
                          onTextChanged: onTextChangedSecondSubtitle??(value){},
                        )
                        : Text(
                          secondSubtitle,
                          style: TextStyles.instance.regular.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}