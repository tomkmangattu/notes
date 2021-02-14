import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ktuhelp/notes_download.dart';
import 'circularprogress1.dart';
import 'notesfirebase.dart';
import 'pdfview.dart';
import 'videofirebase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'notes_upload.dart';

import 'custom_slider_thumb_circle.dart';

const headingstyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w900,
  fontFamily: "Red Hat Display",
);
const contentstyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

var constantts1 = TextStyle();
final noteref = Firestore.instance.collection("notes");
final notereq = Firestore.instance.collection("noterequest");

class NoteLectureProceed extends StatefulWidget {
  @override
  _NoteLectureProceedState createState() => _NoteLectureProceedState();
}

class _NoteLectureProceedState extends State<NoteLectureProceed> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = "CSE";
  String dropdownValue1 = "S1";
  String dropdownValue2 = "2015";
  List<String> semester = ["S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"];
  List<DropdownMenuItem<int>> semdrop = [];
  int semsel;
  void semdata() {
    semdrop = [];
    semdrop = semester
        .map((val) => DropdownMenuItem<int>(
              child: Text(val),
              value: semester.indexOf(val),
            ))
        .toList();
  }

  Widget semdropbutton() {
    semdata();
    return DropdownButtonFormField(
        iconEnabledColor: Colors.white,
        hint: Text(
          "Semester",
          style: TextStyle(color: Colors.grey),
        ),
        items: semdrop,
        value: semsel,
        validator: (value) => value == null ? 'field required' : null,
        onChanged: (value) {
          setState(() {
            semsel = value;
          });
        });
  }

  // List<String> branch = ["CS", "CE", "EC", "EE", "ME", "IT"];
  // List<DropdownMenuItem<int>> bradrop = [];
  // int brasel;
  // void bradata() {
  //   bradrop = [];
  //   bradrop = branch
  //       .map((k) => DropdownMenuItem<int>(
  //             child: Text(k),
  //             value: branch.indexOf(k),
  //           ))
  //       .toList();
  // }

  // Widget bradropbutton() {
  //   bradata();
  //   return DropdownButtonFormField(
  //     iconEnabledColor: Colors.white,
  //     items: bradrop,
  //     value: brasel,
  //     hint: Text(
  //       'Branch',
  //       style: TextStyle(color: Colors.grey),
  //     ),
  //     validator: (value) => value == null ? 'field required' : null,
  //     onChanged: (value) {
  //       setState(() {
  //         brasel = value;
  //       });
  //     },
  //   );
  // }
  bool checksem = false;
  onChangeSemester() {
    if (dropdownValue1 == "S1" || dropdownValue1 == "S2") {
      setState(() {
        checksem = false;
      });
    } else {
      setState(() {
        checksem = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Form(
          key: _formKey,
          child: SafeArea(
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
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 44, 42, 43),
                    boxShadow: [
                      //background color of box
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 200,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Scheme",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 22),
                          ),
                          // Container(
                          //     // color: Colors.white54,
                          //     // margin:
                          //     //     EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                          //     decoration: ShapeDecoration(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(22.0)),
                          //       ),
                          //     ),
                          Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: new DropdownButton<String>(
                                dropdownColor: Colors.white,
                                value: dropdownValue2,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                  size: 30,
                                ),
                                iconSize: 24,
                                elevation: 16,
                                style: new TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue2 = newValue;
                                  });
                                },
                                items: <String>[
                                  "2015",
                                  "2019"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Semester",
                            style:
                                TextStyle(color: Colors.white54, fontSize: 22),
                          ),
                          // Container(
                          //     // color: Colors.white54,
                          //     // margin:
                          //     //     EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                          //     decoration: ShapeDecoration(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(22.0)),
                          //       ),
                          //     ),
                          Container(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: new DropdownButton<String>(
                                dropdownColor: Colors.white,
                                value: dropdownValue1,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                  size: 30,
                                ),
                                iconSize: 24,
                                elevation: 16,
                                style: new TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue1 = newValue;
                                    onChangeSemester();
                                  });
                                },
                                items: <String>[
                                  "S1",
                                  "S2",
                                  "S3",
                                  "S4",
                                  "S5",
                                  "S6",
                                  "S7",
                                  "S8"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )))
                        ],
                      ),
                      checksem == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "Branch",
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 22),
                                ),
                                // Container(
                                //     // color: Colors.white54,
                                //     // margin:
                                //     //     EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                                //     decoration: ShapeDecoration(
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.all(Radius.circular(22.0)),
                                //       ),
                                //     ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                        child: new DropdownButton<String>(
                                      dropdownColor: Colors.white,
                                      value: dropdownValue,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black54,
                                        size: 30,
                                      ),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: new TextStyle(
                                        color: Colors.black54,
                                        fontSize: 20,
                                      ),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      },
                                      items: <String>[
                                        "CSE",
                                        "CE",
                                        "EC",
                                        "EE",
                                        "ME",
                                        "IT"
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )))
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
                Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        proceed(dropdownValue, dropdownValue1, dropdownValue2);
                      },
                      child: Container(
                        height: 55.0,
                        width: 360.0,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Proceed",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // getFormUrl();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadSelectSub(
                                      scheme: dropdownValue2,
                                      sem: dropdownValue1,
                                      branch: dropdownValue,
                                    )));
                      },
                      child: Container(
                        height: 55.0,
                        width: 360.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Want to upload Notes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                child: Icon(Icons.add),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  WebviewScaffold view(String link) {
    return WebviewScaffold(
      url: link,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Form for Upload"),
      ),
    );
  }

  getFormUrl() async {
    String url;
    List<NoteForm> q;
    QuerySnapshot querySnapshot1 =
        await Firestore.instance.collection("noteuploadform").getDocuments();
    List<DocumentSnapshot> documents = querySnapshot1.documents;

    q = querySnapshot1.documents
        .map((documentSnapshot) => NoteForm.fromDocument(documentSnapshot))
        .toList();

    q.forEach((eachpost) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => view(eachpost.link)));
    });
    // _launchInWebViewWithJavaScript(url);
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  proceed(String branch, String sem, String scheme) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("$dropdownValue$dropdownValue1$dropdownValue2");

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NoteSubject(sem: sem, branch: branch, scheme: scheme)));
    }
  }
}

