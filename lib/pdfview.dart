import 'dart:io';

import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'circularprogress1.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class PDFScreen extends StatefulWidget {
  final String title;
  final String postId;
  PDFScreen({this.title, this.postId});
  // final String file=
  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldKey1 = GlobalKey<ScaffoldState>();

  static String pathPDF = "";
  static String pdfUrl = "";
  bool fileloading = true;
  String file1;
  String urlwhole;
  bool downloading = false;
  var progressString = "";

  @override
  void initState() {
    super.initState();
    file1 = "Module/${widget.postId}";
    fileloading = true;
    launch();

    //Fetch file from FirebaseStorage first
  }

  void launchPDF(
      BuildContext context, String title, String pdfPath, String pdfUrl) {}

  Future<dynamic> loadFromFirebase(BuildContext context, String url) async {
    return FireStorageService.loadFromStorage(context, file1);
  }

  Future<dynamic> createFileFromPdfUrl(dynamic url) async {
    final filename =
        "cachefile"; //I did it on purpose to avoid strange naming conflicts
    print(filename);
    var request = await HttpClient().getUrl(Uri.parse(url));

    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);

    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    print("$file asfafas");
    return file;
  }

  // Future<void> downloadFile() async {
  //   Dio dio = Dio();

  //   try {
  //     var dir = await getApplicationDocumentsDirectory();
  //     print(dir);

  //     await dio.download(urlwhole, "${dir}/${widget.title}.pdf",
  //         onReceiveProgress: (rec, total) {
  //       // print("Rec: $rec , Total: $total");

  //       setState(() {
  //         downloading = true;
  //         progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
  //       });
  //     });
  //   } catch (e) {
  //     print(e);
  //   }

  //   setState(() {
  //     downloading = false;
  //     progressString = "Completed";
  //   });
  //   print("Download completed");
  // }

  launch() async {
    await loadFromFirebase(context, file1)
        //Creating PDF file at disk for ios and android & assigning pdf url for web
        .then((url) => createFileFromPdfUrl(url).then(
              (f) => setState(
                () {
                  if (f is File) {
                    print(url.toString());
                    urlwhole = url.toString();
                    pathPDF = f.path;
                    print(pathPDF);
                  } else if (url is Uri) {
                    pdfUrl = url.toString();
                  }
                },
              ),
            ));

    fileloading = false;
  }

  // Future<void> downloadFile(StorageReference ref) async {
  //   // final String url = await ref.getDownloadURL();
  //   final http.Response downloadData = await http.get(urlwhole);

  //   final Directory systemTempDir = Directory.systemTemp;
  //   print(systemTempDir);
  //   final File tempFile = File('${systemTempDir.path}/${widget.title}.pdf');
  //   if (tempFile.existsSync()) {
  //     await tempFile.delete();
  //   }
  //   await tempFile.create();
  //   final StorageFileDownloadTask task = ref.writeToFile(tempFile);
  //   final int byteCount = (await task.future).totalByteCount;
  //   var bodyBytes = downloadData.bodyBytes;
  //   final String name = await ref.getName();
  //   final String path = await ref.getPath();
  //   print(
  //     'Success!\nDownloaded $name \nUrl: $urlwhole'
  //     '\npath: $path \nBytes Count :: $byteCount',
  //   );
  //   SnackBar snackBar = SnackBar(content: Text("Wait for the file to load"));
  // }

  backnav() {
    SnackBar snackBar = SnackBar(content: Text("Wait for the file to load"));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    // create
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (fileloading) {
      return WillPopScope(
        onWillPop: () => backnav(),
        child: Scaffold(
          key: _scaffoldKey,
          body: circularProgress(),
        ),
      );
    } else {
      if (downloading == false) {
        return PDFViewerScaffold(
            key: _scaffoldKey1,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () async {
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      Dio dio = Dio();

                      try {
                        final externaldir = await getExternalStorageDirectory();
                        print(externaldir.path);

                        await dio.download(
                            urlwhole, "${externaldir.path}/${widget.title}.pdf",
                            onReceiveProgress: (rec, total) {
                          // print("Rec: $rec , Total: $total");

                          setState(() {
                            downloading = true;
                            progressString =
                                ((rec / total) * 100).toStringAsFixed(0) + "%";
                          });
                        });
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        downloading = false;
                        progressString = "Completed";
                      });
                      print("Download completed");
                    } else {
                      print("nooooooo");
                    }
                  },
                )
              ],
              title: Text("${widget.title}",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Dancing",
                      fontSize: 25)),
              centerTitle: true,
            ),
            path: pathPDF);
      } else if (downloading == true) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Downloading"),
          ),
          body: Center(
            child: downloading
                ? Container(
                    height: 120.0,
                    width: 200.0,
                    child: Card(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Downloading File: $progressString",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Text("No Data"),
          ),
        );
      }
    }
  }
}

class LaunchFile {}

class FireStorageService extends ChangeNotifier {
  FireStorageService._();
  FireStorageService();

  static Future<dynamic> loadFromStorage(
      BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
