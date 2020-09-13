import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'circularprogress1.dart';
import 'videofirebase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
final videoref = Firestore.instance.collection("videos");

class VideoLectureProceed extends StatefulWidget {
  @override
  _VideoLectureProceedState createState() => _VideoLectureProceedState();
}

class _VideoLectureProceedState extends State<VideoLectureProceed> {
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
      body: Form(
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
                          style: TextStyle(color: Colors.white54, fontSize: 22),
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
                          style: TextStyle(color: Colors.white54, fontSize: 22),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
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
            ],
          ),
        ),
      ),
    );
  }

  // proceed(String branch, String sem, String scheme) {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     print("$dropdownValue$dropdownValue1$dropdownValue2");
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => VideoSubject(
  //                   sem: sem,
  //                   branch: branch,
  //                 )));
  //   }
  // }
  proceed(String branch, String sem, String scheme) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("$dropdownValue$dropdownValue1$dropdownValue2");

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VideoSubject(sem: sem, branch: branch, scheme: scheme)));
    }
  }
}

class VideoSubject extends StatefulWidget {
  final String sem;
  final String branch;
  final String scheme;
  VideoSubject({this.sem, this.branch, this.scheme});
  @override
  _VideoSubjectState createState() => _VideoSubjectState();
}

class _VideoSubjectState extends State<VideoSubject> {
  List<VideoSem> videoList = [];
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
      querySnapshot = await videoref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .getDocuments();
      print("hello");
    } else {
      querySnapshot = await videoref
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.branch)
          .collection(widget.branch)
          .getDocuments();
    }
    setState(() {
      loading = false;

      videoList = querySnapshot.documents
          .map((documentSnapshot) => VideoSem.fromDocument(documentSnapshot))
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
  final VideoSem subject;
  IconLeft({this.sem, this.branch, this.subject, this.scheme});

  @override
  _IconState createState() => _IconState();
}

class _IconState extends State<IconLeft> {
  //var dir

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VideoModule(
                    scheme: widget.scheme,
                    sem: widget.sem,
                    branch: widget.branch,
                    subject: widget.subject.val,
                    modnum: widget.subject.max,
                  ))),
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

class VideoModule extends StatefulWidget {
  final String scheme;
  final String sem;
  final String branch;
  final String subject;
  final String modnum;
  VideoModule({this.sem, this.branch, this.subject, this.modnum, this.scheme});
  @override
  _VideoModuleState createState() => _VideoModuleState();
}

class _VideoModuleState extends State<VideoModule> {
  String modulenumber = "mod1";
  List<Video> videoList = [];
  bool loading = true;
  double _value = 0;
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
              Center(
                child: Container(
                  width: fullWidth ? double.infinity : (sliderHeight) * 5.5,
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
                    padding: EdgeInsets.fromLTRB(sliderHeight * paddingFactor,
                        2, sliderHeight * paddingFactor, 2),
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
                                activeTrackColor: Colors.white.withOpacity(1),
                                inactiveTrackColor:
                                    Colors.white.withOpacity(.5),

                                trackHeight: 4.0,
                                thumbShape: CustomSliderThumbCircle(
                                  thumbRadius: sliderHeight * .4,
                                  min: min,
                                  max: max - 1,
                                ),
                                overlayColor: Colors.white.withOpacity(.4),
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
                                        modulenumber = "mod1";
                                        print("mod1");
                                      } else if (value == 1 / (max - 1)) {
                                        modulenumber = "mod2";
                                        print("mod1");
                                      } else if (value == 2 / (max - 1)) {
                                        modulenumber = "mod3";
                                        print("mod3");
                                      } else if (value == 3 / (max - 1)) {
                                        modulenumber = "mod4";
                                        print("mod3");
                                      } else if (value == 4 / (max - 1)) {
                                        modulenumber = "mod5";
                                        print("mod3");
                                      } else if (value == 5 / (max - 1)) {
                                        modulenumber = "mod2";
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
              Expanded(
                child: displayProfilePost(),
              ),
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
      querySnapshot = await videoref
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
      querySnapshot = await videoref
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
    setState(() {
      loading = false;

      videoList = querySnapshot.documents
          .map((documentSnapshot) => Video.fromDocument(documentSnapshot))
          .toList();
    });
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
            child: IconLeft2(
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
}

class IconLeft2 extends StatefulWidget {
  final String sem;
  final String branch;
  final Video module;
  IconLeft2({this.sem, this.branch, this.module});

  @override
  _IconLeft2State createState() => _IconLeft2State();
}

class _IconLeft2State extends State<IconLeft2> {
  // Future<void> _launchInWebViewWithJavaScript(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: true,
  //       forceWebView: true,
  //       enableJavaScript: true,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
  //var dir

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => YoutubePage(
                      url: widget.module.link,
                      title: widget.module.mod,
                    )));
        // _launchInWebViewWithJavaScript(widget.module.link);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 44, 42, 43),
          borderRadius: BorderRadius.circular(25),
        ),
        height: 100,
        width: 100,
        margin: //widget.kkk == 20
            EdgeInsets.fromLTRB(10, 5, 10, 20),
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
              "${widget.module.mod}",
              style: headingstyle,
            ),
          ],
        ),
      ),
    );
  }
}

