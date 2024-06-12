import 'package:flutter/material.dart';

import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';

class DetailsRow extends StatelessWidget {
  final String text;
  final dynamic asset;

  final bool isString;
  final String image;
  final Icon icon;

  DetailsRow({
    super.key, 
    required this.text, 
    required this.asset
  })  : isString = asset is String,
        image = asset is String ? asset : '',
        icon = asset is IconData ? Icon(asset) : const Icon(Icons.error);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Row(
        children: [
          if (isString)
            Image.asset(image)
          else
            icon,
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: horizontalPadding),
              child: Text(
                text,
                style: TextStyles.instance.regular,
                overflow: TextOverflow.visible),
            ),
          )
        ],
      ),
    );
  }

}
