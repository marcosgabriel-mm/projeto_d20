import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class TileInformation extends StatelessWidget {
  final String text;
  final String label;

  const TileInformation({super.key, required this.text, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyles.instance.regular,
        ),
        Text(
          text,
          style: TextStyles.instance.boldItalic,
        ),
      ],
    );
  }
}