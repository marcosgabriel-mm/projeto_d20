// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:d20_project/app/pages/characters/widgets/second_elements.dart';
import 'package:d20_project/app/pages/grimoire/widgets/grimorie_tile.dart';
import 'package:d20_project/app/pages/grimoire/widgets/stick_header.dart';
import 'package:d20_project/app/pages/spells/spells_details_view.dart';
import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/app/widgets/scroll_listener.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Grimoire extends StatefulWidget {
  final List<Map<dynamic, dynamic>> spells;
  final CharacterProvider characterProvider;
  
  const Grimoire({
    super.key,
    required this.spells, 
    required this.characterProvider,
  });

  @override
  State<Grimoire> createState() => _GrimoireState();
}


class _GrimoireState extends State<Grimoire> {
  final ScrollController _scrollController = ScrollController();
  String _labelStringSpell = "Magias Conhecidas";

  @override
  Widget build(BuildContext context) {

    Map<String, List<Map<dynamic, dynamic>>> spellsByLevel = {};
    for (var spell in widget.spells) {
      String level = spell['level'];
      if (!spellsByLevel.containsKey(level)) {
        spellsByLevel[level] = [];
      }
      spellsByLevel[level]!.add(spell);
    }

    return Consumer<CharacterProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: AppBar(
                title: Text("Grimório", style: TextStyles.instance.regular),
                scrolledUnderElevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: ColorsApp.instance.secondaryColor,
                            title: Text(
                              'SOBRE AS MAGIAS!', 
                              style: TextStyles.instance.regular,
                            ),
                            content: RichText(
                              text: TextSpan(
                                style: TextStyles.instance.regular, 
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'O conteúdo das magias foi traduzido automaticamente e pode conter erros. O conteúdo original pode ser encontrado em: \n\n',
                                  ),
                                  TextSpan(
                                    text: 'https://www.aidedd.org/dnd-filters/spells-5e.php \n\n',
                                    style: TextStyles.instance.regular.copyWith(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      launchUrl(Uri.parse('https://www.aidedd.org/dnd-filters/spells-5e.php'));
                                    },
                                  ),
                                  TextSpan(
                                    text: 'https://www.dndbeyond.com/spells',
                                    style: TextStyles.instance.regular.copyWith(color: Colors.blue),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      launchUrl(Uri.parse('https://www.dndbeyond.com/spells'));
                                    },
                                  ),
                                ],
                              ),
                            )
                          );
                        },
                      );
                    }, 
                    icon: const Icon(Icons.info_rounded)
                  )
                ],
              ),
            ),
          ),
          body: ScrollListerner(
            context: context,
            scrollController: _scrollController,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: verticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SecondElements(
                        asset: "assets/svg/character/cd.svg", 
                        title: widget.characterProvider.character.spellClass.toString(), 
                        label: "CD Magia", 
                        justText: false,
                        onTextChanged: (value) {
                          if (value.trim().isNotEmpty && int.tryParse(value.trim()) != null) {
                            widget.characterProvider.character.spellClass = int.parse(value);
                          }
                        }
                      ),
                      SecondElements(
                        asset: "assets/images/knew_spells.png", 
                        title: widget.spells.length.toString(), 
                        label: "Magias Conhecidas", 
                        justText: true,
                      ),
                      SecondElements(
                        asset: "assets/images/prepared_spells.png", 
                        title: widget.spells.where((element) => element["prepared"]).length.toString(), 
                        label: "Magias Preparadas", 
                        justText: true,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: horizontalPadding*2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image(
                            height: 24,
                            width: 24,
                            image: AssetImage(
                              _labelStringSpell == "Magias Conhecidas" 
                              ? "assets/images/knew_spells.png"
                              : "assets/images/prepared_spells.png"
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: horizontalPadding),
                            child: Text(
                              _labelStringSpell,
                              style: TextStyles.instance.regular,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _labelStringSpell = _labelStringSpell == "Magias Conhecidas" ? "Magias Preparadas" : "Magias Conhecidas";
                          });
                        }, 
                        icon: Icon(
                          _labelStringSpell == "Magias Conhecidas" 
                          ? Icons.switch_right 
                          : Icons.switch_left,
                        )
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: verticalPadding),
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: spellsByLevel.entries.map((entry) {

                        var filteredSpells = _labelStringSpell == "Magias Preparadas"
                            ? entry.value.where((spell) => spell["prepared"] == true).toList()
                            : entry.value;

                        if (_labelStringSpell == "Magias Preparadas" && filteredSpells.isEmpty) {
                          return const SliverToBoxAdapter(child: SizedBox.shrink());
                        }

                        return SliverStickyHeader(
                          header: StickHeader(
                            spellLevel: entry.key,
                            spellSlots: 4,
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                // Usar filteredSpells para construir os itens
                                var spell = filteredSpells[index];
                                return GrimoireTile(
                                  prepared: spell["prepared"],
                                  name: spell["name"],
                                  level: spell["level"],
                                  castTime: spell["casting_time"].split(', ')[0],
                                  function: () => widget.characterProvider.togglePreparedSpell(spell['name']),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SpellsDetails(
                                          spell: spell.cast<String, dynamic>()
                                        ),
                                      ),
                                    );
                                  }
                                );
                              },
                              childCount: filteredSpells.length,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        );
      }
    );
  }
}