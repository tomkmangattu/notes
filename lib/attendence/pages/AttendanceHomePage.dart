import 'package:ktuhelp/attendence/pages/AttendencePage.dart';
import 'package:flutter/material.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:ktuhelp/val.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AttendanceHome extends StatefulWidget {
  @override
  _AttendanceHomeState createState() => _AttendanceHomeState();
}

class _AttendanceHomeState extends State<AttendanceHome> {
  int review = -1;
  int cut(int t, int d) {
    int q = 1;
    while (t / (d + q) >= attpercent * 0.01) {
      q++;
    }
    return q - 1;
  }

  int attend(int t, int d) {
    int q = 1;
    while ((t + q) / (d + q) < attpercent * 0.01) {
      q++;
    }
    return q;
  }

  List<double> percent = List.generate(subs[batch][sem].length, (index) => 100);

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
    for (int i = 0; i < subs[batch][sem].length; i++) percent[i] = getp(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.8),
        centerTitle: true,
        title: TitleText(
          size: 40,
          con: false,
        ),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Attendance Calculator',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 20,
                child: GestureDetector(
                  onTap: () {
                    if (review != -1)
                      setState(() {
                        review = -1;
                      });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(0xFF959495),
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                            child: Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                children: <TableRow>[
                              TableRow(children: <Widget>[
                                Text(
                                  'Subject',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Current Attendance\n',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(),
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
                                  CircularPercentIndicator(
                                    backgroundColor: Colors.black26,
                                    progressColor: Color(0xFFD5D5D5),
                                    radius: 50,
                                    percent: getp(i) / 100,
                                    center: Text(
                                      '${getp(i).toStringAsFixed(0)}%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    color: Color(0xFFD5D5D5),
                                    child: Text(
                                      'Review',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (review != -1)
                                          review = -1;
                                        else
                                          review = i;
                                      });
                                    },
                                  )
                                ])
                            ])),
                        review != -1
                            ? Positioned.fill(
                                child: Align(
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.all(30),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Review',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        getp(review) >= attpercent
                                            ? cut(top[review],
                                                        bottom[review]) ==
                                                    0
                                                ? Text(
                                                    'You can\'t afford to cut any more class for ${shorts[batch][sem][review]}',
                                                    textAlign: TextAlign.center,
                                                  )
                                                : Text(
                                                    'You can afford to cut ${cut(top[review], bottom[review])} classes for ${shorts[batch][sem][review]}',
                                                    textAlign: TextAlign.center,
                                                  )
                                            : Text(
                                                'You need to attend ${attend(top[review], bottom[review])} more classes for ${shorts[batch][sem][review]}',
                                                textAlign: TextAlign.center,
                                              ),
                                      ]),
                                ),
                                alignment: Alignment(
                                  0.0,
                                  (-0.95 +
                                      (2 / shorts[batch][sem].length) *
                                          (review + 0.70)),
                                ),
                              ))
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    color: Color(0xFFD5D5D5),
                    child: Text(
                      'Calender',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AttendanceDate()));
                      setState(() {});
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
