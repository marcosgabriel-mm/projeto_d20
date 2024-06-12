import 'package:d20_project/app/pages/filters/filter_view.dart';
import 'package:d20_project/app/pages/spells/spells_details_view.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/filter_provider.dart';
import 'package:d20_project/app/providers/spell_provider.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/scroll_listener.dart';
import 'package:d20_project/styles/colors_app.dart';
import 'package:d20_project/styles/text_styles.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class SpellView extends StatefulWidget {
  const SpellView({super.key});

  @override
  State<SpellView> createState() => _SpellViewState();
}

class _SpellViewState extends State<SpellView> {
  final ScrollController _scrollController = ScrollController();
  late SpellProvider spellProvider;
  late D20Provider d20provider;

  @override
  void initState() {
    super.initState();
    context.read<SpellProvider>().initWithFifitySpells();
    _scrollController.addListener(_loadMoreSpells);
  }

  void _loadMoreSpells() async {

    if (
      _scrollController.position.pixels == _scrollController.position.maxScrollExtent 
      && !context.read<D20Provider>().onSearch 
      && context.read<FilterProvider>().selected.isEmpty
    ) {
      spellProvider.loadThirtySpells();
    }
  }

  @override
  Widget build(BuildContext context) {
    d20provider = context.watch<D20Provider>();
    spellProvider = context.watch<SpellProvider>();

    Map<String, List<Map<String, dynamic>>> spellsByLevel = {};
    for (var spell in spellProvider.spells) {
      String level = spell['level'];
      if (!spellsByLevel.containsKey(level)) {
        spellsByLevel[level] = [];
      }
      spellsByLevel[level]!.add(spell);
    }

    return Scaffold(
      appBar: ApplicationBar(
        areAllSelected: context.read<D20Provider>().areAllSelectedFromThatScreen(context),
        title: context.read<D20Provider>().currentRoute,
        onSearch: (value) {
          spellProvider.searchSpell(value);
        },
        actions: [
          IconButton(
            onPressed: (){
              d20provider.toggleSearch();
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )
          ),
          Padding(
            padding: const EdgeInsets.only(right: horizontalPadding),
            child: IconButton(
              onPressed: () async {
                var filters = await Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => FilterView(
                      filters: spellProvider.spellFilters,
                    ),
                  ),
                );
                if (filters != null) {
                  spellProvider.searchSpellByFilter(filters);
                }
              },
              icon: const Icon(
                Icons.tune,
                color: Colors.white,
              )
            ),
          ),
        ],
      ),
      floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
      floatingActionButton: d20provider.showFloatingButton ? const SizedBox.shrink() : FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        backgroundColor: ColorsApp.instance.secondaryColor,
        mini: true,

        child: const Icon(Icons.keyboard_arrow_up, color: Colors.white,),
      ),
      body: ScrollListerner(
        context: context,
        scrollController: _scrollController,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: spellsByLevel.entries.map((entry) {
            return SliverStickyHeader(
              header: Container(
                margin: const EdgeInsets.symmetric(horizontal: horizontalPadding-2),
                padding: const EdgeInsets.symmetric(horizontal: horizontalPadding*2, vertical: verticalPadding/2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorsApp.instance.secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  '${entry.key} | ${entry.value.length} magias',
                  style: TextStyles.instance.regular,
                ),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: horizontalPadding),
                    padding: const EdgeInsets.all(horizontalPadding),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(entry.value[index]['name'], style: TextStyles.instance.regular,),
                      subtitle: Text(entry.value[index]['level'] + " | " + entry.value[index]["casting_time"].split(', ')[0], style: TextStyles.instance.boldItalic,),
                      trailing: IconButton(
                        onPressed: () {
                          //todo adiconar magia para um personagem
                        },
                        icon: SvgPicture.asset("assets/svg/add-spell.svg"),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SpellsDetails(spell: entry.value[index]),
                          ),
                        );
                      
                      },
                    ),
                  ),
                  childCount: entry.value.length,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}