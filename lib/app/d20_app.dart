import 'package:d20_project/app/pages/characters/characters_view.dart';
import 'package:d20_project/app/pages/dices/dices_view.dart';
import 'package:d20_project/app/pages/initiatives/initiatives_view.dart';
import 'package:d20_project/app/pages/spells/spells_view.dart';
import 'package:d20_project/app/widgets/navigation_bottom_bar.dart';
import 'package:d20_project/app/pages/notes/notes_view.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late D20Provider d20Provider;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const InitiativeView(),
      const Dices(),
      const CharacterSheet(),
      const NotesView(),
      const SpellView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    d20Provider = context.watch<D20Provider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      home: Scaffold(
        body: d20Provider.currentIndex < _pages.length ? _pages[d20Provider.currentIndex] : null,
        bottomNavigationBar: d20Provider.toogleBottomBar
            ? BottomBar(
                currentIndex: d20Provider.currentIndex,
                onTap: (index) {
                  if (index < _pages.length) {
                    d20Provider.updateBottomMenuState(index);
                  }
                },
              )
            : null,
      ),
    );
  }
}
