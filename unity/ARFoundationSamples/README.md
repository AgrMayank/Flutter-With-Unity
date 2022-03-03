Configure the Flutter project 
Step 1: Open the pubspec.yaml file and add flutter_unity_widget to it under the dependencies section.
dependencies:
  flutter_unity_widget: ^3.0.3

We are using the flutter_unity_widget package to integrate our ARWAY Unity SDK with Flutter.
https://pub.dev/packages/flutter_unity_widget
Step 2: After adding the dependencies, you need to fetch them into your Flutter project. 
You can fetch the dependencies by -
From the terminal: Run flutter pub get.
OR
From Android Studio/IntelliJ: Click Packages get in the action ribbon at the top of pubspec.yaml.
From VS Code: Click Get Packages located on the right side of the action ribbon at the top of pubspec.yaml.
Step 3: Then add an import statement for using the package inside your Dart code.
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
We have created sample Dart files with unity pre-integrated to help you get started quickly with the project. The Dart files are located in the lib folder within the Flutter project.