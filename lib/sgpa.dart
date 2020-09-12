import 'package:flutter/material.dart';
import 'val.dart'; /*want to correct values get s(),semsel,brasel*/

class Sgpa extends StatefulWidget {
  @override
  _SgpaState createState() => _SgpaState();
}

class _SgpaState extends State<Sgpa> {
  /*String radioclick="";
  int gggg=0;*/

  int a = 0; //for 2d array
  int hhhh = 0; /*hhhh&kkkk for condition of both selected */
  int kkkk = 0;
  int gggg = 0;
  String ssss = "SGPA:0.00";
  List<String> d;
  List<int> valueco;
  int car = 0;
  int i = 0;
  double k = 0, kk;
  double output = 0;
  int fina = 0;
  double finall = 0;
  List<int> gradesel = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> grade2sel = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  /*Widget radiobutton (){
    return Row(children: <Widget>[
        Text("Select scheme"),
        Expanded(
                  child: RadioListTile(dense: true, value: "item 1", groupValue: radioclick, onChanged: (val){
      setState(() {
          radioclick=val;
          print(radioclick);
      });
    },title: Text("2015",style: TextStyle(fontSize: 10),),),
        ),
        //Expanded(child: Text("2015")),
         Expanded(
           
            child: RadioListTile(value: "item 2", groupValue: radioclick, onChanged: (val){
      setState(() {
        radioclick=val;
        print(radioclick);
      });
        },title: Text("2019"),),
         )
      ],);
  }*/
  calculation() {
    setState(() {
      if (kkkk > 0) {
        if (hhhh > 0) {
          if (gggg > 0) {
            if (schsel == 0 && semsel < 2) {
              int u;
              fina = 0;
              output = 0;
              for (var i = 0; i < 9; i++) {
                switch (gradesel[i]) {
                  case 0:
                    k = 10;
                    break;
                  case 1:
                    k = 9;
                    break;
                  case 2:
                    k = 8.5;
                    break;
                  case 3:
                    k = 8;
                    break;
                  case 4:
                    k = 7;
                    break;
                  case 5:
                    k = 6;
                    break;
                  case 6:
                    k = 5;
                    break;
                  case 7:
                    k = 0;
                    break;
                }
                if (i < 6) {
                  if (i < 3) {
                    switch (i) {
                      case 0:
                        u = 4;
                        break;
                      case 1:
                        u = 4;
                        break;
                      case 2:
                        u = 3;
                        break;
                    }
                    output = output + u * k;
                    fina = fina + u;
                  } else {
                    if (i == 3) {
                      if (s12megr2015sel == 0) {
                        output = output + 4 * k;
                        fina = fina + 4;
                      } else {
                        output = output + 3 * k;
                        fina = fina + 3;
                      }
                    } else {
                      output = output + 3 * k;
                      fina = fina + 3;
                    }
                  }
                } else {
                  output = output + 1 * k;
                  fina = fina + 1;
                }
              }
              print(fina);
              finall = output / fina;
              ssss = finall.toStringAsFixed(2);
              ssss = "SGPA:" + ssss;
            } else {
              output = 0;
              for (var i = 0; i < valueco.length; i++) {
                if (schsel == 0) {
                  switch (gradesel[i]) {
                    case 0:
                      k = 10;
                      break;
                    case 1:
                      k = 9;
                      break;
                    case 2:
                      k = 8.5;
                      break;
                    case 3:
                      k = 8;
                      break;
                    case 4:
                      k = 7;
                      break;
                    case 5:
                      k = 6;
                      break;
                    case 6:
                      k = 5;
                      break;
                    case 7:
                      k = 0;
                      break;
                  }
                }
                if (schsel == 1) {
                  switch (grade2sel[i]) {
                    case 0:
                      k = 10;
                      break;
                    case 1:
                      k = 9;
                      break;
                    case 2:
                      k = 8.5;
                      break;
                    case 3:
                      k = 8;
                      break;
                    case 4:
                      k = 7.5;
                      break;
                    case 5:
                      k = 7;
                      break;
                    case 6:
                      k = 6.5;
                      break;
                    case 7:
                      k = 6;
                      break;
                    case 8:
                      k = 5.5;
                      break;
                    case 9:
                      k = 0;
                      break;
                  }
                }

                output = output + k * valueco[i];
              }
              fina = 0;
              for (var i = 0; i < valueco.length; i++) {
                fina = fina + valueco[i];
              }
              finall = output / fina;
              ssss = finall.toStringAsFixed(2);
              ssss = "SGPA:" + ssss;
            }
          } else {
            ssss = "Enter scheme";
          }
        } else {
          ssss = "Enter branch";
        }
      } else {
        ssss = "Enter sem";
      }
    });
  }

