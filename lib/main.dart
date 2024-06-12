// ignore_for_file: prefer_const_constructors
import 'package:d20_project/app/d20_app.dart';
import 'package:d20_project/app/providers/characters_provider.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/providers/filter_provider.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:d20_project/app/providers/spell_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_){
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => FilterProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => CharacterProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => SpellProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => NotesProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => DicesProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => InitiativesProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => D20Provider(),
            )
          ],
          child: const AppWidget(),
        ),
      );
    });
}
