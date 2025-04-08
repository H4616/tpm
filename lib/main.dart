import 'package:flutter/material.dart';
//import pages

void main() {
  runApp(const SmartApp());
}

class SmartApp extends StatelessWidget {
  const SmartApp({super.key});

  // root aplikasi
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 217, 255, 0)),
        useMaterial3: true,
      ),
      home: //classlogin,
      routes: <String, WidgetBuilder>{
        //route pages
      },
    );
  }
}