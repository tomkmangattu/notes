import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:ktuhelp/val.dart';

String textfor(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

class AttendancePage extends StatefulWidget {
  final DateTime date;
  final bool exist;
  final List att;
  AttendancePage(this.date, this.exist, this.att);
  @override
  _AttendancePageState createState() => new _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<List<int>> history =
      List.generate(subs[batch][sem].length, (index) => [0]);
  List<Map> mark;
  List<Map> markedit = List.generate(
      subs[batch][sem].length, (index) => {'present': 0, 'absent': 0});

  bool submit = false, load = false;
  double getp(int i) {
    if (bottom[i] == 0) {
      return 100;
    } else {
      return (top[i] / bottom[i]) * 100;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.exist)
      mark = widget.att;
    else
      mark = List.generate(
          subs[batch][sem].length, (index) => {'present': 0, 'absent': 0});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0.8),
          centerTitle: true,
          title: TitleText(size: 40, con: false),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
        body: Theme(
          data: ThemeData(fontFamily: 'Montserrat'),
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Attendance Calculator',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Mark Attendance',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 400,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFF959495),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                      child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(0.3),
                            1: FlexColumnWidth(0.5)
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: <TableRow>[
                            TableRow(children: <Widget>[
                              Text(
                                '${textfor(widget.date)}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${DateFormat('EEEE').format(widget.date)}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                            for (int i = 0; i < subs[batch][sem].length; i++)
                              TableRow(children: <Widget>[
                                Tooltip(
                                  message: subs[batch][sem][i],
                                  child: Text(
                                    shorts[batch][sem][i],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: ButtonBar(
                                          buttonPadding: EdgeInsets.all(0),
                                          children: <Widget>[
                                            Text(mark[i]['present'] +
                                                        markedit[i]['present'] >
                                                    0
                                                ? '${mark[i]['present'] + markedit[i]['present']}×'
                                                : '    '),
                                            IconButton(
                                              icon: Icon(Icons.thumb_up),
                                              onPressed: () {
                                                setState(() {
                                                  submit = false;
                                                  markedit[i]['present']++;
                                                  history[i].insert(0, 1);
                                                });
                                              },
                                              color: Colors.green,
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.thumb_down),
                                              onPressed: () {
                                                setState(() {
                                                  submit = false;
                                                  markedit[i]['absent']++;
                                                  history[i].insert(0, -1);
                                                });
                                              },
                                              color: Colors.red[400],
                                            ),
                                            Text(mark[i]['absent'] +
                                                        markedit[i]['absent'] >
                                                    0
                                                ? '${mark[i]['absent'] + markedit[i]['absent']}×'
                                                : '    '),
                                            IconButton(
                                              color: history[i][0] != 0
                                                  ? Colors.grey[600]
                                                  : Colors.grey
                                                      .withOpacity(0.5),
                                              icon: Icon(Icons.undo),
                                              onPressed: () {
                                                if (history[i][0] != 0)
                                                  setState(() {
                                                    if (history[i][0] == -1)
                                                      mark[i]['absent']--;
                                                    else if (history[i][0] == 1)
                                                      mark[i]['present']--;
                                                    history[i].removeAt(0);
                                                  });
                                              },
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ])
                          ])),
                ),
                submit
                    ? Column(
                        children: <Widget>[
                          Text('Your Response has been recorded!'),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            color: Color(0xFFD5D5D5),
                            child: Text(
                              'Back',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () async {
                              List<double> percent = [];
                              for (int i = 0; i < subs[batch][sem].length; i++)
                                percent.add(getp(i));

                              Navigator.pop(context, percent);
                              setState(() {
                                submit = false;
                              });
                            },
                          ),
                        ],
                      )
                    : Container(
                        constraints: BoxConstraints.loose(Size(300, 100)),
                        child: FlatButton(
                          color: Color(0xFFD5D5D5),
                          onPressed: () async {
                            bool submitt = false;
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Are you sure"),
                                content: Text(
                                    "You cannot edit the attendence once you submit it."),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Edit'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text('Submit'),
                                    onPressed: () {
                                      submitt = true;
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ),
                            );
                            if (submitt) {
                              setState(() {
                                load = true;
                              });
                              for (int i = 0; i < mark.length; i++) {
                                if (markedit[i]['present'] != 0 ||
                                    markedit[i]['absent'] != 0) {
                                  setState(() {
                                    bottom[i] += markedit[i]['present'];
                                    top[i] += markedit[i]['present'];
                                    bottom[i] += markedit[i]['absent'];
                                    history[i] = [0];
                                  });
                                  await Firestore.instance
                                      .collection('users')
                                      .document(uid)
                                      .collection('attendence')
                                      .document('$i${subs[batch][sem][i]}')
                                      .updateData(
                                          {'top': top[i], 'bot': bottom[i]});
                                  await Firestore.instance
                                      .collection('users')
                                      .document(uid)
                                      .collection('attendence')
                                      .document('d${textfor(widget.date)}')
                                      .collection('subjects')
                                      .document('$i${subs[batch][sem][i]}')
                                      .setData({
                                    'present': mark[i]['present'] +
                                        markedit[i]['present'],
                                    'absent': mark[i]['absent'] +
                                        markedit[i]['absent']
                                  });
                                }
                              }
                              setState(() {
                                load = false;
                                submit = true;
                              });
                            }
                          },
                          child: Text(
                            load ? 'Please Wait...' : 'Submit',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }
}

class AttendanceDate extends StatefulWidget {
  @override
  _AttendanceDateState createState() => _AttendanceDateState();
}

class _AttendanceDateState extends State<AttendanceDate> {
  DateTime selectdate = DateTime.now();
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.8),
        title: TitleText(size: 40, con: false),
      ),
      body: Container(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text('Attendance Calculator', style: TextStyle(fontSize: 30)),
              SizedBox(
                height: 40,
              ),
              Container(
                //margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                    color: Color(0xFF959495),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Choose the Date',
                        style: TextStyle(fontSize: 15, color: Colors.black)),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xFF2E2C2D),
                      child: Text('${textfor(selectdate)}'),
                      onPressed: () async {
                        DateTime temp;
                        temp = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 365)),
                            lastDate: DateTime.now());
                        if (temp != null)
                          setState(() {
                            selectdate = temp;
                          });
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color(0xFF2E2C2D),
                      child: Text(load ? 'Please Wait...' : 'Mark Attendance'),
                      onPressed: () async {
                        setState(() {
                          load = true;
                        });
                        List<Map> att = [];
                        DocumentSnapshot s = await Firestore.instance
                            .collection('users')
                            .document(uid)
                            .collection('attendence')
                            .document('d${textfor(selectdate)}')
                            .collection('subjects')
                            .document('0${subs[batch][sem][0]}')
                            .get();

                        print("line 743 ${s.exists} ${textfor(selectdate)}");
                        if (s.exists) {
                          print('line 744');
                          final docs = await Firestore.instance
                              .collection('users')
                              .document(uid)
                              .collection('attendence')
                              .document('d${textfor(selectdate)}')
                              .collection('subjects')
                              .getDocuments();
                          for (var i in docs.documents) {
                            att.add({
                              'present': i['present'],
                              'absent': i['absent']
                            });
                          }
                        }
                        setState(() {
                          load = false;
                        });
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AttendancePage(selectdate, s.exists, att)));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
