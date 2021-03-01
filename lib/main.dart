import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ktuhelp/attendence/pages/AttendanceHomePage.dart';
import 'package:ktuhelp/loginpage.dart';
import 'gpa_page.dart';
import 'notes_page.dart';
import 'performance_page.dart';
import 'ResultAnalysis/resultanalysis.dart';
import 'videolectures_page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:ktuhelp/markPredicition/markPredicition.dart';
import 'package:ktuhelp/markPredicition/mark_selector.dart';
import 'package:ktuhelp/markPredicition/subject_selector.dart';
import 'videofirebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(Ktumain());
}

class Ktumain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color.fromRGBO(34, 34, 34, 10),
      ),
      home: Login(),
      routes: {
        "attendance": (context) => AttendanceHome(),
        "SGPA/CGPA": (context) => GPAHomePage(),
        "Notes": (context) => NoteLectureProceed(),
        "performance": (context) => PerformanceHomePage(),
        "Result Analysis": (context) => ResultAnsalysisHomePage(),
        "Mark Prediction sem selector": (context) => SemSchemeBranch(),
        "Video Lectures": (context) => VideoLectureProceed(),
      },
    );
  }
}
