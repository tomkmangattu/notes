import 'package:flutter/material.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:ktuhelp/val.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Analyse extends StatefulWidget {
  final batch, sem, i;
  Analyse(this.batch, this.sem, this.i);
  @override
  _AnalyseState createState() => _AnalyseState();
}

class _AnalyseState extends State<Analyse> {
  List analysed = [];
  int status, dropval = 0;

  void getit(String sem, int batch) async {
    print(apis[sem][batch]);
    Response resp = await get(apis[sem][batch]);
    status = resp.statusCode;
    print(status);
    if (status == 200) {
      String data = resp.body;
      print(data);
      analysed = jsonDecode(data);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getit(widget.sem, widget.batch);
  }

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
      body: ListView(children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Analysis",
              style: TextStyle(fontSize: 20, fontFamily: 'MontSerrat'),
            )),
        Container(
          // width: 300,
          child: DropdownButton(
            items: [
              DropdownMenuItem(
                child: Text('College wise'),
                value: 0,
              ),
              // DropdownMenuItem(child: Text('Branch wise'), value: 1),
              // DropdownMenuItem(child: Text('Subject wise'), value: 2),
            ],
            value: dropval,
            onChanged: (val) {
              setState(() {
                dropval = val;
              });
            },
          ),
        ),
        Table(
          children: [
            TableRow(children: [
              Text(
                'College',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Passed',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Failed',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Pass Percent',
                style: TextStyle(fontSize: 20),
              )
            ]),
            for (int i = 0; i < analysed.length; i++)
              TableRow(children: [
                Tooltip(
                  child: Text(
                    analysed[i]['Code'],
                    style: TextStyle(fontSize: 20),
                  ),
                  message: analysed[i]['College'],
                ),
                Text(
                  analysed[i]['Total Passed'],
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  analysed[i]['Total Failed'],
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  analysed[i]['Pass %'],
                  style: TextStyle(fontSize: 20),
                )
              ]),
          ],
        )
      ]),
    );
  }
}
