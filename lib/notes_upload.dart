import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ktuhelp/circularprogress1.dart';
import 'package:ktuhelp/custom_slider_thumb_circle.dart';
import 'package:ktuhelp/notes_page.dart';

double sliderHeight = 48;

class UploadSelectSub extends StatefulWidget {
  final String sem;
  final String branch;
  final String scheme;
  UploadSelectSub({this.sem, this.branch, this.scheme});
  @override
  _UploadSelectSubState createState() => _UploadSelectSubState();
}

class _UploadSelectSubState extends State<UploadSelectSub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
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
              Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 250,
                // width: 200,
                child: Image(image: AssetImage("images/icon.png")),
              ),
              FutureBuilder(
                future: _getsubjects(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: circularProgress(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Icon(
                      Icons.not_interested,
                      color: Colors.white,
                      size: 200,
                    );
                  }
                  if (snapshot.data == null) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.not_interested,
                            color: Colors.white,
                            size: 200,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Data Not Avalible',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    );
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GridView.count(
                        shrinkWrap: true,
                        childAspectRatio: 1 / 0.75,
                        crossAxisCount: 2,
                        children: snapshot.data,
                      ),
                    ),
                  );
                },
              )
            ]),
      )),
    );
  }

  Future _getsubjects() async {
    QuerySnapshot data;
    if (widget.sem == "S1" || widget.sem == "S2") {
      if (widget.scheme == '2019') {
        data = await noteref
            .document(widget.scheme)
            .collection(widget.scheme)
            .document('S1&S2')
            .collection('S1&S2')
            .getDocuments();
      } else {
        data = await noteref
            .document(widget.scheme)
            .collection(widget.scheme)
            .document(widget.sem)
            .collection(widget.sem)
            .getDocuments();
      }
    } else {
      data = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.branch)
          .collection(widget.branch)
          .getDocuments();
    }
    if (data.documents.isNotEmpty) {
      List subjectList = data.documents.map((DocumentSnapshot snapshot) {
        return GridObject(
          scheme: widget.scheme,
          branch: widget.branch,
          sem: widget.sem,
          sub: snapshot.data['val'].toString(),
        );
      }).toList();
      return subjectList;
    }
    return null;
  }
}

class GridObject extends StatelessWidget {
  final String sub;
  final String scheme;
  final String sem;
  final String branch;
  GridObject({this.scheme, this.branch, this.sem, this.sub});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white10,
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UploadNotesScreen(
                        scheme: scheme,
                        branch: branch,
                        sem: sem,
                        sub: sub,
                      )));
        },
        child: Center(
          child: Text(
            sub,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class UploadNotesScreen extends StatefulWidget {
  final String scheme;
  final String sem;
  final String branch;
  final String sub;
  UploadNotesScreen({this.scheme, this.sem, this.branch, this.sub});
  @override
  _UploadNotesScreenState createState() => _UploadNotesScreenState();
}

class _UploadNotesScreenState extends State<UploadNotesScreen> {
  double _value = 0.0;
  List<String> _modules = <String>[];
  bool _loading = true;
  bool fullWidth = false;
  bool _isEmpty = false;
  File _file;
  String _fileName;

  bool _uploading = false;

  @override
  void initState() {
    _getModules();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _loading
                ? circularProgress()
                : _isEmpty
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
                                          });
                                          // print(_value);
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
            _isEmpty
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
      body: _isEmpty
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.not_interested,
                      size: 400,
                    ),
                  ),
                  Text(
                    'Sorry data currently not avalible',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )
          : ListView(
              children: [
                _file != null
                    ? FlatButton(
                        padding: EdgeInsets.all(5),
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.picture_as_pdf),
                              Expanded(child: Text(_fileName)),
                              Row(
                                children: [
                                  _uploading
                                      ? CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        )
                                      : IconButton(
                                          onPressed: _uploadPdf,
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(Icons.cloud_upload),
                                        ),
                                  IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: _uploading
                                        ? null
                                        : () {
                                            setState(() {
                                              _file = null;
                                            });
                                          },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
      floatingActionButton: _isEmpty
          ? null
          : FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: _selectFile,
            ),
    );
  }

  Future<void> _uploadPdf() async {
    String day = _getCurrentDate();

    String identifier =
        '${widget.scheme + widget.branch + widget.sem + widget.sub + _modules[((_modules.length - 1) * _value).toInt()] + day + ' ' + _fileName}';
    setState(() {
      _uploading = true;
    });
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('notes/$identifier');
    StorageUploadTask uploadTask = storageReference.putFile(_file);
    try {
      await uploadTask.onComplete;
      print('file uploaded');
      storageReference.getDownloadURL().then((fileUrl) {
        // _uploadedFileUrl = fileUrl;
        _uploadLink(<String, dynamic>{
          'val': fileUrl,
          'name': identifier,
        });
      });
    } catch (e) {
      print(e.errorcode);
    }
  }

  void _uploadLink(Map<String, dynamic> data) async {
    // Map<String, dynamic> data = {
    //   'val': _uploadedFileUrl,
    // };
    String moduleName =
        _modules[((_modules.length - 1) * _value).toInt()].toString();
    if (widget.sem == "S1" || widget.sem == "S2") {
      noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.sub)
          .collection(widget.sub)
          .document(moduleName)
          .collection(moduleName)
          .add(data)
          .then((value) {
        setState(() {
          _file = null;
          _uploading = false;
        });
      });
    } else {
      noteref
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
          .add(data)
          .then((value) {
        setState(() {
          _file = null;
        });
      });
    }
  }

  void _launchUrl() async {
    // var url = file.path;
    // launch('file:/' + url, forceSafariVC: false, forceWebView: false);
  }

  void _selectFile() async {
    File result = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _file = result;
        _fileName =
            result.path.split('/').last.replaceAll(new RegExp(r"\s+"), '_');
      });
      print('uri is ' + result.path);
    }
  }

  Future _getModules() async {
    QuerySnapshot data;
    if (widget.sem == "S1" || widget.sem == "S2") {
      if (widget.scheme == '2019') {
        data = await noteref
            .document(widget.scheme)
            .collection(widget.scheme)
            .document('S1&S2')
            .collection('S1&S2')
            .document(widget.sub)
            .collection(widget.sub)
            .getDocuments();
      } else {
        data = await noteref
            .document(widget.scheme)
            .collection(widget.scheme)
            .document(widget.sem)
            .collection(widget.sem)
            .document(widget.sub)
            .collection(widget.sub)
            .getDocuments();
      }
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
        _loading = false;
      });
      for (DocumentSnapshot data in data.documents) {
        _modules.add(data.data['val'].toString());
      }
      debugPrint(_modules.toString() + _modules.length.toString());
    } else {
      setState(() {
        _loading = false;
        _isEmpty = true;
      });
    }
  }
}

String _getCurrentDate() {
  DateTime time = DateTime.now();
  String year = time.year.toString();
  String month = time.month.toString();
  if (month.length < 2) {
    month = '0' + month;
  }
  String day = time.day.toString();
  if (day.length < 2) {
    day = '0' + day;
  }
  String hour = time.hour.toString();
  if (hour.length < 2) {
    hour = "0" + hour;
  }
  String minute = time.minute.toString();
  if (minute.length < 2) {
    minute = '0' + minute;
  }
  String second = time.second.toString();
  if (second.length < 2) {
    second = '0' + second;
  }
  return "$year-$month-$day:$hour:$minute:$second";
}
