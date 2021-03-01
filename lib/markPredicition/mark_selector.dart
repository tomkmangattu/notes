import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktuhelp/markPredicition/selectedData.dart';
import 'package:ktuhelp/markPredicition/subject_selector.dart';
import 'package:ktuhelp/markPredicition/syllabus_list_widget.dart';

class MarkSelector extends StatefulWidget {
  @override
  _MarkSelectorState createState() => _MarkSelectorState();
}

class _MarkSelectorState extends State<MarkSelector> {
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 44, 42, 43),

        // title: Text('Total Marks : $totalMark'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('$currentModule TOPIC',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20)),
                  Text('MARKS',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("syllabus")
                    .document("$schemeValue1")
                    .collection("$branchValue1")
                    .document("$semValue1")
                    .collection("$semValue1")
                    .document("$currentSub")
                    .collection("$currentModule")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return CircularProgressIndicator();
                  if (snapshot.hasData) {
                    final stokes = snapshot.data.documents;
                    List<Widget> syllabusWidgets = [];
                    for (var stock in stokes) {
                      final topic = stock.data['topic'];
                      final marks = stock.data['marks'];
                      final syllabusWidget = StockList(
                        name: topic,
                        mark: marks,
                      );
                      syllabusWidgets.add(syllabusWidget);
                    }
                    if (syllabusWidgets.length >= 2) {
                      print(syllabusWidgets.length);
                      return Column(children: syllabusWidgets);
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
                },
              ),

              BottomButton(
                  onTap: () {
                    print(totalMark);
                    setState(() {
                      controllerVisibility = false;
                      dropdownvalue = currentSub;
                      Navigator.pushNamed(context, 'Subject Selector');
                      if (currentModule == 'MODULE1') {
                        MODULE1marks = totalMark.toString();
                      } else if (currentModule == 'MODULE2') {
                        MODULE2marks = totalMark;
                      } else if (currentModule == 'MODULE3') {
                        MODULE3marks = totalMark;
                      } else if (currentModule == 'MODULE4') {
                        MODULE4marks = totalMark;
                      } else if (currentModule == 'MODULE5') {
                        MODULE5marks = totalMark;
                      } else if (currentModule == 'MODULE6') {
                        MODULE6marks = totalMark;
                      }
                    });
                  },
                  buttonTitle: 'Save'),
              // BottomButton(onTap: (){
              //   setState(() {
              //
              //     Navigator.pushNamed(context, 'Subject Selector');
              //   });
              // }
              //     ,
              //     buttonTitle: 'Back')
            ],
          ),
        ),
      ),
    );
  }
}