  List<String> scheme = ["2015", "2019"];
  List<DropdownMenuItem<int>> schdrop = [];
  int schsel;
  void schdata() {
    schdrop = [];
    schdrop = scheme
        .map((vall) => DropdownMenuItem<int>(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    vall,
                    style: schsel == scheme.indexOf(vall)
                        ? TextStyle(color: Colors.black)
                        : TextStyle(color: Colors.white),
                  ),
                ],
              ),
              value: scheme.indexOf(vall),
            ))
        .toList();
  }

  Widget schdropbutton() {
    schdata();
    return Container(
      margin: EdgeInsets.all(10),
      height: 30,
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: DropdownButton(
          iconEnabledColor: Colors.black,
          hint: Text(
            "Scheme",
            style: TextStyle(color: Colors.black),
          ),
          items: schdrop,
          value: schsel,
          onChanged: (value) {
            setState(() {
              schsel = value;
              gggg = gggg + 1;
              print(schsel);
            });
          }),
    );
  }

  List<String> semester = ["S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"];
  List<DropdownMenuItem<int>> semdrop = [];
  int semsel;
  void semdata() {
    semdrop = [];
    semdrop = semester
        .map((val) => DropdownMenuItem<int>(
              child: Row(
                children: [
                  SizedBox(
                    width: 35,
                  ),
                  Text(
                    val,
                    style: semsel == semester.indexOf(val)
                        ? TextStyle(color: Colors.black)
                        : TextStyle(color: Colors.white),
                  ),
                ],
              ),
              value: semester.indexOf(val),
            ))
        .toList();
  }

  Widget semdropbutton() {
    semdata();
    return Container(
      margin: EdgeInsets.all(10),
      height: 30,
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: DropdownButton(
          iconEnabledColor: Colors.black,
          hint: Text(
            "Semester",
            style: TextStyle(color: Colors.black),
          ),
          items: semdrop,
          value: semsel,
          onChanged: (value) {
            setState(() {
              semsel = value;
              kkkk = kkkk + 1;
            });
          }),
    );
  }

  List<String> branch = ["CS", "CE", "EC", "EE", "ME", "IT"];
  List<DropdownMenuItem<int>> bradrop = [];
  int brasel;
  void bradata() {
    bradrop = [];
    bradrop = branch
        .map((k) => DropdownMenuItem<int>(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    k,
                    style: brasel == branch.indexOf(k)
                        ? TextStyle(color: Colors.black)
                        : TextStyle(color: Colors.white),
                  ),
                ],
              ),
              value: branch.indexOf(k),
            ))
        .toList();
  }

  Widget bradropbbutton() {
    bradata();
    return Container(
      margin: EdgeInsets.all(10),
      height: 30,
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: DropdownButton(
        iconEnabledColor: Colors.black,
        items: bradrop,
        value: brasel,
        hint: Text(
          'Branch',
          style: TextStyle(color: Colors.black),
        ),
        onChanged: (value) {
          setState(() {
            brasel = value;
            hhhh = hhhh + 1;
            //s();
            //print(brasel);
          });
        },
      ),
    );
  }

  List<String> grade = ["OS", "A+", "A", "B+", "B", "C", "P", "F"];
  List<DropdownMenuItem<int>> gradrop = [];
  //int grasel;
  void gradata(int i) {
    gradrop = [];
    gradrop = grade
        .map((val) => DropdownMenuItem<int>(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    val,
                    style: TextStyle(
                      color: gradesel[i] == grade.indexOf(val)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ],
              ),
              value: grade.indexOf(val),
            ))
        .toList();
  }

  Widget gradropbutton(int i) {
    gradata(i);
    return Container(
      margin: EdgeInsets.all(20),
      height: 30,
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(100),
      ),
      child: DropdownButton(
        iconEnabledColor: Colors.black,
        hint: Text(
          "grade",
          style: TextStyle(color: Colors.black),
        ),
        value: gradesel[i],
        items: gradrop,
        onChanged: (value) {
          setState(() {
            gradesel[i] = value;

            print(gradesel[i]);
            i = i + 1;
          });
        },
      ),
    );
  }

  List<String> grade2 = ["S", "A+", "A", "B+", "B", "C+", "C", "D", "P", "F"];
  List<DropdownMenuItem<int>> gra2drop = [];
  int gra2sel;
  void gra2data(int i) {
    gra2drop = [];
    gra2drop = grade2
        .map((vaal) => DropdownMenuItem<int>(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    vaal,
                    style: TextStyle(
                      color: grade2sel[i] == grade2.indexOf(vaal)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ],
              ),
              value: grade2.indexOf(vaal),
            ))
        .toList();
  }

  Widget gra2dropbutton(int i) {
    gra2data(i);
    return Container(
      margin: EdgeInsets.all(20),
      height: 30,
      //color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(100),
      ),
      child: DropdownButton(
        iconEnabledColor: Colors.black,
        hint: Text(
          "grade",
          style: TextStyle(color: Colors.black),
        ),
        value: grade2sel[i],
        items: gra2drop,
        onChanged: (value) {
          setState(() {
            grade2sel[i] = value;
            // print("selected number is");
            // print(grade2sel[i]);
            i = i + 1;
            /* print("valuue of i is");
            print(i);*/
          });
        },
      ),
    );
  }

  List<String> labsub2015 = [
    "Computer Programming Lab",
    "Civil Engineering workshop",
    "Mechanical Engineering workshop",
    "Electrical Engineering workshop",
    "Electronics Engineering workshop",
    "Computerscience workshop"
  ];
  List<DropdownMenuItem<int>> labsub2015drop = [];
  List<int> labsub2015sel = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  void labsub2015data() {
    labsub2015drop = [];
    labsub2015drop = labsub2015
        .map((k) => DropdownMenuItem<int>(
              child: Text(k),
              value: labsub2015.indexOf(k),
            ))
        .toList();
  }

  Widget labsub2015dropbbutton(int i) {
    labsub2015data();
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        //itemHeight: 100,
        isExpanded: true,
        elevation: 20,
        items: labsub2015drop,
        value: labsub2015sel[i],
        hint: Text(
          'Subject',
          style: TextStyle(color: Colors.black),
        ),
        onChanged: (value) {
          setState(() {
            labsub2015sel[i] = value;
            //s();
            //print(brasel);
          });
        },
      ),
    );
  }

  List<String> s12megr2015 = [
    "Engineering Mechanics",
    "Engineering Graphics",
  ];
  //List<int> sub2015cre =[4,4,4,4,3,3,3,3,3,3,3,3,3];
  List<DropdownMenuItem<int>> s12megr2015drop = [];
  int s12megr2015sel = 0;
  void s12megr2015data() {
    s12megr2015drop = [];
    s12megr2015drop = s12megr2015
        .map((k) => DropdownMenuItem<int>(
              child: Text(k),
              value: s12megr2015.indexOf(k),
            ))
        .toList();
  }

  Widget s12megr2015dropbbutton(int i) {
    s12megr2015data();
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        //itemHeight: 100,
        //isDense: true,
        isExpanded: true,
        //elevation: 20,
        items: s12megr2015drop,
        value: s12megr2015sel,
        /* hint: Text(
          'Subject',
          style: TextStyle(color: Colors.black),
        ),*/
        onChanged: (value) {
          setState(() {
            s12megr2015sel = value;
            //s();
            //print(brasel);
          });
        },
      ),
    );
  }

  List<String> s12int2015 = [
    "Introduction to Civil Engineering",
    "Introduction to Mechanical Engineering Sciences",
    "Introduction to Electrical Engineering",
    "Introduction to Electronics Engineering",
    "Introduction to Computing and Problem Solving",
  ];
  List<DropdownMenuItem<int>> s12int2015drop = [];
  int s12int2015sel = 0;
  void s12int2015data() {
    s12int2015drop = [];
    s12int2015drop = s12int2015
        .map((k) => DropdownMenuItem<int>(
              child: Text(k),
              value: s12int2015.indexOf(k),
            ))
        .toList();
  }

  Widget s12int2015dropbbutton(int i) {
    s12int2015data();
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        //itemHeight: 100,
        isExpanded: true,
        // elevation: 20,
        items: s12int2015drop,
        value: s12int2015sel,
        onChanged: (value) {
          setState(() {
            s12int2015sel = value;
          });
        },
      ),
    );
  }

  List<String> s12bas2015 = [
    "Basics of Civil Engineering",
    "Basics of Mechanical Engineering",
    "Basics of Electrical Engineering",
    "Basics of Electronics Engineering",
  ];
  List<String> s22bas2015 = [
    "Basics of Civil Engineering",
    "Basics of Mechanical Engineering",
    "Basics of Electrical Engineering",
    "Basics of Electronics Engineering",
    "Computer Programming",
  ];
  List<DropdownMenuItem<int>> s12bas2015drop = [];
  int s12bas2015sel = 0;
  void s12bas2015data() {
    s12bas2015drop = [];
    if (semsel == 0) {
      s12bas2015drop = s12bas2015
          .map((k) => DropdownMenuItem<int>(
                child: Text(k),
                value: s12bas2015.indexOf(k),
              ))
          .toList();
    }
    if (semsel == 1) {
      s12bas2015drop = s22bas2015
          .map((k) => DropdownMenuItem<int>(
                child: Text(k),
                value: s22bas2015.indexOf(k),
              ))
          .toList();
    }
  }

  Widget s12bas2015dropbbutton(int i) {
    s12bas2015data();
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        //itemHeight: 100,
        isExpanded: true,
        //elevation: 20,
        items: s12bas2015drop,
        value: s12bas2015sel,
        /*hint: Text(
          'Subject',
          style: TextStyle(color: Colors.black),
        ),*/
        onChanged: (value) {
          setState(() {
            s12bas2015sel = value;
          });
        },
      ),
    );
  }

  List<List<int>> cre = [
    [4, 4, 3, 4, 0, 1, 1],
    [4, 4, 3, 4, 1, 1, 0, 4],
    [4, 4, 4, 4, 3, 3, 1, 1],
    [4, 4, 4, 3, 3, 3, 1, 1],
    [4, 3, 3, 3, 3, 3, 2, 1, 1],
    [4, 3, 3, 3, 3, 3, 1, 1, 2],
    [4, 3, 3, 3, 3, 3, 2, 1],
    [3, 3, 3, 3, 6]
  ];
  List<String> s12015 = [
    "Calculus",
    "Engineering Physics/ Engineering Chemistry",
    "Introduction to Sustainable Engineering"
  ];
  List<int> s12015cre = [4, 4, 3];
  List<String> s22015 = [
    "Differential Equations",
    "Engineering Physics/ Engineering Chemistry",
    "Design & Engineering"
  ];
  List<int> s22015cre = [4, 4, 3];

  List<String> s1 = [
    "Linear Algebra and Calculus",
    "Engineering Physics/ Engineering Chemistry ",
    "Engineering Mechanics /Engineering Graphics",
    "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
    "Life Skills",
    "Engineering Physics Lab/Engineering Chemistry Lab",
    "Civil & Mechanical Workshop/Electrical & Electronics Workshop "
  ];
  List<String> s2 = [
    "Vector Calculus, Differential Equations and Transforms",
    "Engineering Physics/ Engineering Chemistry ",
    "Engineering Mechanics /Engineering Graphics",
    "Basics of Civil & Mechanical Engineering /Basics of Electrical & Electronics Engineering ",
    "Engineering Physics Lab/Engineering Chemistry Lab",
    "Civil & Mechanical Workshop/Electrical & Electronics Workshop ",
    "Professional Communication",
    "Programming in C",
  ];

  Widget s() {
    List<Widget> list = List<Widget>();
    List<Widget> lis = List<Widget>();

    if (semsel < 2 && schsel == 0) {
      setState(() {
        // valueco=sub2015cre;
        if (semsel == 0) {
          for (var i = 0; i < 9; i++) {
            list = [];
            if (i < 6) {
              if (i == 0) {
                lis.add(Row(
                  children: <Widget>[
                    Text(
                      "Select Subjects",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ));
              }
              if (i < 3) {
                list.add(Expanded(
                    child: Text(
                  s12015.elementAt(i),
                  style: TextStyle(fontSize: 16),
                )));
                list.add(SizedBox(
                  width: 20,
                ));
                list.add(gradropbutton(i));
                lis.add(Row(
                  children: list,
                ));
              }
              if (i >= 3) {
                if (i == 3) {
                  list.add(Expanded(
                    child: s12megr2015dropbbutton(i),
                  ));
                  list.add(SizedBox(
                    width: 20,
                  ));
                  list.add(gradropbutton(i));
                  lis.add(Row(
                    children: list,
                  ));
                }
                if (i == 4) {
                  list.add(Expanded(
                    child: s12bas2015dropbbutton(i),
                  ));
                  list.add(SizedBox(
                    width: 20,
                  ));
                  list.add(gradropbutton(i));
                  lis.add(Row(
                    children: list,
                  ));
                }
                if (i == 5) {
                  list.add(Expanded(
                    child: s12int2015dropbbutton(i),
                  ));
                  list.add(SizedBox(
                    width: 20,
                  ));
                  list.add(gradropbutton(i));
                  lis.add(Row(
                    children: list,
                  ));
                }
              }
            } else {
              if (i == 6) {
                lis.add(Row(
                  children: <Widget>[
                    Text(
                      "Select Labs/workshops",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ));
              }
              if (i == 6) {
                list.add(Expanded(
                    child: Text(
                        "Engineering Physics Lab/ Engineering Chemistry Lab",
                        style: TextStyle(fontSize: 16))));
              }
              if (i != 6) {
                list.add(Expanded(child: labsub2015dropbbutton(i)));
              }
              list.add(SizedBox(
                width: 20,
              ));
              list.add(gradropbutton(i));
              lis.add(Row(
                children: list,
              ));
            }
          }
        }
        if (semsel == 1) {
          // print("hhhhhhh");
          for (var i = 0; i < 9; i++) {
            list = [];
            if (i < 6) {
              if (i == 0) {
                lis.add(Row(
                  children: <Widget>[
                    Text(
                      "Select Subjects",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ));
              }
              if (i < 3) {
                list.add(Expanded(
                    child: Text(s22015.elementAt(i),
                        style: TextStyle(fontSize: 16))));
                list.add(SizedBox(
                  width: 20,
                ));
                list.add(gradropbutton(i));
                lis.add(Row(
                  children: list,
                ));
              }
              if (i >= 3) {
                if (i == 3) {
                  list.add(Expanded(
                    child: s12megr2015dropbbutton(i),
                  ));
                  list.add(SizedBox(
                    width: 20,
                  ));
                  list.add(gradropbutton(i));
                  lis.add(Row(
                    children: list,
                  ));
                }
                if (i == 4) {
                  list.add(Expanded(
                    child: s12bas2015dropbbutton(i),
                  ));
                  list.add(SizedBox(
                    width: 20,
                  ));
                  list.add(gradropbutton(i));
                  lis.add(Row(
                    children: list,
                  ));
                }
                if (i == 5) {
                  list.add(Expanded(
                    child: s12bas2015dropbbutton(i),
                  ));
                  list.add(SizedBox(
                    width: 20,
                  ));
                  list.add(gradropbutton(i));
                  lis.add(Row(
                    children: list,
                  ));
                }
              }
            } else {
              if (i == 6) {
                lis.add(Row(
                  children: <Widget>[
                    Text(
                      "Select Labs/workshops",
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ));
              }
              if (i == 6) {
                list.add(Expanded(
                    child: Text(
                        "Engineering Physics Lab/ Engineering Chemistry Lab",
                        style: TextStyle(fontSize: 16))));
              }
              if (i != 6) {
                list.add(Expanded(child: labsub2015dropbbutton(i)));
              }
              list.add(SizedBox(
                width: 20,
              ));
              list.add(gradropbutton(i));
              lis.add(Row(
                children: list,
              ));
            }
          }
        }
      });

      return Expanded(
          child: Container(
              child: SingleChildScrollView(child: Column(children: lis))));
    } else {
      // print("dfghjbbvbvbn");
      valueco = cre[semsel];
      d = subs[brasel][semsel];
      for (var i = 0; i < d.length; i++) {
        list = [];
        list.add(Expanded(
            child: Text(
          d[i],
          style: TextStyle(color: Colors.black),
        )));
        list.add(SizedBox(
          width: 20,
        ));
        if (schsel == 0) {
          list.add(gradropbutton(i));
        }
        if (schsel == 1) {
          list.add(gra2dropbutton(i));
        }
        lis.add(Row(
          children: list,
        ));
      }

      return Expanded(
          child: Container(
              child: SingleChildScrollView(child: Column(children: lis))));
    }
  }

  static int r = 8, c = 6;
  var arr = List.generate(r, (i) => List(c), growable: false);
  void sub() {
    a = 0;
    for (var i = 0; i < 8; i++) {
      for (var j = 0; j < 6; j++) {
        a = a + 1;
        arr[i][j] = a;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    sub();
    return Container(
      //color: Colors.blue,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage("images/a.jpeg"))),

      // color: Colors.blue,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
          ),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
          margin: EdgeInsets.fromLTRB(25, 50, 25, 50),
          //:Border.all(width:20),

          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                  ),
                  semdropbutton(),
                  Expanded(
                    child: SizedBox(),
                  ),
                  bradropbbutton(),
                  Expanded(
                    child: SizedBox(),
                  ),
                  schdropbutton(),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
              hhhh > 0 && kkkk > 0 && gggg > 0 ? s() : SizedBox(),
              hhhh == 0 || kkkk == 0 || gggg == 0
                  ? Expanded(child: SizedBox())
                  : SizedBox(),
              RaisedButton(
                  color: Colors.black,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: Text(
                    "Calculate",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  onPressed: calculation),
              SizedBox(
                height: 10,
              ),
              Text(
                "$ssss",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  //fontFamily: "",
                ),
              ),
            ],
          )),
    );
  }
}
