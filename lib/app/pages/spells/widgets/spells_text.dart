import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SpellColumnText extends StatelessWidget {

  final String labelTextOne;
  final String labelTextTwo;
  final TextAlign textAlignment;
  final Alignment boxAlignment;

  const SpellColumnText({
    super.key, 
    required this.labelTextOne, 
    required this.labelTextTwo, 
    required this.textAlignment, 
    required this.boxAlignment
  });

  final sizedBoxWidth = 274.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: sizedBoxWidth,
          child: Text(
            labelTextOne,
            style: TextStyles.instance.regular,
            textAlign: textAlignment,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ),
        SizedBox(
          width: sizedBoxWidth,
          child: Text(
            labelTextTwo,
            style: TextStyles.instance.boldItalic,
            textAlign: textAlignment,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ),
      ],
    );
  }
}