// ignore_for_file: prefer_const_constructors
import 'package:d20_project/app/d20_app.dart';
import 'package:d20_project/app/providers/d20_provider.dart';
import 'package:d20_project/app/providers/dices_provider.dart';
import 'package:d20_project/app/providers/initiatives_provider.dart';
import 'package:d20_project/app/providers/notes_provider.dart';
import 'package:d20_project/app/providers/players_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
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
          create: (context) => PlayersProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => D20Provider(),
        )
        // Adicione mais providers aqui...
      ],
      child: const AppWidget(),
    ),
  );
}
