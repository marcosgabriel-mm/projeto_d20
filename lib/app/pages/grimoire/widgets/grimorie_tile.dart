import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class GrimoireTile extends StatelessWidget {
  final bool prepared;
  final String name;
  final String level;
  final String castTime;
  final Function function;
  final Function onTap;

  const GrimoireTile({
    super.key, 
    required this.prepared, 
    required this.name, 
    required this.level, 
    required this.castTime, 
    required this.function, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      padding: const EdgeInsets.all(horizontalPadding),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 1
          )
        )
      ),
      child: ListTile(
        title: Text(
          name,
          style: TextStyles.instance.regular,
        ),
        subtitle: Text(
          "$level | $castTime",
          style: TextStyles.instance.regular,
        ),
        onTap: () => onTap(),
        trailing: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            prepared
            ? "assets/images/prepared_spells.png" 
            : "assets/images/knew_spells.png",
            height: 24,
            width: 24,
          ),
          onPressed: () => function(),
        ),
      ),
    );
  }
}