class NoteSubject extends StatefulWidget {
  final String sem;
  final String branch;
  final String scheme;
  NoteSubject({this.sem, this.branch, this.scheme});
  @override
  _NoteSubjectState createState() => _NoteSubjectState();
}

class _NoteSubjectState extends State<NoteSubject> {
  List<NoteSem> videoList = [];
  bool loading = true;

  void initState() {
    super.initState();

    getAllProfilePosts();
  }

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
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(10), child: displayProfilePost()))
            ]),
      )),
    );
  }

  getAllProfilePosts() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot;
    if (widget.sem == "S1" || widget.sem == "S2") {
      querySnapshot = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .getDocuments();
      print("hello");
    } else {
      querySnapshot = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.branch)
          .collection(widget.branch)
          .getDocuments();
    }
    print(widget.scheme);
    setState(() {
      loading = false;

      videoList = querySnapshot.documents
          .map((documentSnapshot) => NoteSem.fromDocument(documentSnapshot))
          .toList();
    });
  }

  displayProfilePost() {
    if (loading) {
      return circularProgress();
    } else if (videoList.isEmpty) {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child:
                  Icon(Icons.not_interested, color: Colors.white, size: 200.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("No data available",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    } else if (true) {
      List<GridTile> gridTilesList = [];
      videoList.forEach((eachPost) {
        gridTilesList.add(GridTile(
            child: IconLeft(
          scheme: widget.scheme,
          sem: widget.sem,
          branch: widget.branch,
          subject: eachPost,
        )));
      });
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0 / 0.75,
        // mainAxisSpacing: 1.5,
        // crossAxisSpacing: 1.5,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: gridTilesList,
      );
      // List<GridTile> gridTilesList = [];
      // videoList4.forEach((eachPost) {
      //   gridTilesList.add(GridTile(
      //       child: Cards2(
      //     video: widget.video,
      //     branch: eachPost,
      //   )));
      // });
      // return Column(children: gridTilesList);
      // return Column(
      //   children: postsList,
      // );
    }
  }
}

class IconLeft extends StatefulWidget {
  String scheme;
  String sem;
  String branch;
  final NoteSem subject;
  IconLeft({
    this.scheme,
    this.sem,
    this.branch,
    this.subject,
  });

  @override
  _IconState createState() => _IconState();
}

class _IconState extends State<IconLeft> {
  //var dir

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NoteDownload(
                      scheme: widget.scheme,
                      branch: widget.branch,
                      sem: widget.sem,
                      sub: widget.subject.val,
                    ))
            // MaterialPageRoute(
            //     builder: (context) => NoteModule(
            //           scheme: widget.scheme,
            //           sem: widget.sem,
            //           branch: widget.branch,
            //           subject: widget.subject.val,
            //           modnum: widget.subject.max,
            //         )),
            );
        print(widget.scheme);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 44, 42, 43),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 50,
        width: 100,
        margin: //widget.kkk == 20
            EdgeInsets.fromLTRB(10, 0, 10, 10),
        //: EdgeInsets.fromLTRB(20, 0, 10, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   decoration: BoxDecoration(
            //       image: DecorationImage(
            //           fit: BoxFit.cover,
            //           image: AssetImage("images/Video Lectures.png"))),
            // ),

            // Container(
            //   padding: EdgeInsets.all(10),
            //   height: 100,
            //   width: 100,
            //   child:
            //       Image(fit: BoxFit.fill, image: AssetImage("images/GPA.png")),
            // ),
            Text(
              "${widget.subject.val}",
              style: headingstyle,
            ),
          ],
        ),
      ),
    );
  }
}

class NoteModule extends StatefulWidget {
  final String scheme;
  final String sem;
  final String branch;
  final String subject;
  final String modnum;
  NoteModule({this.scheme, this.sem, this.branch, this.subject, this.modnum});
  @override
  _NoteModuleState createState() => _NoteModuleState();
}

