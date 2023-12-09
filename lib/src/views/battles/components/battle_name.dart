import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BattleName extends StatelessWidget {
  const BattleName({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/svg/Dragon.svg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              child: Text(
                "GRANDE BATALHA\nTURNO 10",
                textAlign: TextAlign.center,
                style: TextStyles.instance.regular
              ),
            ),
          ),
          SvgPicture.asset("assets/svg/DragonFliped.svg")
        ],
      ),
    );
  }
}
