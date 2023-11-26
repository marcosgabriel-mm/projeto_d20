
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 27, 30, 34),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white
            )
          ),
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 27, 30, 34),
            onPressed: () => {},
            child: SvgPicture.asset("lib/images/BotaoFlutuante.svg"),
          ),
        ),
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "lib/images/Iniciativa.svg",
                fit: BoxFit.cover,
                width: 25,
                height: 25,
              ),
              SizedBox(height: 8),
              Text(
                "INICIATIVAS",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Fraunces'
                ),
              )
            ],
          ),
          centerTitle: true,
          toolbarHeight: 100,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 27, 30, 34),
          leading: IconButton(
            onPressed: () => {}, 
            icon: Icon(Icons.arrow_back),
            tooltip: "Voltar",
          ),
          actions: <Widget> [
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.add),
              tooltip: "Adicionar",
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 15,
              margin: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.white
              //   ),
              // ),
              child: SvgPicture.asset(
                "lib/images/BarraSuperior.svg",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.white)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    "lib/images/CampoDeBatalha.svg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}