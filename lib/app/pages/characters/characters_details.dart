import 'package:d20_project/app/pages/characters/widgets/atributes.dart';
import 'package:d20_project/app/pages/characters/widgets/fields.dart';
import 'package:d20_project/app/pages/characters/widgets/fisrt_elements.dart';
import 'package:d20_project/app/pages/characters/widgets/second_elements.dart';
import 'package:d20_project/app/pages/characters/widgets/skills.dart';
import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/files_provider.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
class CharacterDetails extends StatefulWidget {
  final String fullPath;
  final int index;
  const CharacterDetails({
    super.key, 
    required this.fullPath, 
    required this.index
  });

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  late D20Provider d20provider;
  late CharacterProvider characterProvider;
  bool _isExpanded = true;
  String _atributeLabel = "Atributos do personagem";

  @override
  void initState() {
    super.initState();
    characterProvider = context.read<CharacterProvider>();

    Future.microtask(() async {
      if (widget.index == -1 && widget.fullPath.isEmpty) {
        characterProvider.character = characterProvider.characterDefault;
      } else {
        Map<String, dynamic> json = await FilesProvider().getJson(widget.fullPath);
        characterProvider.loadCharacter(json);
      }
    });
  }

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
            scrolledUnderElevation: 0,
            title: Column(
              children: [
                TextFields(
                  fontSize: TextStyles.instance.regular.fontSize!,
                  text: characterProvider.character.name,
                  onTextChanged: (value) {
                    characterProvider.character.name = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFields(
                      fontSize: 14,
                      text: characterProvider.character.race,
                      onTextChanged: (value) {
                        characterProvider.character.race = value;
                      },
                    ),
                    Text(" | ", style: TextStyles.instance.regular.copyWith(fontSize: 14),),
                    TextFields(
                      fontSize: 14,
                      text: characterProvider.character.classType,
                      onTextChanged: (value) {
                        characterProvider.character.classType = value;
                      },
                    ),
                  ],
                )
              ],
            ),
            actions: [
              IconButton(
                onPressed: (){
                  if (widget.index == -1) {
                    FilesProvider().saveNewJson(characterProvider.character);
                    Navigator.pop(context);
                  } else {
                    FilesProvider().saveExistentJson(widget.index, characterProvider.character);
                    Navigator.pop(context);
                  }
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
                  firstSubtitle: characterProvider.character.currentHitPoints.toString(),
                  secondSubtitle: characterProvider.character.maxHitPoints.toString(),
                  asset: "assets/svg/character/life_heart.svg",
                  width: 155,
                  justText: false,
                  onTextChangedFistSubtitle: (value) {
                    if (value.trim().isNotEmpty && int.tryParse(value.trim()) != null) {
                      characterProvider.character.currentHitPoints = int.parse(value);
                    }
                  },
                  onTextChangedSecondSubtitle: (value) {
                    if (value.trim().isNotEmpty && int.tryParse(value.trim()) != null) {
                      characterProvider.character.maxHitPoints = int.parse(value);
                    }
                  },
                ),
                Elements(
                  title: "Experiencia | Nível", 
                  firstSubtitle: characterProvider.character.experience.toString(),
                  secondSubtitle: characterProvider.character.level.toString(),
                  asset: "assets/svg/character/experience.svg",
                  width: 155,
                  justText: true,
                  onTextChangedFistSubtitle: (value) {
                    characterProvider.updateLevel(value);
                  },
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
                  // title: index == 5 && characterProvider.character.primaryStats.keys.elementAt(index) == "Percepção Passiva" ? characterProvider.calculatePassivePerception().toString() : characterProvider.character.primaryStats.values.elementAt(index).toString(),
                  label: characterProvider.character.primaryStats.keys.elementAt(index), 
                  justText: index == 1 ? true : false,
                  onTextChanged: (value) {
                    if (value.trim().isNotEmpty && int.tryParse(value.trim()) != null) {
                      characterProvider.character.primaryStats[characterProvider.character.primaryStats.keys.elementAt(index)] = int.parse(value.trim());
                    }
                  }
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
                          Text(_atributeLabel, style: TextStyles.instance.regular)
                        ],
                      ),
                      IconButton(onPressed: (){
                        setState(() {
                          if (_atributeLabel == "Atributos do personagem") {
                            _atributeLabel = "Salvaguardas";
                          } else {
                            _atributeLabel = "Atributos do personagem";
                          }
                        });
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
                    //todo mudar para salvaguardas
                    for (int index=0; index<characterProvider.character.stats.length; index++)
                    Atribute(
                      atributeName: characterProvider.character.stats.keys.elementAt(index),
                      atributeValue: characterProvider.character.stats.values.elementAt(index).toString(),
                      atributeModificator: characterProvider.calcutateModificator(characterProvider.character.stats.values.elementAt(index)).toString(),
                      onTextChanged: (value) {
                        characterProvider.updateAtributes(value, index);
                      },
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
                  Tooltip(
                    message: "Auto completar campos",
                    child: IconButton(
                      onPressed: (){
                        characterProvider.autoCompleteProeficiencyModifierFields();
                      },
                      icon: const Icon(Icons.drive_file_rename_outline, color: Colors.white),
                    ),
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
                    for (int index = 0; index < characterProvider.character.skills.keys.length; index++)
                    Skill(
                      skillName: characterProvider.character.skills.keys.elementAt(index),
                      skillValue: (characterProvider.character.skills.values.elementAt(index) as Map<String, dynamic>)['valor'].toString(),
                      asset: characterProvider.assetsRoutes[0][characterProvider.character.skills.keys.elementAt(index)] ?? "assets/svg/skills/question_mark.svg",
                      colors: characterProvider.isProeficient(characterProvider.character.skills.keys.elementAt(index)) ? Colors.white : Colors.white30,
                      onTextChanged: (value) {
                        characterProvider.updateSkills(value, index);
                      },
                    )
                  ],
                ),
              ] 
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
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: horizontalPadding,
              runSpacing: verticalPadding,
              children: [
                for (int index=0; index<characterProvider.assetsRoutes[2].length; index++)
                GestureDetector(
                  onTap: () {
                    //todo abrir tela de grimorio, equipamentos e mochila
                    debugPrint("index: $index");
                  },
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      children: [
                        SvgPicture.asset(characterProvider.assetsRoutes[2].values.elementAt(index)),
                        Padding(
                          padding: const EdgeInsets.only(left: horizontalPadding/2),
                          child: Text(characterProvider.assetsRoutes[2].keys.elementAt(index), style: TextStyles.instance.regular),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: horizontalPadding*2),
            padding: const EdgeInsets.symmetric(vertical: verticalPadding), 
            child: Column(
              children: [
                  Row(
                    children: [
                      const Icon(Icons.description),
                      Padding(
                        padding: const EdgeInsets.only(left: horizontalPadding/2),
                        child: Text("Sobre o personagem", style: TextStyles.instance.regular),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: verticalPadding),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white)
                      ),
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: TextEditingController(text: characterProvider.character.description),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          border: InputBorder.none,
                          hintText: "Escreva sobre o personagem...",
                          hintStyle: TextStyles.instance.regular.copyWith(color: Colors.white30),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (value) {
                          characterProvider.character.description = value;
                        },
                        onTapOutside: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        style: TextStyles.instance.regular,
                        maxLines: null,
                      ),
                    ),
                  )
                ],
              ), 
          )
        ],
      ),
    );
  }
}