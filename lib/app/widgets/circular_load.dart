import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class CircularLoad extends StatelessWidget {
  final String labelLoading;
  const CircularLoad({super.key, required this.labelLoading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: ColorsApp.instance.secondaryColor,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top: verticalPadding),
            child: Text(labelLoading , style: TextStyles.instance.regular,)
          )
        ],
      ),
    );
  }
}