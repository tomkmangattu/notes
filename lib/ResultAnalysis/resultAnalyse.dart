import 'package:flutter/material.dart';
import 'package:ktuhelp/ResultAnalysis/analyse.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:ktuhelp/val.dart';

class ResultAnalyse extends StatelessWidget {
  final batch, sem;
  ResultAnalyse(this.batch, this.sem);
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
              "Select Result",
              style: TextStyle(fontSize: 20, fontFamily: 'MontSerrat'),
            )),
        Expanded(
          child: Center(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Analyse(batch, sem, i)));
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                          child: Text(
                        'Regular Batch',
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'MontSerrat'),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
