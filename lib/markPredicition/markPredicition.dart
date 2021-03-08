import 'package:flutter/material.dart';
import 'subject_selector.dart';

const headingstyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w900,
  fontFamily: "Red Hat Display",
);
const contentstyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class SemSchemeBranch extends StatefulWidget {
  @override
  _SemSchemeBranch createState() => _SemSchemeBranch();
}

class _SemSchemeBranch extends State<SemSchemeBranch> {
  String branchValue = "CSE";
  String semValue = "S1";
  String schemeValue = "2015";
  List<String> semester = ["S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"];
  List<DropdownMenuItem<int>> semdrop = [];
  int semsel;

  void semdata() {
    semdrop = [];
    semdrop = semester
        .map((val) => DropdownMenuItem(
              child: Text(val),
              value: semester.indexOf(val),
            ))
        .toList();
  }

  Widget semdropbutton() {
    semdata();
    return DropdownButtonFormField(
      iconEnabledColor: Colors.white,
      hint: Text(
        "Semester",
        style: TextStyle(color: Colors.grey),
      ),
      items: semdrop,
      value: semsel,
      validator: (value) => value == null ? 'field required' : null,
      onChanged: (value) {
        setState(() {
          semsel = value;
        });
      },
    );
  }

  bool checksem = false;
  onChangeSemester() {
    if (semValue == "S1" || semValue == "S2") {
      setState(() {
        checksem = false;
      });
    } else {
      setState(() {
        checksem = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "KTU Help",
                      style: TextStyle(fontFamily: "Orbitron", fontSize: 35),
                    ),
                  ),
                  Center(
                    child: Text(
                      "together we learn",
                      style: TextStyle(fontFamily: "Orbitron", fontSize: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    height: 250,
                    // width: 200,
                    child: Image(image: AssetImage("images/icon.png")),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 44, 42, 43),
                      boxShadow: [
                        //background color of box
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            5.0, // Move to right 10  horizontally
                            5.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 200,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Scheme",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 22),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: new DropdownButton<String>(
                                  dropdownColor: Colors.white,
                                  value: schemeValue,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black54,
                                    size: 30,
                                  ),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: new TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      schemeValue = newValue;
                                    });
                                  },
                                  items: <String>["2015", "2019"]
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Semester",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 22),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: new DropdownButton<String>(
                                  dropdownColor: Colors.white,
                                  value: semValue,
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black54,
                                    size: 30,
                                  ),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: new TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      semValue = newValue;
                                      onChangeSemester();
                                    });
                                  },
                                  items: <String>[
                                    "S1",
                                    "S2",
                                    "S3",
                                    "S4",
                                    "S5",
                                    "S6",
                                    "S7",
                                    "S8"
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                )))
                          ],
                        ),
                        checksem
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    "Branch",
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 22),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                          child: new DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        value: branchValue,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black54,
                                          size: 30,
                                        ),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: new TextStyle(
                                          color: Colors.black54,
                                          fontSize: 20,
                                        ),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            branchValue = newValue;
                                          });
                                        },
                                        items: <String>[
                                          "CSE",
                                          "CE",
                                          "EC",
                                          "EE",
                                          "ME",
                                          "IT"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )))
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                  Container(
                    child: Center(
                      child: GestureDetector(
                        onTap: () async {
                          // branchValue1 = branchValue;
                          // semValue1 = semValue;
                          // schemeValue1 = schemeValue;

                          debugPrint(branchValue + semValue + schemeValue);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectSelector(
                                scheme: schemeValue,
                                branch: branchValue,
                                sem: semValue,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 55.0,
                          width: 360.0,
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Proceed",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
