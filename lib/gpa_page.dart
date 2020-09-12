import 'package:flutter/material.dart';
import 'sgpa.dart';
import 'cgpa.dart';
import 'package:flutter/services.dart';
import 'package:ktuhelp/extras/ktutext.dart';

class GPAHomePage extends StatefulWidget {
  @override
  _GPAHomePageState createState() => _GPAHomePageState();
}

class _GPAHomePageState extends State<GPAHomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomPadding: false, //for not changing the screen size

          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black.withOpacity(0.8),
            centerTitle: true,
            title: TitleText(
              size: 40,
              con: false,
            ),
            bottom: TabBar(tabs: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "SGPA",
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  )),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "CGPA",
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  )),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              Sgpa(),
              Cgpa(),
            ],
          )),
    );
  }
}