class _NoteModuleState extends State<NoteModule> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldKey1 = GlobalKey<ScaffoldState>();

  String modulenumber = "Module 1";
  List<Note> videoList = [];
  bool loading = true;
  double _value = 0;
  bool downloading = false;
  int max = 5;
  schemechange() {
    max = int.parse(widget.modnum);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProfilePosts();
    schemechange();
  }

  double sliderHeight = 48;
  int min = 1;

  bool fullWidth = false;
  double paddingFactor = .2;

  @override
  Widget build(BuildContext context) {
    return downloading == false
        ? Scaffold(
            key: _scaffoldKey1,
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
                    Center(
                      child: Container(
                        width:
                            fullWidth ? double.infinity : (sliderHeight) * 5.5,
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
                          padding: EdgeInsets.fromLTRB(
                              sliderHeight * paddingFactor,
                              2,
                              sliderHeight * paddingFactor,
                              2),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '$min',
                                textAlign: TextAlign.center,
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
                                        min: min,
                                        max: max - 1,
                                      ),
                                      overlayColor:
                                          Colors.white.withOpacity(.4),
                                      //valueIndicatorColor: Colors.white,
                                      activeTickMarkColor: Colors.white,
                                      inactiveTickMarkColor:
                                          Colors.red.withOpacity(.7),
                                    ),
                                    child: Slider(
                                        divisions: max - 1,
                                        value: _value,
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value;
                                            print((1 / (max - 1)));
                                            if (value == 0 / (max - 1)) {
                                              print(value);
                                              modulenumber = "Module 1";
                                              print("mod1");
                                            } else if (value == 1 / (max - 1)) {
                                              modulenumber = "Module 2";
                                              print("mod1");
                                            } else if (value == 2 / (max - 1)) {
                                              modulenumber = "Module 3";
                                              print("mod3");
                                            } else if (value == 3 / (max - 1)) {
                                              modulenumber = "Module 4";
                                              print(modulenumber);
                                            } else if (value == 4 / (max - 1)) {
                                              modulenumber = "Module 5";
                                              print("mod3");
                                            } else if (value == 5 / (max - 1)) {
                                              modulenumber = "Module 6";
                                            }
                                            getAllProfilePosts();
                                          });
                                        }),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: sliderHeight * .1,
                              ),
                              Text(
                                '$max',
                                textAlign: TextAlign.center,
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
                    // SliderTheme(
                    //   data: SliderTheme.of(context).copyWith(
                    //     activeTrackColor: Colors.red[700],
                    //     inactiveTrackColor: Colors.red[100],
                    //     trackShape: RoundedRectSliderTrackShape(),
                    //     trackHeight: 4.0,
                    //     thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    //     thumbColor: Colors.redAccent,
                    //     overlayColor: Colors.red.withAlpha(32),
                    //     overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    //     tickMarkShape: RoundSliderTickMarkShape(),
                    //     activeTickMarkColor: Colors.red[700],
                    //     inactiveTickMarkColor: Colors.red[100],
                    //     valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    //     valueIndicatorColor: Colors.redAccent,
                    //     valueIndicatorTextStyle: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   child: Slider(
                    //     value: _value,
                    //     min: 0,
                    //     max: 100,
                    //     divisions: 10,
                    //     label: '$_value',
                    //     onChanged: (value) {
                    //       setState(
                    //         () {
                    //           _value = value;
                    //         },
                    //       );
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: 20),
                    Expanded(
                      child: displayProfilePost(),
                    ),
                  ]),
            )),
          )
        : WillPopScope(
            onWillPop: () {
              backnav();
            },
            child: Scaffold(
              key: _scaffoldKey,
              body: Container(
                child: Center(
                  child: downloading
                      ? Container(
                          height: 120.0,
                          width: 200.0,
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
                        )
                      : Text("No Data"),
                ),
              ),
            ),
          );
  }

  backnav() {
    SnackBar snackBar = SnackBar(content: Text("Downloading"));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    // create
    return false;
  }

  getAllProfilePosts() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot;
    if (widget.sem == "S1" || widget.sem == "S2") {
      querySnapshot = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.subject)
          .collection(widget.subject)
          .document(modulenumber)
          .collection(modulenumber)
          .getDocuments();
    } else {
      querySnapshot = await noteref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.branch)
          .collection(widget.branch)
          .document(widget.subject)
          .collection(widget.subject)
          .document(modulenumber)
          .collection(modulenumber)
          .getDocuments();
    }
    print(widget.scheme);
    setState(() {
      loading = false;

      videoList = querySnapshot.documents
          .map((documentSnapshot) => Note.fromDocument(documentSnapshot))
          .toList();
    });
    print(videoList.length);
  }

  displayProfilePost() {
    if (loading) {
      return circularProgress();
    } else if (videoList.isEmpty) {
      return Container(
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child:
                  Icon(Icons.not_interested, color: Colors.white, size: 200.0),
            ),
            Center(
              child: Text("No data available",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    } else if (true) {
      // List<GridTile> gridTilesList = [];
      // videoList.forEach((eachPost) {
      //   gridTilesList.add(GridTile(
      //       child: IconLeft2(
      //     module: eachPost,
      //   )));
      // });
      // return GridView.count(
      //   crossAxisCount: 2,
      //   childAspectRatio: 1.0 / 0.75,
      //   // mainAxisSpacing: 1.5,
      //   // crossAxisSpacing: 1.5,
      //   shrinkWrap: true,
      //   physics: BouncingScrollPhysics(),
      //   children: gridTilesList,
      // );
      List<GridTile> gridTilesList = [];
      videoList.forEach((eachPost) {
        gridTilesList.add(GridTile(
            child: filebutton(
          module: eachPost,
        )));
      });
      return ListView(
        children: gridTilesList,
        physics: BouncingScrollPhysics(),
      );
      // return Column(
      //   children: postsList,

    }
  }

  var progressString = "";
  Container filebutton(
      {String scheme, String sem, String branch, Note module}) {
    return
        // GestureDetector(
        //   onTap: () {
        //     print(widget.module.link);
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => PDFScreen(
        //                   postId: widget.module.link,
        //                   title: widget.module.mod,
        //                 )));
        //     // _launchInWebViewWithJavaScript(widget.module.link);
        //     //
        //     // view();
        //   },
        //   child:
        Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 44, 42, 43),
              borderRadius: BorderRadius.circular(25),
            ),
            height: 120,
            width: 100,
            margin: //widget.kkk == 20
                EdgeInsets.fromLTRB(10, 5, 10, 20),
            //: EdgeInsets.fromLTRB(20, 0, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Container(
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           fit: BoxFit.cover,
                //           image: AssetImage("images/Video Lectures.png"))),
                // ),

                // Container(
                //   padding: EdgeInsets.all(10),
                //   height: 100,
                //   width: 100,
                //   child:
                //       Image(fit: BoxFit.fill, image: AssetImage("images/GPA.png")),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "${module.mod}",
                        style: headingstyle,
                      ),
                      RaisedButton(
                        color: Colors.lightBlueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PDFScreen(
                                        postId: module.link,
                                        title: module.mod,
                                      )));
                        },
                        child: new Text("View file"),
                      ),
                      Text("Size " + filesize(module.size)),
                    ],
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () async {
                    SnackBar snackBar = SnackBar(content: Text("Fetching Url"));
                    _scaffoldKey1.currentState.showSnackBar(snackBar);
                    final String url = await FirebaseStorage.instance
                        .ref()
                        .child("Module/${module.link}")
                        .getDownloadURL();
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      Dio dio = Dio();

                      try {
                        final externaldir = await getExternalStorageDirectory();
                        print(externaldir.path);

                        await dio.download(
                            url, "${externaldir.path}/${module.mod}.pdf",
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
            )
            // : Center(
            //     child: downloading
            //         ? Container(
            //             height: 120.0,
            //             width: 200.0,
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 CircularProgressIndicator(),
            //                 SizedBox(
            //                   height: 20.0,
            //                 ),
            //                 Text(
            //                   "Downloading File: $progressString",
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                   ),
            //                 )
            //               ],
            //             ),
            //           )
            //         : Text("No Data"),
            //   ),
            );
  }
}

