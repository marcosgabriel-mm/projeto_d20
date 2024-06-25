import 'package:d20_project/app/pages/characters/widgets/fields.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SecondElements extends StatelessWidget {
  final String asset;
  final String title;
  final String label;
  final bool? justText;
  final ValueChanged<String> onTextChanged;
  
  const SecondElements({
    super.key, 
    required this.asset, 
    required this.title, 
    required this.label, 
    required this.onTextChanged, 
    this.justText
  });

  @override
  Widget build(BuildContext context) {
    bool isPng = asset.contains(".png");
    return SizedBox(
      width: 85,
      height: 45,
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset("assets/svg/character/second_border.svg", fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.all(horizontalPadding/2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Tooltip(
                  message: label,
                  child: isPng 
                    ? Image(
                      height: 24,
                      width: 24,
                      image: AssetImage(asset)
                    )
                    : SvgPicture.asset(asset,)
                ),
                justText!=false 
                ? Text(
                  title,
                  style: TextStyles.instance.regular,
                ) 
                : TextFields(
                  fontSize: TextStyles.instance.regular.fontSize ?? 16, 
                  text: title,
                  onTextChanged: onTextChanged
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}