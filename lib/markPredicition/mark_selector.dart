import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktuhelp/markPredicition/selectedData.dart';
import 'package:ktuhelp/markPredicition/syllabus_list_widget.dart';
import 'package:provider/provider.dart';

class MarkSelector extends StatefulWidget {
  final int moduleNo;
  final String subjectName;
  final CollectionReference subjectRef;
  MarkSelector(
      {@required this.moduleNo,
      @required this.subjectName,
      @required this.subjectRef});
  @override
  _MarkSelectorState createState() => _MarkSelectorState();
}

class _MarkSelectorState extends State<MarkSelector> {
  // void initState() {
  //   _resetModuleMark();
  //   super.initState();
  // }

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'MARKS',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.height / 25,
                  ),
                  Text(
                    'MODULE ${widget.moduleNo + 1} TOPICS',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: widget.subjectRef
                    .document(widget.subjectName)
                    .collection(widget.subjectName)
                    .document('module${widget.moduleNo + 1}')
                    .collection('module${widget.moduleNo + 1}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return CircularProgressIndicator();
                  if (snapshot.hasData) {
                    final stokes = snapshot.data.documents;
                    List<Widget> syllabusWidgets = [];
                    for (var stock in stokes) {
                      final topic = stock.documentID.toString();
                      final marks = stock.data['mark'];
                      final syllabusWidget = StockList(
                        name: topic,
                        mark: marks,
                        moduleNo: widget.moduleNo,
                      );
                      syllabusWidgets.add(syllabusWidget);
                    }
                    return Column(children: syllabusWidgets);
                    // if (syllabusWidgets.length >= 2) {
                    //   print(syllabusWidgets.length);
                    //   return Column(children: syllabusWidgets);
                    // } else {
                    //   return CircularProgressIndicator();
                    // }
                    // Map<String, dynamic> topicmarks = {};
                    // for (DocumentSnapshot docs in snapshot.data.documents) {
                    //   topicmarks[docs.documentID] = docs.data['mark'];
                    // }

                    // debugPrint(topicmarks.toString());

                  }
                  return Text('Data is empty');
                },
              ),

              // BottomButton(
              //     onTap: () {
              //       print(totalMark);
              //       setState(() {
              //         controllerVisibility = false;
              //         dropdownvalue = currentSub;
              //         Navigator.pushNamed(context, 'Subject Selector');
              //         if (currentModule == 'MODULE1') {
              //           MODULE1marks = totalMark.toString();
              //         } else if (currentModule == 'MODULE2') {
              //           MODULE2marks = totalMark;
              //         } else if (currentModule == 'MODULE3') {
              //           MODULE3marks = totalMark;
              //         } else if (currentModule == 'MODULE4') {
              //           MODULE4marks = totalMark;
              //         } else if (currentModule == 'MODULE5') {
              //           MODULE5marks = totalMark;
              //         } else if (currentModule == 'MODULE6') {
              //           MODULE6marks = totalMark;
              //         }
              //       });
              //     },
              //     buttonTitle: 'Save'),
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
