import 'package:flutter/material.dart';
import '../ResultAnalysis/semester_selection.dart';
import 'package:ktuhelp/extras/ktutext.dart';

class ResultAnsalysisHomePage extends StatelessWidget {
  final List<int> batches = [
    2018,
    2017,
    2016,
    2015,
  ];
  @override
  Widget build(BuildContext context) {
    // fromExcel();
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
              "Select Batch",
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
                for (var i in batches)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SemesterSelection(i)));
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
