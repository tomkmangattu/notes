import 'package:flutter/material.dart';
import 'circleprogress.dart';
import 'val.dart';

const headingstyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w900,
  fontFamily: "Red Hat Display",
);
const contentstyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("KTU Help"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Background(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Attendance(),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        IconLeft(
                          name: "Notes",
                          kkk: 10,
                        ),
                        IconLeft(
                          name: "SGPA/CGPA",
                          kkk: 20,
                        ),
                      ],
                    ),
                    Performance(),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        IconLeft(
                          name: "Video Lectures",
                          kkk: 10,
                        ),
                        IconLeft(
                          name: "Result Analysis",
                          kkk: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      child: Image(fit: BoxFit.fill, image: AssetImage("images/back.jpg")),
    );
  }
}

class IconLeft extends StatefulWidget {
  final String name;
  final int kkk;
  IconLeft({@required this.name, this.kkk});

  @override
  _IconState createState() => _IconState();
}

class _IconState extends State<IconLeft> {
  //var dir

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, widget.name),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 44, 42, 43),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 150,
          margin: widget.kkk == 20
              ? EdgeInsets.fromLTRB(10, 0, 20, 10)
              : EdgeInsets.fromLTRB(20, 0, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           fit: BoxFit.cover,
              //           image: widget.name == "SGPA/CGPA"
              //               ? AssetImage("images/GPA.png")
              //               : AssetImage("images/${widget.name}.png"))),
              // ),

              Container(
                padding: EdgeInsets.all(10),
                height: 100,
                width: 100,
                child: Image(
                    fit: BoxFit.fill,
                    image: widget.name == "SGPA/CGPA"
                        ? AssetImage("images/GPA.png")
                        : AssetImage("images/${widget.name}.png")),
              ),
              Text(
                "${widget.name}",
                style: headingstyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  /*AnimationController progressController;
  Animation animation;
  @override
  void initState() {
    
    super.initState();
    progressController=AnimationController(vsync: this,duration: Duration(milliseconds: 2000)  );
    animation =Tween<double>(begin: 0,end: percentage).animate(progressController)..addListener(() {
      setState(() {
        
      });
    });
  }*/
  @override
  /* void returningpercentage(){
    setState(() {
      percentage=80;
      
      print("${animation.value}");
    if(animation.value==0){
      progressController.reverse();
    }
    });
  }*/
  Widget build(BuildContext context) {
    // returningpercentage();
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "attendance"),
      child: Container(
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        height: 150,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 44, 42, 43),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 30,
                      child: CustomPaint(
                        foregroundPainter: CircleProgress(
                            currentprocess: bottom[0] == 0
                                ? 100
                                : top[0] * 100 / bottom[0]),
                        child: Container(
                            height: 100,
                            width: 100,
                            child: Center(
                                child: Text(
                                    "${bottom[0] == 0 ? 100 : top[0] * 100 / bottom[0]}%"))),
                      )),
                  Expanded(
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "ATTENDANCE",
                            style: headingstyle,
                            //textAlign: TextAlign.,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Present/Total Working days",
                            style: contentstyle,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "${top[0]}/${bottom[0]}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    flex: 60,
                  ),
                ],
              ),
            ),
            Text(
              "View Details",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Performance extends StatefulWidget {
  @override
  _PerformanceState createState() => _PerformanceState();
}

class _PerformanceState extends State<Performance> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "performance"),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
        height: 150,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 44, 42, 43),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    width: 100,
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage("images/Performance.png"),
                    ),
                  ),
                  Expanded(
                      flex: 65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Performance",
                            style: headingstyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Semester",
                                    style: contentstyle,
                                  ),
                                  Text(
                                    "S4",
                                    style: TextStyle(fontSize: 16),
                                    //textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Column(
                                children: <Widget>[
                                  Text(
                                    "CGPA",
                                    style: contentstyle,
                                  ),
                                  Text(
                                    "10.00",
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
            Text(
              "View Details",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
