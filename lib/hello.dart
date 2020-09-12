import 'dart:io';
import 'dart:wasm';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:simple_permissions/simple_permissions.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File sample;
  void pick() async {
    var file = await FilePicker.getFile();
    setState(() {
      sample = file;
    });
    print("jjj");
  }

  void upload() {
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('hhh.pdf');
    final StorageUploadTask task = firebaseStorageRef.putFile(sample);
  }

  // Future<Void>() async {
  //   final status=permissio

  // }
  // Future<Void> start() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await FlutterDownloader.initialize(
  //       debug: true // optional: set false to disable printing logs to console
  //       );
  // }

  // Future<Void> down() async {
  //   // PermissionStatus permissionResult =
  //   //     await SimplePermissions.requestPermission(
  //   //         Permission.WriteExternalStorage);
  //   // if (permissionResult == PermissionStatus.authorized) {

  //   // }

  //   //var status = Permission.storage;
  //   var permission =
  //       await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  //   final taskId = await FlutterDownloader.enqueue(
  //     url:
  //         'https://firebasestorage.googleapis.com/v0/b/flash-chat-64be9.appspot.com/o/hhh.pdf?alt=media&token=8c485bfa-f8dc-47fb-a6d5-407b26caf8e4',
  //     savedDir: '/storage/emulated/0/Download',
  //     showNotification:
  //         true, // show download progress in status bar (for Android)
  //     openFileFromNotification:
  //         true, // click on notification to open downloaded file (for Android)
  //   );
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //start();
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("File picker"),
    //   ),
    //   body: Container(
    //     child: Center(
    //       child: Column(
    //         children: <Widget>[
    //           RaisedButton(child: Text("ggg"), onPressed: pick),
    //           RaisedButton(child: Text("upload"), onPressed: upload)
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    //start();
    return WebviewScaffold(
      url:
          "https://firebasestorage.googleapis.com/v0/b/flash-chat-64be9.appspot.com/o/hhh.pdf?alt=media&token=8c485bfa-f8dc-47fb-a6d5-407b26caf8e4",
      appBar: AppBar(
        actions: <Widget>[
          RaisedButton(
            onPressed: () async {
              final status = await Permission.storage.request();
              if (status.isGranted) {
                final externaldir = await getExternalStorageDirectory();
                print(externaldir.path);
                final id = await FlutterDownloader.enqueue(
                  url:
                      "https://firebasestorage.googleapis.com/v0/b/flash-chat-64be9.appspot.com/o/hhh.pdf?alt=media&token=8c485bfa-f8dc-47fb-a6d5-407b26caf8e4",
                  savedDir: externaldir.path,
                  fileName: "down.pdf",
                  showNotification: true,
                  openFileFromNotification: true,
                );
              } else {
                print("nooooooo");
              }
            },
            child: Text("downs"),
          ),
          RaisedButton(child: Text("ggg"), onPressed: pick),
          RaisedButton(child: Text("upload"), onPressed: upload)
        ],
        title: Text("appp"),
      ),
    );
  }
}