import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'circularprogress1.dart';
import 'custom_slider_thumb_circle.dart';
import 'notes_page.dart';
import 'dart:io' as io;

double sliderHeight = 48;

class NoteDownload extends StatefulWidget {
  final String scheme;
  final String sem;
  final String branch;
  final String sub;
  NoteDownload({this.scheme, this.branch, this.sem, this.sub});
  @override
  _NoteDownloadState createState() => _NoteDownloadState();
}

class _NoteDownloadState extends State<NoteDownload> {
  bool _moduleloading = true;
  bool _moduleisEmpty = false;
  bool _notesLoading = false;
  bool _downloadingNotes = false;
  List<String> _modules = <String>[];
  double _value = 0.0;
  String moduleName = 'mod1';
  List<Widget> notes = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _recived = 1;
  int _total = 1;

  @override
  void initState() {
    _getModules();
    _getNotes('mod1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Center(
              child: Text(
                "KTU Help",
                style: TextStyle(fontFamily: "Orbitron", fontSize: 35),
              ),
            ),
            Center(
              child: Text(
                "together we learn",
                style: TextStyle(fontFamily: "Orbitron", fontSize: 14),
              ),
            ),
            _moduleloading
                ? circularProgress()
                : _moduleisEmpty
                    ? Text(' ')
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: (sliderHeight),
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.all(
                              Radius.circular((sliderHeight * .3)),
                            ),
                            gradient: new LinearGradient(
                                colors: [
                                  const Color(0xFF00c6ff),
                                  const Color(0xFF0072ff),
                                ],
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 1.00),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: sliderHeight * .3,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: sliderHeight * .1,
                                ),
                                Expanded(
                                  child: Center(
                                    child: SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor:
                                            Colors.white.withOpacity(1),
                                        inactiveTrackColor:
                                            Colors.white.withOpacity(.5),

                                        trackHeight: 4.0,
                                        thumbShape: CustomSliderThumbCircle(
                                          thumbRadius: sliderHeight * .4,
                                          min: 0,
                                          max: _modules.length - 1,
                                        ),
                                        overlayColor:
                                            Colors.white.withOpacity(.4),
                                        //valueIndicatorColor: Colors.white,
                                        activeTickMarkColor: Colors.white,
                                        inactiveTickMarkColor:
                                            Colors.red.withOpacity(.7),
                                      ),
                                      child: Slider(
                                        divisions: _modules.length - 1,
                                        value: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value;
                                            moduleName = _modules[
                                                ((_modules.length - 1) * _value)
                                                    .toInt()];
                                          });
                                          // print(_value);
                                          _getNotes(moduleName);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  _modules.length.toString(),
                                  style: TextStyle(
                                    fontSize: sliderHeight * .3,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
            _moduleisEmpty
                ? Container()
                : Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white24,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _modules.isEmpty
                            ? ' '
                            : 'module ' +
                                _modules[((_modules.length - 1) * _value)
                                        .toInt()]
                                    .split('d')
                                    .last,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: _notesLoading
          ? Center(
              child: circularProgress(),
            )
          : ListView(
              children: notes,
            ),
      floatingActionButton: _downloadingNotes
          ? LinearProgressIndicator(
              // valueColor: ((_recived / _total).isNaN ||
              //         (_recived / _total).isInfinite )
              //     ? AlwaysStoppedAnimation<Color>(Colors.transparent)
              //     : AlwaysStoppedAnimation<Color>(Colors.green),
              value:
                  ((_recived / _total).isNaN || (_recived / _total).isInfinite)
                      ? 0
                      : _recived / _total,
            )
          : null,
    );
  }

  Future _getModules() async {
    QuerySnapshot data;
    _modules = [];
    print('called...');
    if (widget.sem == "S1" || widget.sem == "S2") {
      data = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.sub)
          .collection(widget.sub)
          .getDocuments();
    } else {
      data = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.branch)
          .collection(widget.branch)
          .document(widget.sub)
          .collection(widget.sub)
          .getDocuments();
    }
    if (data.documents.isNotEmpty) {
      setState(() {
        _moduleloading = false;
      });
      for (DocumentSnapshot data in data.documents) {
        _modules.add(data.data['val'].toString());
      }

      print(_modules.toString() + _modules.length.toString());
    } else {
      setState(() {
        _moduleloading = false;
        _moduleisEmpty = true;
      });
    }
  }

  Future<void> _getNotes(String moduleName) async {
    setState(() {
      _notesLoading = true;
    });
    QuerySnapshot data;
    List<Widget> noteList = [];
    if (widget.sem == "S1" || widget.sem == "S2") {
      data = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.sub)
          .collection(widget.sub)
          .document(moduleName)
          .collection(moduleName)
          .getDocuments();
    } else {
      data = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.branch)
          .collection(widget.branch)
          .document(widget.sub)
          .collection(widget.sub)
          .document(moduleName)
          .collection(moduleName)
          .getDocuments();
    }
    if (data.documents.isNotEmpty) {
      for (DocumentSnapshot data in data.documents) {
        noteList.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: FlatButton(
            onPressed: () {
              String url = data.data['val'];
              _openPdf(url, data.data['name']);
              // _downloadPdf(url, data.data['name']);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(data.data['name'].split(' ').last)),

                  Icon(Icons.picture_as_pdf),

                  // onPressed: () {
                  //   String url = data.data['val'];
                  //   _openPdf(url, data.data['name']);
                  //   showInSnackBar('Downloading over internet');
                  // },
                ],
              ),
            ),
          ),
        ));
      }
    } else {
      noteList.add(
        Container(
          child: Column(
            children: [
              Center(
                child: Icon(
                  Icons.not_interested,
                  size: 400,
                ),
              ),
              Text(
                'Sorry Notes are non avalible',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }
    setState(() {
      notes = noteList;
      _notesLoading = false;
    });
  }

  void _openPdf(String url, String name) async {
    final externaldir = await getExternalStorageDirectory();
    String filepath = '${externaldir.path}/$name';
    bool fileExists = await io.File(filepath).exists();
    if (fileExists) {
      print('File exits in local storage');
      _openPdfFormLocalStorage(filepath, name);
    } else {
      print('file doesnt exit it local storage');
      _downloadPdf(url, name, externaldir);
    }
  }

  void _openPdfFormLocalStorage(String filepath, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfScreen(
          pdfPath: filepath,
          name: name.split(' ').last.replaceAll('_', ' '),
        ),
      ),
    );
  }

  void _downloadPdf(String url, String name, io.Directory externaldir) async {
    setState(() {
      _downloadingNotes = true;
    });
    Dio dio = Dio();
    // final externaldir = await getExternalStorageDirectory();
    http.Response resp;
    try {
      resp = await http.get(url).timeout(const Duration(seconds: 5));
    } catch (e) {
      print(e);
      setState(() {
        _downloadingNotes = false;
      });
    }
    if (resp.statusCode == 200) {
      print('Download url is valid');
      Response response = await dio.download(url, "${externaldir.path}/$name",
          onReceiveProgress: (rec, total) {
        // print(rec.toString() + ' ' + total.toString());
        setState(() {
          _recived = rec;
          _total = total;
        });
      });
      if (response.statusCode == 200) {
        print(externaldir.path);
        setState(() {
          _downloadingNotes = false;
        });
        _recived = 1;
        _total = 1;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PdfScreen(
        //       pdfPath: '${externaldir.path}/$name',
        //     ),
        //   ),
        // );
        _openPdfFormLocalStorage("${externaldir.path}/$name", name);
      }
    } else {
      setState(() {
        _downloadingNotes = false;
      });
      print(resp.statusCode);
      showInSnackBar('Sorry cannot download status code: ${resp.statusCode}');
    }
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Container(
        child: Text(message),
      ),
    ));
  }
}

class PdfScreen extends StatelessWidget {
  final String pdfPath;
  final String name;
  PdfScreen({this.pdfPath, this.name});
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      path: pdfPath,
    );
  }
}