// class YoutubePlayerDemoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Youtube Player Flutter',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: const AppBarTheme(
//           color: Colors.blueAccent,
//           textTheme: TextTheme(
//             headline6: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w300,
//               fontSize: 20.0,
//             ),
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.blueAccent,
//         ),
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

/// Homepage
class YoutubePage extends StatefulWidget {
  String url;
  String title;
  YoutubePage({this.url, this.title});
  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        widget.url,
      ),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        // onEnded: (data) {
        //   _controller
        //       .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
        //   _showSnackBar('Next Video Started!');
        // },
      ),
      builder: (context, player) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          title: Text(
            '${widget.title}',
            style: TextStyle(color: Colors.white),
          ),
//          actions: [
//            IconButton(
//              icon: const Icon(Icons.video_library),
//              onPressed: () => Navigator.push(
//                context,
//                CupertinoPageRoute(
//                  builder: (context) => VideoList(),
//                ),
//              ),
//            ),
//          ],
        ),
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  _text('Title', _videoMetaData.title),
                  _space,
                  _text('Channel', _videoMetaData.author),
                  _space,
                  _text('Video Id', _videoMetaData.videoId),
                  _space,
                  Row(
                    children: [
                      _text(
                        'Playback Quality',
                        _controller.value.playbackQuality,
                      ),
                      const Spacer(),
                      _text(
                        'Playback Rate',
                        '${_controller.value.playbackRate}x  ',
                      ),
                    ],
                  ),
                  _space,
                  _space,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.skip_previous),
                      //   onPressed: _isPlayerReady
                      //       ? () => _controller.load(_ids[
                      //           (_ids.indexOf(_controller.metadata.videoId) -
                      //                   1) %
                      //               _ids.length])
                      //       : null,
                      // ),
                      IconButton(
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                        onPressed: _isPlayerReady
                            ? () {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                                setState(() {});
                              }
                            : null,
                      ),
                      IconButton(
                        icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
                        onPressed: _isPlayerReady
                            ? () {
                                _muted
                                    ? _controller.unMute()
                                    : _controller.mute();
                                setState(() {
                                  _muted = !_muted;
                                });
                              }
                            : null,
                      ),
                      FullScreenButton(
                        controller: _controller,
                        color: Colors.blueAccent,
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.skip_next),
                      //   onPressed: _isPlayerReady
                      //       ? () => _controller.load(_ids[
                      //           (_ids.indexOf(_controller.metadata.videoId) +
                      //                   1) %
                      //               _ids.length])
                      //       : null,
                      // ),
                    ],
                  ),
                  _space,
                  Row(
                    children: <Widget>[
                      const Text(
                        "Volume",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Expanded(
                        child: Slider(
                          inactiveColor: Colors.transparent,
                          value: _volume,
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          label: '${(_volume).round()}',
                          onChanged: _isPlayerReady
                              ? (value) {
                                  setState(() {
                                    _volume = value;
                                  });
                                  _controller.setVolume(_volume.round());
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                  _space,
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _getStateColor(_playerState),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _playerState.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700];
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900];
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  // Widget _loadCueButton(String action) {
  //   return Expanded(
  //     child: MaterialButton(
  //       color: Colors.blueAccent,
  //       onPressed: _isPlayerReady
  //           ? () {
  //               if (_idController.text.isNotEmpty) {
  //                 var id = YoutubePlayer.convertUrlToId(
  //                   _idController.text,
  //                 );
  //                 if (action == 'LOAD') _controller.load(id);
  //                 if (action == 'CUE') _controller.cue(id);
  //                 FocusScope.of(context).requestFocus(FocusNode());
  //               } else {
  //                 _showSnackBar('Source can\'t be empty!');
  //               }
  //             }
  //           : null,
  //       disabledColor: Colors.grey,
  //       disabledTextColor: Colors.black,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 14.0),
  //         child: Text(
  //           action,
  //           style: const TextStyle(
  //             fontSize: 18.0,
  //             color: Colors.white,
  //             fontWeight: FontWeight.w300,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
