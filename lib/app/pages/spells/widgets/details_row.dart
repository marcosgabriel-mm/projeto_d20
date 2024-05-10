// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';

class DetailsRow extends StatelessWidget {
  final String text;
  final dynamic asset;

  bool isString;
  String image;
  Icon icon;

  DetailsRow({Key? key, required this.text, required this.asset})
      : isString = asset is String ? true : false,
        image = asset is String ? asset : '',
        icon = asset is IconData ? Icon(asset) : const Icon(Icons.error),
        super(key: key);

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
