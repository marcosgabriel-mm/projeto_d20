import 'package:d20_project/app/pages/spells/widgets/additional_info.dart';
import 'package:d20_project/app/pages/spells/widgets/description.dart';
import 'package:d20_project/app/pages/spells/widgets/details_row.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

List<Map> spellImages = [
  {
    "field":"level",
    "image":"assets/images/level.png"
  },
  {
    "field":"casting_time",
    "image":"assets/images/cast.png"
  },
  {
    "field":"range",
    "image":"assets/images/range.png"
  },
  {
    "field":"components",
    "image":"assets/images/components.png"
  },
  {
    "field":"duration",
    "image":Icons.access_time
  },
  {
    "field":"school",
    "image":Icons.book
  },
  {
    "field":"description",
    "image":Icons.description
  }
  
];

class SpellsDetails extends StatelessWidget {
  final Map<String, dynamic> spell;
  SpellsDetails({
    super.key, 
    required this.spell
  });

  final List<String> keysToSplit = ["components", "range", "duration", "school", "casting_time"];

  @override
  Widget build(BuildContext context) {
    List<String> keys = spell.keys.toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: AppBar(
            title: Text(spell["name"], style: TextStyles.instance.regular.copyWith(fontSize: 20)),
            actions: [
              IconButton(
                onPressed: (){}, 
                icon: SvgPicture.asset("assets/svg/add-spell.svg")
              )
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: verticalPadding),
        children: [ 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int index=1; index<spell.keys.length-3; index+=2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      SizedBox(
                        width: 150,
                        child: DetailsRow(
                        text: keysToSplit.contains(keys[index]) 
                          ? spell[keys[index]].split(RegExp(r' \(|M, |, até|, que'))[0] 
                          : spell[keys[index]],
                        asset: spellImages.firstWhere((element) => element["field"] == keys[index], orElse: () => {"image": Icons.error})["image"]
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: DetailsRow(
                          text: keysToSplit.contains(keys[index+1]) 
                            ? spell[keys[index+1]].split(RegExp(r' \(|M, |, até|, que'))[0] 
                            : spell[keys[index+1]], 
                          asset: spellImages.firstWhere((element) => element["field"] == keys[index+1], orElse: () => {"image": Icons.error})["image"],
                        ),
                      )
                  ],
                ),
                AdditionalInfos( //!arrumar essa porra
                  data: [
                    for (int index=0; index<keys.length-3; index++)
                      MapEntry(
                        keysToSplit.contains(keys[index]) ? keys[index] : "", 
                        keysToSplit.contains(keys[index]) && spell[keys[index]].split(RegExp(r' \(|M, |, até')).length > 1
                        ? spell[keys[index]].split(RegExp(r' \(|M, |, até'))[1] 
                        : ""
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: horizontalPadding),
                  child: SpellDescription(
                    description: spell["description"],
                  ),
                ),
                //TODO - jogar pra outro lugar ou dois padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: horizontalPadding-9,
                    children: [
                      for (int index=0; index<spell["classes"].length; index++)
                      Container(
                        margin: const EdgeInsets.only(top: horizontalPadding, right: 9),
                        padding: const EdgeInsets.all(horizontalPadding-9),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Text(
                          spell["classes"][index],
                          style: TextStyles.instance.regular,
                          
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: horizontalPadding, right: 9),
                        padding: const EdgeInsets.all(horizontalPadding-9),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Text(
                          spell["book"],
                          style: TextStyles.instance.regular,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]
      )
    );
  }


}