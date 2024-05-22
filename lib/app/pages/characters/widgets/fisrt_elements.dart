import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Elements extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String asset;
  final double? width;

  const Elements({
    super.key, 
    required this.title, 
    required this.asset, 
    this.subtitle,
    this.width, 
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
                Text("$title\n$subtitle", style: TextStyles.instance.regular.copyWith(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}