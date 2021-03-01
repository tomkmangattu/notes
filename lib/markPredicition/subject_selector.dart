import 'package:flutter/material.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:ktuhelp/markPredicition/markPredicition.dart';
import 'package:ktuhelp/markPredicition/selectedData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktuhelp/markPredicition/syllabus_list_widget.dart';

class SubjectSelector extends StatefulWidget {
  @override
  _SubjectSelectorState createState() => _SubjectSelectorState();
}

final _firestore = Firestore.instance;
// Dialog leadDialog = Dialog(
//   child: SingleChildScrollView(
//     child: Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                   '$currentModule TOPIC',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w800,
//                       fontSize: 20)
//               ),
//               Text(
//                   'MARKS',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w800,
//                       fontSize: 20)
//               ),
//
//             ],
//           ),
//           SizedBox(height: 20,),
//           StreamBuilder<QuerySnapshot>(
//             stream: _firestore.collection("syllabus").doc("$schemeValue1").collection("$branchValue1").doc("$semValue1").collection("$semValue1").doc("$currentSub").collection("$currentModule").snapshots(),
//             builder: (context,snapshot){
//               if(snapshot.data == null) return CircularProgressIndicator();
//               if(snapshot.hasData){
//                 final stokes = snapshot.data.docs;
//                 List<Widget>syllabusWidgets = [];
//                 for(var stock in stokes){
//                   final topic = stock.data()['topic'];
//                   final marks = stock.data()['marks'];
//                   final syllabusWidget = StockList(name: topic,mark: marks,);
//                   syllabusWidgets.add(syllabusWidget);
//                 }
//                 return Column(
//                     children: syllabusWidgets
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     ),
//   ),
// );
// void _showDialog(BuildContext context) {
//   // flutter defined function
//   showDialog(
//     context: context,
//     builder: (context) {
//       // return object of type Dialog
//       return AlertDialog(
//         title: Text('Completed Sections'),
//         contentPadding: EdgeInsets.only(top: 12.0),
//         content: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(
//                         '$currentModule TOPICS',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w800,
//                             fontSize: 20)
//                     ),
//                     Text(
//                         'MARKS',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w800,
//                             fontSize: 20)
//                     ),
//
//                   ],
//                 ),
//                 SizedBox(height: 20,),
//                 StreamBuilder<QuerySnapshot>(
//                   stream: _firestore.collection("syllabus").doc("$schemeValue1").collection("$branchValue1").doc("$semValue1").collection("$semValue1").doc("$currentSub").collection("$currentModule").snapshots(),
//                   builder: (context,snapshot){
//                     if(snapshot.data == null) return CircularProgressIndicator();
//                     if(snapshot.hasData){
//                       final stokes = snapshot.data.docs;
//                       List<Widget>syllabusWidgets = [];
//                       for(var stock in stokes){
//                         final topic = stock.data()['topic'];
//                         final marks = stock.data()['marks'];
//                         final syllabusWidget = StockList(name: topic,mark: marks,);
//                         syllabusWidgets.add(syllabusWidget);
//                       }
//                       return Column(
//                           children: syllabusWidgets
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('CANCEL'),
//             onPressed:() {},
//           ),
//           FlatButton(
//             child: Text('OK'),
//             onPressed:(){},
//           )
//         ],
//       );
//     },
//   );
// }

// class MultiSelectDialogItem<V> {
//   const MultiSelectDialogItem(this.value, this.label);
//
//   final V value;
//   final String label;
// }
//
// class MultiSelectDialog<V> extends StatefulWidget {
//   MultiSelectDialog({Key key, this.items, this.initialSelectedValues}) : super(key: key);
//
//   final List<MultiSelectDialogItem<V>> items;
//   final Set<V> initialSelectedValues;
//
//   @override
//   State<StatefulWidget> createState() => _MultiSelectDialogState<V>();
// }
//
// class _MultiSelectDialogState<V> extends State<MultiSelectDialog<V>> {
//   final _selectedValues = Set<V>();
//
//   void initState() {
//     super.initState();
//     if (widget.initialSelectedValues != null) {
//       _selectedValues.addAll(widget.initialSelectedValues);
//     }
//   }
//
//   void _onItemCheckedChange(V itemValue, bool checked) {
//     setState(() {
//       if (checked) {
//         _selectedValues.add(itemValue);
//       } else {
//         _selectedValues.remove(itemValue);
//       }
//     });
//   }
//
//   void _onCancelTap() {
//     Navigator.pop(context);
//   }
//
//   void _onSubmitTap() {
//     Navigator.pop(context, _selectedValues);
//   }

