import 'package:flutter/material.dart';

import 'menu_screen.dart';
import 'unity_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(key: null,),
        '/unity': (context) => const UnityScreen(key: null,),
      },
    );
  }
}
