import 'package:d20_project/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  
  final String diceName;
  final String diceDescription;
  final int diceCount;
  final String diceIcon;

  const CustomRow({
    super.key, 
    required this.diceName, 
    required this.diceDescription, 
    required this.diceCount, 
    required this.diceIcon
  });

  final double height = 100;
  final double horizontal = 18;
  final double vertical = 26;

  final double iconHeight = 24;
  final double iconWidth = 24;
  final double iconSize = 24;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(vertical: vertical),
      padding:  EdgeInsets.fromLTRB(horizontal, vertical, horizontal, vertical),
      alignment: AlignmentDirectional.centerStart,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white60,
            width: 1)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image(image: AssetImage(diceIcon), height: iconHeight, width: iconWidth,),
              SizedBox(width: horizontal),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(diceName, style: TextStyles.instance.regular,),
                  Text(diceDescription, style: TextStyles.instance.regular.copyWith(fontSize: 12),),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.remove), iconSize: iconSize,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontal),
                child: Text(diceCount.toString(), style: TextStyles.instance.regular,),
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.add), iconSize: iconSize,),
            ],
          ),
        ],
      ),
    );
  }
}