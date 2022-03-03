import 'package:flutter/material.dart';

import 'menu_screen.dart';
import 'unity_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + Unity',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(key: null,),
        '/unity': (context) => const UnityScreen(key: null,),
      },
    );
  }
}
