import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final String title = 'Open Unity';
  final String route = '/unity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unity Flutter Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Example scene to show how to link Unity scenes with '
                'Flutter.',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 2,
                  wordSpacing: 5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(
              height: 96,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(route);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: const Color(0xFF1AB146),
                  minimumSize: const Size(192, 64),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
