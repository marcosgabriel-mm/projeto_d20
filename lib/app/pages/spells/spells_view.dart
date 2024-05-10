import 'package:d20_project/app/pages/spells/spells_details_view.dart';
import 'package:d20_project/app/pages/spells/widgets/spells_custom_row.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/spell_provider.dart';
import 'package:d20_project/app/widgets/add_button.dart';
import 'package:d20_project/app/widgets/appbar.dart';
import 'package:d20_project/app/widgets/scroll_listener.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      spellProvider.loadThirtySpells();
    }
  }

  @override
  Widget build(BuildContext context) {
    d20provider = context.watch<D20Provider>();
    spellProvider = context.watch<SpellProvider>();

    return Scaffold(
      appBar: ApplicationBar(
        areAllSelected: context.read<D20Provider>().areAllSelectedFromThatScreen(context),
        title: context.read<D20Provider>().currentRoute,
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.search)
          ),
          AddButton(
            function: (){},
          ),
          Padding(
            padding: const EdgeInsets.only(right: horizontalPadding),
            child: IconButton(
              onPressed: (){},
              icon: const Icon(Icons.tune)
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
        child: const Icon(Icons.keyboard_arrow_up),
      ),
      body: ScrollListerner(
        context: context,
        scrollController: _scrollController,
        child: ListView.builder(
            itemCount: spellProvider.spells.length,
            controller: _scrollController,
            itemBuilder: (context, index) => ListTile(
              title: SpellsRow(
              nameOfSpell: spellProvider.spells[index]["name"],
                castingTime: spellProvider.spells[index]["casting_time"].split(",")[0],
                levelOfSpell: spellProvider.spells[index]["level"]
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpellsDetails(
                      spell: spellProvider.spells[index],
                    ),
                  )
                );
              },
            )
          ),
      ),
    );
  }
}