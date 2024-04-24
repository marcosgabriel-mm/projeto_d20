import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRow extends StatelessWidget {
  final String diceName;
  final String diceDescription;
  final int diceCount;
  final String diceIcon;
  final int diceIndex;
  final IconData icon;

  const CustomRow(
      {super.key,
      required this.diceName,
      required this.diceDescription,
      required this.diceCount,
      required this.diceIcon,
      required this.diceIndex, 
      required this.icon
    });


  final double iconHeight = 24;
  final double iconWidth = 24;
  final double iconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: verticalPadding),
      padding: const EdgeInsets.fromLTRB(horizontalPadding, verticalPadding, horizontalPadding, verticalPadding),
      alignment: AlignmentDirectional.centerStart,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white60, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              if (context.read<D20Provider>().isSelectionMode) 
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Image(
                image: AssetImage(diceIcon),
                height: iconHeight,
                width: iconWidth,
              ),
              const SizedBox(width: horizontalPadding),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diceName,
                    style: TextStyles.instance.regular,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    diceDescription,
                    style: TextStyles.instance.regular.copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: !context.read<D20Provider>().isSelectionMode,
            replacement: const SizedBox.shrink(),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<DicesProvider>().removeDiceToRoll(diceIndex);
                    if (!context.read<DicesProvider>().isAnyDiceSelected){
                      context.read<D20Provider>().turnOffOrOnBottomBar();
                    }
                  },
                  icon: const Icon(Icons.remove),
                  iconSize: iconSize,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Text(
                    diceCount.toString(),
                    style: TextStyles.instance.regular,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<DicesProvider>().addDiceToRoll(diceIndex);
                    if (context.read<DicesProvider>().isAnyDiceSelected  && context.read<D20Provider>().toogleBottomBar){
                      context.read<D20Provider>().turnOffOrOnBottomBar();
                    }
                  },
                  icon: const Icon(Icons.add),
                  iconSize: iconSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
