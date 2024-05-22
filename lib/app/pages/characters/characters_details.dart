import 'package:d20_project/app/pages/characters/widgets/atributes.dart';
import 'package:d20_project/app/pages/characters/widgets/fisrt_elements.dart';
import 'package:d20_project/app/pages/characters/widgets/second_elements.dart';
import 'package:d20_project/app/pages/characters/widgets/skills.dart';
import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CharacterDetails extends StatefulWidget {
  const CharacterDetails({super.key});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
    late D20Provider d20provider;
    late CharacterProvider characterProvider;
    bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    d20provider = context.watch<D20Provider>();
    characterProvider = context.watch<CharacterProvider>();
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: AppBar(
            title: Column(
              children: [
                Text(characterProvider.character.name, style: TextStyles.instance.regular,),
                Text('${characterProvider.character.race} | ${characterProvider.character.classType}', style: TextStyles.instance.regular.copyWith(fontSize: 14),)
              ],
            ),
            actions: [
              IconButton(
                onPressed: (){
                  //todo salvar personagem em um arquivo json
                },
                icon: const Icon(Icons.done)
              )
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: verticalPadding*2),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: horizontalPadding*2),
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Elements(
                  title: "Vida Atual | Maxima", 
                  subtitle: "${characterProvider.character.currentHitPoints} | ${characterProvider.character.maxHitPoints}",
                  asset: "assets/svg/character/life_heart.svg",
                  width: 150,
                ),
                Elements(
                  title: "Experiencia | Nível", 
                  subtitle: "${characterProvider.character.experience} | ${characterProvider.character.level}",
                  asset: "assets/svg/character/experience.svg",
                  width: 150,
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: horizontalPadding*2),
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: horizontalPadding,
              runSpacing: horizontalPadding,
              children: [
                for (int index=0 ; index<characterProvider.character.primaryStats.length; index++)
                SecondElements(
                  asset: characterProvider.assetsRoutes[1][characterProvider.character.primaryStats.keys.elementAt(index)] ?? "assets/svg/character/initiatives.svg", 
                  title: characterProvider.character.primaryStats.values.elementAt(index).toString(), 
                  label: characterProvider.character.primaryStats.keys.elementAt(index), 
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: horizontalPadding*2),
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white)
              )
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: verticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: horizontalPadding/2),
                            child: SvgPicture.asset("assets/svg/character/atributes_icon.svg"),
                          ),
                          Text("Atributos", style: TextStyles.instance.regular)
                        ],
                      ),
                      IconButton(onPressed: (){
                        //todo mudar para salvaguardas
                      }, 
                      icon: const Icon(Icons.switch_right))
                    ],
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: horizontalPadding,
                  runSpacing: verticalPadding,
                  children: [
                    for (int index=0; index<characterProvider.character.stats.length; index++)
                    Atribute(
                      atributeName: characterProvider.character.stats.keys.elementAt(index),
                      atributeValue: characterProvider.character.stats.values.elementAt(index).toString(),
                      atributeModificator: characterProvider.calcutateModificator(characterProvider.character.stats.values.elementAt(index)).toString()
                    )
                  ],
                ),
              ],
            )
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: horizontalPadding*2),
            padding: const EdgeInsets.symmetric(vertical: verticalPadding),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white)
              )
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              collapsedIconColor: Colors.white,
              tilePadding: const EdgeInsets.only(bottom: verticalPadding),
              iconColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: horizontalPadding/2),
                        child: SvgPicture.asset("assets/svg/character/proeficiency.svg"),
                      ),
                      Text("Perícias", style: TextStyles.instance.regular)
                    ],
                  ),
                  if (_isExpanded)
                  IconButton(
                    onPressed: (){
                      //todo preencher pericias automaticamente com base nos atributos
                    },
                    icon: const Icon(Icons.drive_file_rename_outline, color: Colors.white),
                  )
                ],
              ),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded = expanded;
                });
              },
              children:[
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: horizontalPadding,
                  runSpacing: verticalPadding,
                  children: [
                    for (int i = 0; i < characterProvider.character.skills.keys.length; i++)
                    Skill(
                      skillName: characterProvider.character.skills.keys.elementAt(i),
                      skillValue: (characterProvider.character.skills.values.elementAt(i) as Map<String, dynamic>)['valor'].toString(),
                      asset: characterProvider.assetsRoutes[0][characterProvider.character.skills.keys.elementAt(i)] ?? "",
                      colors: characterProvider.isProeficient(characterProvider.character.skills.keys.elementAt(i)) ? Colors.white : Colors.white30,
                    )
                  ],
                ),
              ] 
            )
          )
        ],
      ),
    );
  }
}