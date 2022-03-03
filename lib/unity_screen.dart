import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityScreen extends StatefulWidget {
  const UnityScreen({Key? key}) : super(key: key);

  @override
  _UnityScreenState createState() => _UnityScreenState();
}

class _UnityScreenState extends State<UnityScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  late UnityWidgetController _unityWidgetController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Card(
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            UnityWidget(
              onUnityCreated: _onUnityCreated,
              onUnityMessage: onUnityMessage,
            ),
          ],
        ),
      ),
    );
  }

  void onUnityMessage(message) {
    if (kDebugMode) {
      print('Received message from unity: ${message.toString()}');
    }
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    if (kDebugMode) {
      print('Received scene loaded from unity: ${scene.name}');
    }
    if (kDebugMode) {
      print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
    }
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    _unityWidgetController = controller;
  }
}