// class IconLeft2 extends StatefulWidget {
//   final String scheme;
//   final String sem;
//   final String branch;
//   final Note module;
//   IconLeft2({this.scheme, this.sem, this.branch, this.module});

//   @override
//   _IconLeft2State createState() => _IconLeft2State();
// }

// class _IconLeft2State extends State<IconLeft2> {
//   // Future<void> _launchInWebViewWithJavaScript(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(
//   //       url,
//   //       forceSafariVC: true,
//   //       forceWebView: true,
//   //       enableJavaScript: true,
//   //     );
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }
//   //var dir
//   // Future<void> _launchInWebViewWithJavaScript(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(
//   //       url,
//   //       forceSafariVC: true,
//   //       forceWebView: true,
//   //       enableJavaScript: true,
//   //     );
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }

//   // WebviewScaffold view(String url) {
//   //   return WebviewScaffold(
//   //     url: url,
//   //     appBar: AppBar(
//   //       actions: <Widget>[
//   //         IconButton(
//   //           icon: Icon(Icons.file_download),
//   //           onPressed: () async {
//   //             final status = await Permission.storage.request();
//   //             if (status.isGranted) {
//   //               final externaldir = await getExternalStorageDirectory();
//   //               print(externaldir.path);
//   //               final id = await FlutterDownloader.enqueue(
//   //                 url: widget.module.link,
//   //                 savedDir: externaldir.path,
//   //                 fileName: widget.module.mod,
//   //                 showNotification: true,
//   //                 openFileFromNotification: true,
//   //               );
//   //             } else {
//   //               print("nooooooo");
//   //             }
//   //           },
//   //         )
//   //       ],
//   //       title: Text(widget.module.mod),
//   //     ),
//   //   );
//   // }
//   bool downloading = false;
//   var progressString = "";

