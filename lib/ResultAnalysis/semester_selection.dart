import 'package:flutter/material.dart';
import 'package:ktuhelp/ResultAnalysis/resultAnalyse.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:ktuhelp/val.dart';

class SemesterSelection extends StatelessWidget {
  final batch;
  SemesterSelection(this.batch);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TitleText(
          size: 40,
          con: false,
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Select Semester",
              style: TextStyle(fontSize: 20, fontFamily: 'MontSerrat'),
            )),
        Expanded(
          child: Center(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.7,
                crossAxisCount: 2,
              ),
              children: [
                for (var i in semester)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultAnalyse(batch, i)));
                    },
                    child: Container(
                        child: Card(
                            child: Center(
                                child: Text(
                      '$i',
                      style: TextStyle(fontSize: 20, fontFamily: 'MontSerrat'),
                    )))),
                  ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
