import 'package:flutter/material.dart';
import 'package:ktuhelp/circularprogress1.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:ktuhelp/markPredicition/markPredicition.dart';
import 'package:ktuhelp/markPredicition/mark_selector.dart';
import 'package:ktuhelp/markPredicition/selectedData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktuhelp/markPredicition/syllabus_list_widget.dart';
import 'package:provider/provider.dart';
import 'selectedData.dart';

class SubjectSelector extends StatefulWidget {
  final String scheme;
  final String sem;
  final String branch;
  SubjectSelector({this.scheme, this.sem, this.branch});
  @override
  _SubjectSelectorState createState() => _SubjectSelectorState();
}

final markReference = Firestore.instance.collection('syllabus');
String dropDownValue;
CollectionReference subjectReference;

class _SubjectSelectorState extends State<SubjectSelector> {
  @override
  void initState() {
    _getSubjects();
    _resetAllMarks();
    super.initState();
  }

  void _resetAllMarks() {
    Provider.of<Counter>(context, listen: false).resetAllMarks();
  }

  bool _modulesLoading = true;
  List<String> _subjectList = [];

  void _getSubjects() async {
    QuerySnapshot subjectSnapshot;
    if (widget.sem == 'S1' || widget.sem == 'S2') {
      subjectReference = Firestore.instance
          .collection('syllabus')
          .document(widget.scheme)
          .collection(widget.scheme)
          .document('S1')
          .collection('S1');
      // subjectSnapshot = await markReference
      //     .document(widget.scheme)
      //     .collection(widget.scheme)
      //     .document(widget.sem)
      //     .collection(widget.sem)
      //     .getDocuments();
    } else {
      subjectReference = Firestore.instance
          .collection('syllabus')
          .document(widget.scheme)
          .collection(widget.scheme)
          .document(widget.sem)
          .collection(widget.sem)
          .document(widget.branch)
          .collection(widget.branch);
      // subjectSnapshot = await markReference
      //     .document(widget.scheme)
      //     .collection(widget.scheme)
      //     .document(widget.sem)
      //     .collection(widget.sem)
      //     .document(widget.branch)
      //     .collection(widget.branch)
      //     .getDocuments();
    }
    subjectSnapshot = await subjectReference.getDocuments();
    for (var docs in subjectSnapshot.documents) {
      if (docs.documentID != null) {
        // debugPrint(docs.documentID.toString());
        _subjectList.add(docs.documentID.toString());
      }
    }
    debugPrint(_subjectList.toString());
    setState(() {
      _modulesLoading = false;
    });
    dropDownValue = _subjectList[0];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("images/bgm.png"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: TitleText(
                size: 40,
                con: false,
              ),
            ),
            Column(
              children: [
                subjectselector(),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ModuleBox(
                          moduleName: "MODULE1",
                          moduleno: 0,
                        ),
                        ModuleBox(
                          moduleName: "MODULE2",
                          moduleno: 1,
                        ),
                        ModuleBox(
                          moduleName: "MODULE3",
                          moduleno: 2,
                        ),
                        ModuleBox(
                          moduleName: "MODULE4",
                          moduleno: 3,
                        ),
                        ModuleBox(
                          moduleName: "MODULE5",
                          moduleno: 4,
                        ),
                        ModuleBox(
                          moduleName: "MODULE6",
                          moduleno: 5,
                        ),
                      ],
                    ),
                  ),
                )
                // SizedBox(
                //   height: 10,
                // ),
              ],
            ),
            BottomButton()
          ],
        ),
      )),
    );
  }

  Padding subjectselector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 10, 5),
      child: _modulesLoading
          ? circularProgress()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                  color: Colors.white),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: dropDownValue,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black54,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  focusColor: Colors.white,
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.black54, fontSize: 20),
                  onChanged: (String newValue) {
                    setState(() {
                      dropDownValue = newValue;
                      // currentSub = dropdownvalue;
                    });
                    _resetAllMarks();
                  },
                  items: _subjectList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }
}

class ModuleBox extends StatefulWidget {
  ModuleBox({@required this.moduleName, @required this.moduleno});
  final String moduleName;
  final int moduleno;

  @override
  _ModuleBoxState createState() => _ModuleBoxState();
}

class _ModuleBoxState extends State<ModuleBox> {
  // void _incrementCounter(BuildContext context, int module, int mark) {
  //   Provider.of<Counter>(context, listen: false)
  //       .increamentCounter(module, mark);
  // }

  void resetModuleMark(int moduleNo) {
    // debugPrint(moduleNo.toString());
    Provider.of<Counter>(context, listen: false).resetMarks(moduleNo);
  }

  @override
  Widget build(BuildContext context) {
    var _count = Provider.of<Counter>(context).getmarks(widget.moduleno);
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          // _incrementCounter(context, widget.moduleno, 2);
          // setState(() {
          //   // currentModule = widget.moduleName;
          //   // print(widget.moduleName);
          //   // totalMark = 0;
          //   // controllerVisibility = true;
          // });
          setState(() {
            resetModuleMark(widget.moduleno);
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MarkSelector(
                moduleNo: widget.moduleno,
                subjectName: dropDownValue,
                subjectRef: subjectReference,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.moduleName,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Marks',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          _count.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )

                    // Checkbox(
                    //   onChanged: (bool value) {},
                    //   value: false,
                    //   focusColor: Colors.blueAccent,
                    //   activeColor: Colors.blueAccent,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _sum = Provider.of<Counter>(context).getsum();
    return GestureDetector(
      child: Container(
        child: Center(
            child: Text(
          'CALCULATE',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: "Red Hat Display"),
        )),
        color: Colors.white70,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
              'Congratulations',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            content: Text('Your Predicted marks is $_sum',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center),
          ),
        );
      },
    );
  }
}