//   @override
//   Widget build(BuildContext context) {
//     return
//         // GestureDetector(
//         //   onTap: () {
//         //     print(widget.module.link);
//         //     Navigator.push(
//         //         context,
//         //         MaterialPageRoute(
//         //             builder: (context) => PDFScreen(
//         //                   postId: widget.module.link,
//         //                   title: widget.module.mod,
//         //                 )));
//         //     // _launchInWebViewWithJavaScript(widget.module.link);
//         //     //
//         //     // view();
//         //   },
//         //   child:
//         Container(
//       decoration: BoxDecoration(
//         color: Color.fromARGB(255, 44, 42, 43),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       height: 120,
//       width: 100,
//       margin: //widget.kkk == 20
//           EdgeInsets.fromLTRB(10, 5, 10, 20),
//       //: EdgeInsets.fromLTRB(20, 0, 10, 10),
//       child: downloading == false
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 // Container(
//                 //   decoration: BoxDecoration(
//                 //       image: DecorationImage(
//                 //           fit: BoxFit.cover,
//                 //           image: AssetImage("images/Video Lectures.png"))),
//                 // ),

//                 // Container(
//                 //   padding: EdgeInsets.all(10),
//                 //   height: 100,
//                 //   width: 100,
//                 //   child:
//                 //       Image(fit: BoxFit.fill, image: AssetImage("images/GPA.png")),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Text(
//                         "${widget.module.mod}",
//                         style: headingstyle,
//                       ),
//                       RaisedButton(
//                         color: Colors.lightBlueAccent,
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => PDFScreen(
//                                         postId: widget.module.link,
//                                         title: widget.module.mod,
//                                       )));
//                         },
//                         child: new Text("View file"),
//                       ),
//                       Text("Size " + filesize(widget.module.size)),
//                     ],
//                   ),
//                 ),

//                 IconButton(
//                   icon: Icon(Icons.file_download),
//                   onPressed: () async {
//                     final String url = await FirebaseStorage.instance
//                         .ref()
//                         .child("Module/${widget.module.link}")
//                         .getDownloadURL();
//                     final status = await Permission.storage.request();
//                     if (status.isGranted) {
//                       Dio dio = Dio();

//                       try {
//                         final externaldir = await getExternalStorageDirectory();
//                         print(externaldir.path);

//                         await dio.download(
//                             url, "${externaldir.path}/${widget.module.mod}.pdf",
//                             onReceiveProgress: (rec, total) {
//                           // print("Rec: $rec , Total: $total");

//                           setState(() {
//                             downloading = true;
//                             progressString =
//                                 ((rec / total) * 100).toStringAsFixed(0) + "%";
//                           });
//                         });
//                       } catch (e) {
//                         print(e);
//                       }
//                       setState(() {
//                         downloading = false;
//                         progressString = "Completed";
//                       });
//                       print("Download completed");
//                     } else {
//                       print("nooooooo");
//                     }
//                   },
//                 )
//               ],
//             )
//           : Center(
//               child: downloading
//                   ? Container(
//                       height: 120.0,
//                       width: 200.0,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           CircularProgressIndicator(),
//                           SizedBox(
//                             height: 20.0,
//                           ),
//                           Text(
//                             "Downloading File: $progressString",
//                             style: TextStyle(
//                               color: Colors.white,
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   : Text("No Data"),
//             ),
//     );
//   }
// }

///[Upload notes]
// class NotesUpload extends StatefulWidget {
//   @override
//   _NotesUploadState createState() => _NotesUploadState();
// }

// class _NotesUploadState extends State<NotesUpload> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

//   String dropdownValue = "CSE";
//   String dropdownValue1 = "S1";
//   String dropdownValue2 = "2015";
//   String dropdownValue3 = "Module 1";
//   String dropdownValue4 = "OS";
//   String filetype;
//   String title;
//   bool uploading = false;
//   File file;
//   String postid = Uuid().v4();
//   List<String> subject = ['OS', 'COA'];

//   changeofscheme() {
//     if (dropdownValue2 == "2015") {
//       if (dropdownValue1 == "S1") {
//         if (dropdownValue == "CSE") {
//           dropdownValue4 = "OS";
//           subject = ['OS', 'COA'];
//         }
//         if (dropdownValue == "CE") {
//           dropdownValue4 = "OS";
//           subject = ['OS', 'COA'];
//         }
//         if (dropdownValue == "EC") {
//           dropdownValue4 = "OS";
//           subject = ['OS', 'COA', 'poyeda'];
//         }
//         if (dropdownValue == "EE") {
//           dropdownValue4 = "OS";
//           subject = ['OS', 'COA', "ambo"];
//         }
//         if (dropdownValue == "ME") {}
//         if (dropdownValue == "IT") {}
//       }

//       ///[]
//       if (dropdownValue1 == "S2") {
//         if (dropdownValue == "CSE") {}
//         if (dropdownValue == "CE") {}
//         if (dropdownValue == "EC") {}
//         if (dropdownValue == "EE") {}
//         if (dropdownValue == "ME") {}
//         if (dropdownValue == "IT") {}
//       }
//       if (dropdownValue1 == "S3") {
//         if (dropdownValue == "CSE") {}
//         if (dropdownValue == "CE") {}
//         if (dropdownValue == "EC") {}
//         if (dropdownValue == "EE") {}
//         if (dropdownValue == "ME") {}
//         if (dropdownValue == "IT") {}
//       }
//       if (dropdownValue1 == "S4") {
//         if (dropdownValue == "CSE") {}
//         if (dropdownValue == "CE") {}
//         if (dropdownValue == "EC") {}
//         if (dropdownValue == "EE") {}
//         if (dropdownValue == "ME") {}
//         if (dropdownValue == "IT") {}
//       }
//       if (dropdownValue1 == "S5") {
//         if (dropdownValue == "CSE") {}
//         if (dropdownValue == "CE") {}
//         if (dropdownValue == "EC") {}
//         if (dropdownValue == "EE") {}
//         if (dropdownValue == "ME") {}
//         if (dropdownValue == "IT") {}
//       }
//       if (dropdownValue1 == "S6") {
//         if (dropdownValue == "CSE") {}
//         if (dropdownValue == "CE") {}
//         if (dropdownValue == "EC") {}
//         if (dropdownValue == "EE") {}
//         if (dropdownValue == "ME") {}
//         if (dropdownValue == "IT") {}
//       }
//       if (dropdownValue1 == "S7") {
//         if (dropdownValue == "CSE") {}
//         if (dropdownValue == "CE") {}
//         if (dropdownValue == "EC") {}
//         if (dropdownValue == "EE") {}
//         if (dropdownValue == "ME") {}
//         if (dropdownValue == "IT") {}
//       }
//       if (dropdownValue1 == "S8") {
//         if (dropdownValue == "CSE") {}
//         if (dropdownValue == "CE") {}
//         if (dropdownValue == "EC") {}
//         if (dropdownValue == "EE") {}
//         if (dropdownValue == "ME") {}
//         if (dropdownValue == "IT") {}
//       }
//     } else if (dropdownValue2 == "2019") {
//       if (dropdownValue1 == "S1") {}
//       if (dropdownValue1 == "S2") {}
//       if (dropdownValue1 == "S3") {}
//       if (dropdownValue1 == "S4") {}
//       if (dropdownValue1 == "S5") {}
//       if (dropdownValue1 == "S6") {}
//       if (dropdownValue1 == "S7") {}
//       if (dropdownValue1 == "S8") {}
//     }
//   }

//   @override
//   void initState() {
//     // showAlertDialog(context);

//     // TODO: implement initState
//     super.initState();
//   }

//   showAlertDialog(BuildContext context) {
//     // set up the buttons

//     Widget continueButton = OutlineButton(
//       child: Text("Continue"),
//       onPressed: () {},
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("About"),
//       content: Text(
//           "Here you can upload a note of your own and the notes will be available on the respective subjects only after admins approval"),
//       actions: [
//         continueButton,
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (filetype == null) {
//       return uploadMain();
//     } else if (filetype == "pdf") {
//       return pdfScreen();
//     }
//   }

//   Scaffold uploadMain() {
//     return Scaffold(
//       body: ListView(children: <Widget>[
//         Form(
//           key: _formKey,
//           child: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 44, 42, 43),
//                     boxShadow: [
//                       //background color of box
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 10.0, // soften the shadow
//                         spreadRadius: 5.0, //extend the shadow
//                         offset: Offset(
//                           5.0, // Move to right 10  horizontally
//                           5.0, // Move to bottom 10 Vertically
//                         ),
//                       )
//                     ],
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   height: 300,
//                   padding: EdgeInsets.all(10),
//                   margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Text(
//                             "Branch",
//                             style:
//                                 TextStyle(color: Colors.white54, fontSize: 22),
//                           ),
//                           // Container(
//                           //     // color: Colors.white54,
//                           //     // margin:
//                           //     //     EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
//                           //     decoration: ShapeDecoration(
//                           //       shape: RoundedRectangleBorder(
//                           //         borderRadius:
//                           //             BorderRadius.all(Radius.circular(22.0)),
//                           //       ),
//                           //     ),
//                           Container(
//                               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(25)),
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                   child: new DropdownButton<String>(
//                                 dropdownColor: Colors.white,
//                                 value: dropdownValue,
//                                 icon: Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.black54,
//                                   size: 30,
//                                 ),
//                                 iconSize: 24,
//                                 elevation: 16,
//                                 style: new TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 20,
//                                 ),
//                                 underline: Container(
//                                   height: 2,
//                                   color: Colors.deepPurpleAccent,
//                                 ),
//                                 onChanged: (String newValue) {
//                                   setState(() {
//                                     dropdownValue = newValue;
//                                     changeofscheme();
//                                   });
//                                 },
//                                 items: <String>[
//                                   "CSE",
//                                   "CE",
//                                   "EC",
//                                   "EE",
//                                   "ME",
//                                   "IT"
//                                 ].map<DropdownMenuItem<String>>((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                               )))
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Text(
//                             "Semester",
//                             style:
//                                 TextStyle(color: Colors.white54, fontSize: 22),
//                           ),
//                           // Container(
//                           //     // color: Colors.white54,
//                           //     // margin:
//                           //     //     EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
//                           //     decoration: ShapeDecoration(
//                           //       shape: RoundedRectangleBorder(
//                           //         borderRadius:
//                           //             BorderRadius.all(Radius.circular(22.0)),
//                           //       ),
//                           //     ),
//                           Container(
//                               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(25)),
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                   child: new DropdownButton<String>(
//                                 dropdownColor: Colors.white,
//                                 value: dropdownValue1,
//                                 icon: Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.black54,
//                                   size: 30,
//                                 ),
//                                 iconSize: 24,
//                                 elevation: 16,
//                                 style: new TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 20,
//                                 ),
//                                 underline: Container(
//                                   height: 2,
//                                   color: Colors.deepPurpleAccent,
//                                 ),
//                                 onChanged: (String newValue) {
//                                   setState(() {
//                                     dropdownValue1 = newValue;
//                                     changeofscheme();
//                                   });
//                                 },
//                                 items: <String>[
//                                   "S1",
//                                   "S2",
//                                   "S3",
//                                   "S4",
//                                   "S5",
//                                   "S6",
//                                   "S7",
//                                   "S8"
//                                 ].map<DropdownMenuItem<String>>((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                               )))
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Text(
//                             "Scheme",
//                             style:
//                                 TextStyle(color: Colors.white54, fontSize: 22),
//                           ),
//                           // Container(
//                           //     // color: Colors.white54,
//                           //     // margin:
//                           //     //     EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
//                           //     decoration: ShapeDecoration(
//                           //       shape: RoundedRectangleBorder(
//                           //         borderRadius:
//                           //             BorderRadius.all(Radius.circular(22.0)),
//                           //       ),
//                           //     ),
//                           Container(
//                               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(25)),
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                   child: new DropdownButton<String>(
//                                 dropdownColor: Colors.white,
//                                 value: dropdownValue2,
//                                 icon: Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.black54,
//                                   size: 30,
//                                 ),
//                                 iconSize: 24,
//                                 elevation: 16,
//                                 style: new TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 20,
//                                 ),
//                                 underline: Container(
//                                   height: 2,
//                                   color: Colors.deepPurpleAccent,
//                                 ),
//                                 onChanged: (String newValue) {
//                                   setState(() {
//                                     dropdownValue2 = newValue;
//                                     changeofscheme();
//                                   });
//                                 },
//                                 items: <String>[
//                                   "2015",
//                                   "2019"
//                                 ].map<DropdownMenuItem<String>>((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                               )))
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Text(
//                             "Subject",
//                             style:
//                                 TextStyle(color: Colors.white54, fontSize: 22),
//                           ),
//                           // Container(
//                           //     // color: Colors.white54,
//                           //     // margin:
//                           //     //     EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
//                           //     decoration: ShapeDecoration(
//                           //       shape: RoundedRectangleBorder(
//                           //         borderRadius:
//                           //             BorderRadius.all(Radius.circular(22.0)),
//                           //       ),
//                           //     ),
//                           Container(
//                               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(25)),
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                   child: new DropdownButton<String>(
//                                 dropdownColor: Colors.white,
//                                 value: dropdownValue4,
//                                 icon: Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.black54,
//                                   size: 30,
//                                 ),
//                                 iconSize: 24,
//                                 elevation: 16,
//                                 style: new TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 20,
//                                 ),
//                                 underline: Container(
//                                   height: 2,
//                                   color: Colors.deepPurpleAccent,
//                                 ),
//                                 onChanged: (String newValue) {
//                                   setState(() {
//                                     dropdownValue4 = newValue;
//                                   });
//                                 },
//                                 items: subject.map<DropdownMenuItem<String>>(
//                                     (String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                               )))
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Text(
//                             "Module",
//                             style:
//                                 TextStyle(color: Colors.white54, fontSize: 22),
//                           ),
//                           // Container(
//                           //     // color: Colors.white54,
//                           //     // margin:
//                           //     //     EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
//                           //     decoration: ShapeDecoration(
//                           //       shape: RoundedRectangleBorder(
//                           //         borderRadius:
//                           //             BorderRadius.all(Radius.circular(22.0)),
//                           //       ),
//                           //     ),
//                           Container(
//                               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                               decoration: ShapeDecoration(
//                                 color: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(25)),
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                   child: new DropdownButton<String>(
//                                 dropdownColor: Colors.white,
//                                 value: dropdownValue3,
//                                 icon: Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Colors.black54,
//                                   size: 30,
//                                 ),
//                                 iconSize: 24,
//                                 elevation: 16,
//                                 style: new TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 20,
//                                 ),
//                                 underline: Container(
//                                   height: 2,
//                                   color: Colors.deepPurpleAccent,
//                                 ),
//                                 onChanged: (String newValue) {
//                                   setState(() {
//                                     dropdownValue3 = newValue;
//                                   });
//                                 },
//                                 items: <String>[
//                                   "Module 1",
//                                   "Module 2",
//                                   "Module 3",
//                                   "Module 4",
//                                   "Module 5",
//                                   "Module 6",
//                                 ].map<DropdownMenuItem<String>>((String value) {
//                                   return DropdownMenuItem<String>(
//                                     value: value,
//                                     child: Text(value),
//                                   );
//                                 }).toList(),
//                               )))
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Container(
//                       child: Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             getPdfAndUpload();
//                           },
//                           child: Container(
//                             height: 50.0,
//                             width: 150.0,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 "Choose file",
//                                 style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 20.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         proceed(dropdownValue, dropdownValue1, dropdownValue2,
//                             dropdownValue3);
//                       },
//                       child: Container(
//                         height: 55.0,
//                         width: 360.0,
//                         decoration: BoxDecoration(
//                           color: Colors.white60,
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text(
//                                 "Upload",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Icon(Icons.file_upload)
//                             ]),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ]),
//     );
//   }

//   _backnav() {
//     setState(() {
//       filetype = null;
//     });
//     return false;
//   }

//   WillPopScope pdfScreen() {
//     return WillPopScope(
//       onWillPop: () => _backnav(),
//       child: PDFViewerScaffold(
//           appBar: PreferredSize(
//               child: AppBar(
//                 leading: IconButton(
//                     icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//                     onPressed: () {
//                       setState(() {
//                         filetype = null;
//                       });
//                     }),
//                 backgroundColor: Colors.white,
//                 title: Form(
//                   key: _formKey1,
//                   child: TextFormField(
//                     style: TextStyle(color: Colors.black),
//                     decoration: InputDecoration(
//                         hintText: "Give title",
//                         hintStyle: TextStyle(color: Colors.black54)),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "";
//                       }
//                     },
//                     onSaved: (val) => title = val,
//                   ),
//                 ),
//                 centerTitle: true,
//                 actions: <Widget>[
//                   IconButton(
//                       icon: Icon(Icons.file_upload, color: Colors.black),
//                       onPressed: () {
//                         final form = _formKey1.currentState;
//                         if (form.validate()) {
//                           form.save();
//                           savePdf(file.readAsBytesSync(), title);
//                           setState(() {
//                             filetype = null;
//                           });
//                         }
//                       }),
//                 ],
//               ),
//               preferredSize: Size.fromHeight(70.0)), //AppBar(
//           //   backgroundColor: Colors.blue,
//           //   title: Text("title"),
//           //   actions: <Widget>[
//           //     IconButton(
//           //       icon: Icon(Icons.share),
//           //       onPressed: () {},
//           //     ),
//           //   ],
//           // ),
//           path: file.path),
//     );
//     // Scaffold(
//     //   appBar: AppBar(
//     //     actions: <Widget>[
//     //       FlatButton(
//     //           onPressed: () {
//     //             savePdf(file.readAsBytesSync(), fileName);
//     //           },
//     //           child: Container(
//     //             child: Text("Upload"),
//     //           ))
//     //     ],
//     //   ),
//     // );
//   }

//   Future getPdfAndUpload() async {
//     var rng = new Random();
//     String randomName = "";
//     for (var i = 0; i < 20; i++) {
//       print(rng.nextInt(100));
//       randomName += rng.nextInt(100).toString();
//     }
//     file = await FilePicker.getFile(
//         type: FileType.custom, allowedExtensions: ['pdf']);
//     print("$file  asfasfasfasfasfasfasf");
//     String fileName = '${randomName}.pdf';
//     print(fileName);
//     print('${file.readAsBytesSync()}');
//     if (file != null) {
//       setState(() {
//         filetype = "pdf";
//       });
//     }
//   }

//   Future savePdf(List<int> asset, String name) async {
//     StorageReference reference = FirebaseStorage.instance.ref().child("Module");
//     StorageUploadTask uploadTask = reference.child(postid).putData(asset);
//     String url = await (await uploadTask.onComplete).ref.getDownloadURL();
//     setState(() {
//       uploading = false;
//       filetype = null;
//     });
//     print(url);
//     saveDatabase(title: title, url: url);
//     return url;
//   }

//   saveDatabase({String title, String url}) {
//     noteref
//         .document(dropdownValue2)
//         .collection(dropdownValue2)
//         .document(dropdownValue1)
//         .collection(dropdownValue1)
//         .document(dropdownValue)
//         .collection(dropdownValue)
//         .document(dropdownValue4)
//         .setData({"val": dropdownValue4});
//     noteref
//         .document(dropdownValue2)
//         .collection(dropdownValue2)
//         .document(dropdownValue1)
//         .collection(dropdownValue1)
//         .document(dropdownValue)
//         .collection(dropdownValue)
//         .document(dropdownValue4)
//         .collection(dropdownValue4)
//         .document(dropdownValue3)
//         .setData({"val": dropdownValue3});
//     noteref
//         .document(dropdownValue2)
//         .collection(dropdownValue2)
//         .document(dropdownValue1)
//         .collection(dropdownValue1)
//         .document(dropdownValue)
//         .collection(dropdownValue)
//         .document(dropdownValue4)
//         .collection(dropdownValue4)
//         .document(dropdownValue3)
//         .collection(dropdownValue3)
//         .document()
//         .setData({
//       "mod": title,
//       "approval": "a",
//       "link": url,
//       "size": filesize(file.lengthSync())
//     });
//     notereq.document().setData({
//       "scheme": dropdownValue2,
//       "semester": dropdownValue1,
//       "branch": dropdownValue,
//       "module": dropdownValue3
//     });
//     postid = new Uuid().v4();
//   }

//   void proceed(String dropdownValue, String dropdownValue1,
//       String dropdownValue2, String dropdownValue3) {}
// }
