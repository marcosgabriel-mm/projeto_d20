import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class AdditionalInfos extends StatelessWidget {
  final List<MapEntry<String, String>> data;
  const AdditionalInfos({super.key, required this.data,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(
          color: Colors.white
        ))
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        expandedAlignment: Alignment.centerLeft,
        title: Row(
          children: [
            const Icon(Icons.description, color: Colors.white,),
            Padding(
              padding: const EdgeInsets.only(left: horizontalPadding),
              child: Text("Informação Adicional", style: TextStyles.instance.regular,),
            )
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_down, color: Colors.white,),
        children: [
          for (int index=0; index<data.length; index++)
          Row(
            children: [
              data[index].key.isEmpty 
              ? const SizedBox.shrink() 
              : Padding(
                padding: const EdgeInsets.only(left: horizontalPadding, top: horizontalPadding, bottom:  horizontalPadding),
                child: Text(
                    "${data[index].key}: ",
                    style: TextStyles.instance.regular
                  ),
              ),
              data[index].value.isEmpty 
              ? const SizedBox.shrink() 
              : Padding(
                padding: const EdgeInsets.only(right: horizontalPadding),
                child: Flexible(
                  child: Text(
                    data[index].value,
                    textAlign: TextAlign.start,
                    style: TextStyles.instance.regular
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}