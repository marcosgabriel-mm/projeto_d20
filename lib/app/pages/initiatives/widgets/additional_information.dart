import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdditionalInformation extends StatelessWidget {
  final String value;
  final String field;
  final String asset;
  const AdditionalInformation({super.key, required this.value, required this.asset, required this.field});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(asset, fit: BoxFit.fill,)
              ),
              Padding(
                padding: const EdgeInsets.all(horizontalPadding/2),
                child: Text(
                  value, 
                  style: TextStyles.instance.regular.copyWith(fontSize: 12),),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: verticalPadding/2),
            child: Text(field, style: TextStyles.instance.regular.copyWith(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}