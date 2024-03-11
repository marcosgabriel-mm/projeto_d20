import 'package:d20_project/app/pages/dices/dices_view.dart';
import 'package:d20_project/app/pages/initiatives/initiatives_view.dart';
import 'package:d20_project/app/pages/navigation_bottom_bar.dart';
import 'package:d20_project/theme/theme_config.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  int _currentIndex = 0;
  bool _showBottomBar = true;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      InitiativeView(onSelectionModeChanged: () {
        setState(() {
          _showBottomBar = !_showBottomBar;
        });
      }),
      const Dices(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.theme,
      home: Scaffold(
        body: _currentIndex < _pages.length ? _pages[_currentIndex] : null,
        bottomNavigationBar: _showBottomBar ? BottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index < _pages.length) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
        ) : null,
      ),
    );
  }
}