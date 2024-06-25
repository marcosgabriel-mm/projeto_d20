import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class StickHeader extends StatelessWidget {
  final String spellLevel;
  final int spellSlots;
  final double size = 24;
  const StickHeader({super.key, required this.spellLevel, required this.spellSlots});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: horizontalPadding-2),
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding*2, vertical: verticalPadding/2),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: ColorsApp.instance.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            spellLevel,
            style: TextStyles.instance.regular,
          ),
          Row(
            children: [
              for (int index=0; index < spellSlots; index++)
              Container(
                width: size,
                height: size,
                margin: EdgeInsets.only(right: index < 3 ? horizontalPadding/2 : 0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    //todo verificar se o slot está ocupado ou não
                    false 
                    ? Icons.circle
                    : Icons.circle_outlined,
                    color: Colors.white,
                    size: size,
                  ),
                  onPressed: () {
                    //todo ao clicar, usar slot de magia
                  },
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}