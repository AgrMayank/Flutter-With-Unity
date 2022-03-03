# flutterwithunity

## Installation [\#](https://pub.dev/packages/flutter_unity_widget#installation)

First depend on the library by adding this to your packages
`pubspec.yaml`:

    dependencies:
      flutter_unity_widget: ^2020.3.25

Now inside your Dart code you can import it.

    import 'package:flutter_unity_widget/flutter_unity_widget.dart';

## Setup [\#](https://pub.dev/packages/flutter_unity_widget#setup)

### 1. <ins>Prerequisites</ins> [\#](https://pub.dev/packages/flutter_unity_widget#prerequisites)

  - An existing Flutter project (if there is none, you can [create a new    one](https://flutter.dev/docs/get-started/test-drive#create-app))

  - An existing Unity project (if there is none, you can [create a new
    one](https://learn.unity.com/tutorial/create-your-first-unity-project)).

  - A
    `FlutterUnityPackage.unitypackage`
    file (you can download the Unity packages
    [*here*](https://github.com/juicycleff/flutter-unity-view-widget/tree/master/scripts))

### 2. <ins>NDK</ins>

If your project requires Android NDK, you have to setup following:

Your android project needs to know the path of the NDK Unity uses. You
can find the path to the NDK under `Preferences -> External Tools`:

![NDK
Path](./flutter_unity_widget%20_%20Flutter%20Package_files/ndkPath.png)

Copy the path by right click and paste the path here in your
`android/local.properties`:

```
ndk.dir=/Applications/Unity/Hub/Editor/2020.3.19f1/PlaybackEngines/AndroidPlayer/NDK
```

That's it\! You don't need to tell your Android App in your
`app/build.gradle` the NDK version or other NDK settings. It's all
connected to Unity now.

### 3. <ins>Steps</ins> [\#](https://pub.dev/packages/flutter_unity_widget#steps)

1.  Create a folder named *unity* and move the Unity project into there.

> The expected path is *unity/**project-name**/...*

2.  Copy the *FlutterUnityPackage.unitypackage* file into the Unity
    project folder.

> The expected path is
> *unity/**project-name**/FlutterUnityPackage.unitypackage*

3.  Using Unity, open the Unity project, go to **File \> Build Settings
    \> Player Settings** and change the following under the
    **Configuration** section:

<!-- end list -->

  - In **Scripting Backend**, change to IL2CPP

  - In **Target Architectures**, select ARMv7 and ARM64

![](./flutter_unity_widget%20_%20Flutter%20Package_files/Screenshot%202019-03-27%2007.31.55.png)

> Be sure you have at least one scene added to your build.

4.  Go to **Assets \> Import Package \> Custom Package** and select the
    *FlutterUnityPackage.unitypackage* file. Click on **Import**.

5.  After importing, click on **Flutter** and select the **Export
    Android** option (will export to *android/unityLibrary*) or the
    **Export iOS** option (will export to *ios/UnityLibrary*).

> Do not use **Flutter \> Export *Platform* plugin** as it was specially
> added to work with
> [`flutter_unity_cli`](https://github.com/juicycleff/flutter_unity_cli)
> for larger projects.

![](./flutter_unity_widget%20_%20Flutter%20Package_files/Screenshot%202019-03-27%2008.13.08.png)

### 3 (a). <ins>Android</ins> (OPTIONAL)

    The export script automatically sets things up for you, so you don't have to do anything for Android. But if you want to manually set it up, continue.

- Open the *android/settings.gradle* file and change the following:

    +    include ":unityLibrary"
    +    project(":unityLibrary").projectDir = file("./unityLibrary")

- Open the *android/app/build.gradle* file and change the following:

``` 
     dependencies {
+        implementation project(':unityLibrary')
     }
```

- If you need to build a release package, open the
*android/app/build.gradle* file and change the following:

``` 
     buildTypes {
         release {
             signingConfig signingConfigs.debug
         }
+        debug {
+            signingConfig signingConfigs.debug
+        }
+        profile {
+            signingConfig signingConfigs.debug
+        }
+        innerTest {
+            matchingFallbacks = ['debug', 'release']
+        }
+   }
```

> The code above use the `debug` signConfig for all buildTypes, which
> can be changed as you well if you need specify signConfig.

- If you use `minifyEnabled true` in your *android/app/build.gradle*
file, open the *android/unityLibrary/proguard-unity.txt* and change the
following:

    +    -keep class com.xraph.plugin.** {*;}

- If you want Unity in it's own activity as an alternative, open the
*android/app/src/main/AndroidManifest.xml* and change the following:

```
    <activity
      android:name="com.xraph.plugin.flutter_unity_widget.OverrideUnityActivity"
      android:theme="@style/UnityThemeSelector"
      android:screenOrientation="fullSensor"
      android:launchMode="singleTask"
      android:configChanges="mcc|mnc|locale|touchscreen|keyboard|keyboardHidden|navigation|orientation|screenLayout|uiMode|screenSize|smallestScreenSize|fontScale|layoutDirection|density"
      android:hardwareAccelerated="false"
      android:process=":Unity">
      <meta-data android:name="com.xraph.plugin.flutter_unity_widget.OverrideUnityActivity" android:value="true" />
    </activity>
```

### 3 (b) <ins>iOS</ins>

- Open the *ios/Runner.xcworkspace* (workspace, not the project) file
in Xcode, right-click on the Navigator (not on an item), go to **Add
Files to "Runner"** and add the
*ios/UnityLibrary/Unity-Iphone.xcodeproj* file.

![](./flutter_unity_widget%20_%20Flutter%20Package_files/workspace.png)

- (Optional) Select the *Unity-iPhone/Data* folder and change the
Target Membership for Data folder to UnityFramework.

![](./flutter_unity_widget%20_%20Flutter%20Package_files/change_target_membership_data_folder.png)

- If you're using Swift, open the *ios/Runner/AppDelegate.swift*
file and change the following:

``` 
     import UIKit
     import Flutter
+    import flutter_unity_widget

     @UIApplicationMain
     @objc class AppDelegate: FlutterAppDelegate {
         override func application(
             _ application: UIApplication,
             didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
         ) -> Bool {
+            InitUnityIntegrationWithOptions(argc: CommandLine.argc, argv: CommandLine.unsafeArgv, launchOptions)

             GeneratedPluginRegistrant.register(with: self)
             return super.application(application, didFinishLaunchingWithOptions: launchOptions)
         }
     }
```

- If you're using Objective-C, open the *ios/Runner/main.m* file
and change the following:

    +    #import "flutter_unity_widget.swift.h"
    
         int main(int argc, char * argv[]) {
              @autoreleasepool {
    +             InitUnityIntegration(argc, argv);
                  return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
              }
         }

- Open the *ios/Runner/Info.plist* and change the following:

``` 
     <dict>
+        <key>io.flutter.embedded_views_preview</key>
+        <string>YES</string>
     </dict>
```

- Add the *UnityFramework.framework* file as a library to the Runner
project.

![](./flutter_unity_widget%20_%20Flutter%20Package_files/libraries.png)

### 3 (c) <ins>Setup AR Foundation</ins> (OPTIONAL)

![gif](./flutter_unity_widget%20_%20Flutter%20Package_files/ar-demo.gif)

:information\_source: **Android**

7.  Open the *lib/**architecture**/* folder and check if there are both
    *libUnityARCore.so* and *libarpresto\_api.so* files. There seems to
    be a bug where a Unity export does not include all lib files. If
    they are missing, use Unity to build a standalone .apk of your AR
    project, unzip the resulting apk, and copy over the missing .lib
    files to the `unityLibrary` module.

8.  Repeat steps 6.1 and 6.2 for Android, replacing `unityLibrary` with
    `arcore_client`, `unityandroidpermissions` and `UnityARCore`.

9.  When using `UnityWidget` in Flutter, set `fullscreen: false` to
    disable fullscreen.

:information\_source: **iOS**

7.  Open the *ios/Runner/Info.plist* and change the following:

``` 
     <dict>
+        <key>Privacy - Camera Usage Description</key>
+        <string>$(PRODUCT_NAME) uses Cameras</string>
     </dict>
```

## Communicating [\#](https://pub.dev/packages/flutter_unity_widget#communicating)

### Flutter-Unity [\#](https://pub.dev/packages/flutter_unity_widget#flutter-unity)

1.  On a `UnityWidget` widget, get the `UnityWidgetController` received
    by the `onUnityCreated` callback.

2.  Use the method `postMessage` to send a string, using the GameObject
    name and the name of a behaviour method that should be called.

### Unity-Flutter [\#](https://pub.dev/packages/flutter_unity_widget#unity-flutter)

1.  Select the GameObject that should execute the communication and go
    to **Inspector \> Add Component \> Unity Message Manager**.

![](./flutter_unity_widget%20_%20Flutter%20Package_files/1gSOy.png)

2.  Create a new `MonoBehaviour` subclass and add to the same GameObject
    as a script.

3.  On this new behaviour, call `GetComponent<UnityMessageManager>()` to
    get a `UnityMessageManager`.

4.  Use the method `SendMessageToFlutter` to send a string. Receive this
    message using the `onUnityMessage` callback of a `UnityWidget`.

### Props [\#](https://pub.dev/packages/flutter_unity_widget#props)

  - `fullscreen` (Enable or disable fullscreen mode on Android)

### API [\#](https://pub.dev/packages/flutter_unity_widget#api)

  - `pause()` (Use this to pause unity player)
  - `resume()` (Use this to resume unity player)
  - `unload()` (Use this to unload unity player) \*Requires Unity
    2019.4.3 or later
  - `quit()` (Use this to quit unity player)
  - `postMessage(String gameObject, methodName, message)` (Allows you
    invoke commands in Unity from flutter)
  - `onUnityMessage(data)` (Unity to flutter binding and listener)
  - `onUnityUnloaded()` (Unity to flutter listener when unity is
    unloaded)
  - `onUnitySceneLoaded(String name, int buildIndex, bool isLoaded, bool
    isValid,)` (Unity to flutter binding and listener when new scene is
    loaded)

## Troubleshooting [\#](https://pub.dev/packages/flutter_unity_widget#troubleshooting)

**Location:** Unity

**Error:**

    InvalidOperationException: The build target does not support build appending.

**Solution:**

1.  Open the
    *unity/**project-name**/Assets/FlutterUnityIntegration/Editor/Build.cs*
    file.

1.1. On line 48, change the following:

    -    var options = BuildOptions.AcceptExternalModificationsToPlayer;
    +    var options = BuildOptions.AllowDebugging;
    +    EditorUserBuildSettings.exportAsGoogleAndroidProject = true;

1.2. On line 115, change the following:

    -    var options = BuildOptions.AcceptExternalModificationsToPlayer;
    +    var options = BuildOptions.AllowDebugging;

-----

**Location:** Android Studio

**Error:**

    minSdkVersion XX cannot be smaller than version 19 declared in library 
        \ [:flutter_unity_widget] .../AndroidManifest.xml as the library might be using 
        \ APIs not available in XX

**Solution:**

1.  Open the *android/app/build.gradle* file and change the following:

    -    minSdkVersion XX
    +    minSdkVersion 19

-----

**Location**: Android Studio

**Error:**

    e: .../FlutterUnityWidgetBuilder.kt: (15, 42): Expecting a parameter declaration
    e: .../FlutterUnityWidgetBuilder.kt: (23, 25): Expecting an argument
    e: .../FlutterUnityWidgetController.kt: (22, 44): Expecting a parameter declaration
    e: .../FlutterUnityWidgetFactory.kt: (13, 58): Expecting a parameter declaration

**Solution:**

1.  Open the *android/build.gradle* file and change the following:

    -    ext.kotlin_version = '1.3.50'
    +    ext.kotlin_version = '1.4.31'

-----

**Location:** Android Studio

**Error:**

    Unable to find a matching variant of project :unityLibrary:

**Solution:**

1.  Open the *android/app/build.gradle* file and change the following:

``` 
     lintOptions {
         disable 'InvalidPackage'
+        checkReleaseBuilds false
     }
```

-----

**Location:** Android Studio

**Error:**

    Gradle Build Error In Unity with error Could not get unknown property 'unityStreamingAssets'

**Solution:**

Paste the following in your
`android/gradle.properties`:

``` 
unityStreamingAssets=.unity3d, google-services-desktop.json, google-services.json, GoogleService-Info.plist
```


## Known issues [\#](https://pub.dev/packages/flutter_unity_widget#known-issues)

  - Remember to disabled fullscreen in unity player settings to disable
    unity fullscreen.

  - Unity freezes and crashes on Android, please use OpenGL3 as Graphics
    API.

  - Project fails to build due to some native dependencies in your unity
    project, please integrate the native libraries for those
    dependencies on Android or iOS

  - App crashes on screen exit and re-entry do this
    
    > Build Setting - iOS - Other Settings - Configuration - Enable
    > Custom Background Behaviors