// Widget _buildItem(MultiSelectDialogItem<V> item) {
//   final checked = _selectedValues.contains(item.value);
//   return CheckboxListTile(
//     value: checked,
//     title: Text(item.label),
//     controlAffinity: ListTileControlAffinity.leading,
//     onChanged: (checked) => _onItemCheckedChange(item.value, checked),
//   );
// }

// List <MultiSelectDialogItem<int>> multiItem = List();
//
// final valuestopopulate = {
//   1 : "Sustainable development",
//   2 : "Livelihood security",
//   3 : "Challenges for sustainability",
//   4 : "Clean Development Mechanism(CDM)",
//   5 : "Social-environmental-economical sustainability",
//   6 : "solar energy",
//   7 : "wind energy",
//   8 : "hydro electric power",
//   9 : "wave power",
//   10 : "tidal power ",
// };

// void populateMultiselect(){
//   for(int v in valuestopopulate.keys){
//     multiItem.add(MultiSelectDialogItem(v, valuestopopulate[v]));
//   }
// }
//
//
// void _showMultiSelect(BuildContext context) async {
//   multiItem = [];
//   populateMultiselect();
//   final items = multiItem;
//
//
//   final selectedValues = await showDialog<Set<int>>(
//     context: context,
//     builder: (BuildContext context) {
//       return MultiSelectDialog(
//         items: items,
//         // initialSelectedValues: [0,-1].toSet(),
//       );
//     },
//   );
//
//   print(selectedValues);
//   getvaluefromkey(selectedValues);
// }
//
// void getvaluefromkey(Set selection){
//   if(selection != null){
//     for(int x in selection.toList()){
//       print(valuestopopulate[x]);
//     }
//   }
// }
//
//

class _SubjectSelectorState extends State<SubjectSelector> {
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
                          marks: MODULE1marks,
                        ),
                        ModuleBox(
                          moduleName: "MODULE2",
                          marks: MODULE2marks,
                        ),
                        ModuleBox(
                          moduleName: "MODULE3",
                          marks: MODULE3marks,
                        ),
                        ModuleBox(
                          moduleName: "MODULE4",
                          marks: MODULE4marks,
                        ),
                        ModuleBox(
                          moduleName: "MODULE5",
                          marks: MODULE5marks,
                        ),
                        ModuleBox(
                          moduleName: "MODULE6",
                          marks: MODULE6marks,
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
            BottomButton(
                onTap: () {
                  setState(() {
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
                              content: Text(
                                  'Your Predicted marks is ' +
                                      (int.parse(MODULE1marks) +
                                              int.parse(MODULE2marks) +
                                              int.parse(MODULE3marks) +
                                              int.parse(MODULE4marks) +
                                              int.parse(MODULE5marks) +
                                              int.parse(MODULE6marks))
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center),
                            ));
                  });
                },
                buttonTitle: 'CALCULATE')
          ],
        ),
      )),
    );
  }

  Padding subjectselector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 10, 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(),
            color: Colors.white),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: dropdownvalue,
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
                MODULE1marks = '0';
                MODULE2marks = '0';
                MODULE3marks = '0';
                MODULE4marks = '0';
                MODULE5marks = '0';
                MODULE6marks = '0';

                dropdownvalue = newValue;
                currentSub = dropdownvalue;
              });
            },
            items: subjectList.map<DropdownMenuItem<String>>((String value) {
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
  ModuleBox({@required this.moduleName, @required this.marks});
  final String moduleName;
  final String marks;

  @override
  _ModuleBoxState createState() => _ModuleBoxState();
}

class _ModuleBoxState extends State<ModuleBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentModule = widget.moduleName;
            print(widget.moduleName);
            totalMark = 0;
            controllerVisibility = true;

            Navigator.pushNamed(context, "Mark Selector");
          });
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
                          widget.marks,
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
  BottomButton({@required this.onTap, @required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
            child: Text(
          buttonTitle,
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
    );
  }
}
