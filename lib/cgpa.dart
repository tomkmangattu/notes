import 'package:flutter/material.dart';

class Cgpa extends StatefulWidget {
  @override
  _CgpaState createState() => _CgpaState();
}

class _CgpaState extends State<Cgpa> {
  int count;
  int yyyy = 0;
  String radioclick = "";
  String kkkk = "CGPA:0.00";
  List<DropdownMenuItem<int>> listdrop = [];
  List<String> drop = ["S1", "S2", "S3", "S4", "S5", "S6", "S7", "S8"];
  List<double> credit = [0, 0, 0, 0, 0, 0, 0, 0];
  List<String> cr = [];
  String va;
  int sel, yu = -1, i;
  double sum = 0, j = 0, jj = 0;
  List<String> scheme1 = ["2015", "2019"];
  List<DropdownMenuItem<int>> schdrop1 = [];
  int schsel;
  int gggg = 0;
  void schdata1() {
    schdrop1 = [];
    schdrop1 = scheme1
        .map((vall) => DropdownMenuItem<int>(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    vall,
                    style: TextStyle(
                      color: schsel == scheme1.indexOf(vall)
                          ? Colors.black
                          : Colors.white,
                    ),
                  )
                ],
              ),
              value: scheme1.indexOf(vall),
            ))
        .toList();
  }

  Widget schdropbutton1() {
    schdata1();
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
          items: schdrop1,
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

  void cal() {
    setState(() {
      double rr;
      sum = 0;
      count = 0;
      if (yyyy > 0) {
        if (gggg > 0) {
          if (schsel == 1) {
            int cre = 0, sCre = 0;
            for (i = 0; i <= sel; i++) {
              if (credit[i] > 10 || credit[i] == 0) {
                sum = 1000;
                break;
              }
              // sum = sum + credit[i];
              switch (i) {
                case 0:
                  cre = 17;
                  break;
                case 1:
                  cre = 21;
                  break;
                case 2:
                  cre = 24;
                  break;
                case 6:
                  cre = 22;
                  break;
                case 7:
                  cre = 18;
                  break;
                default:
                  cre = 23;
                  break;
              }
              sum = sum + cre * credit[i];
              sCre = sCre + cre;
            }
            j = sCre.toDouble();
            if (sum != 1000) {
              sum = sum / j;
              kkkk = sum.toStringAsFixed(2);
              kkkk = "CGPA:" + kkkk;
            }
            /* j = i.toDouble();
      if (sum != 1000) {
        sum = sum / j;
        kkkk = sum.toStringAsFixed(2);
        kkkk="CGPA:"+kkkk;
      }*/
          }
          if (schsel == 0) {
            /*reached here*/
            int cre, sCre = 0;
            sum = 0;
            if (radioclick != "") {
              for (i = 0; i <= sel; i++) {
                if (credit[i] <= 10 && credit[i] != 0) {
                  if (i == 0) {
                    if (radioclick == "item 1") {
                      sCre = 23;
                      sum = sum + credit[i] * 23;
                    } else {
                      sCre = 24;
                      sum = sum + credit[i] * 24;
                    }
                  } else if (i == 1) {
                    if (radioclick == "item 1") {
                      sCre = sCre + 24;
                      sum = sum + credit[i] * 24;
                    } else {
                      sCre = sCre + 23;
                      sum = sum + credit[i] * 23;
                    }
                  } else {
                    switch (i) {
                      case 2:
                        cre = 24;
                        break;
                      case 6:
                        cre = 22;
                        break;
                      case 7:
                        cre = 18;
                        break;
                      default:
                        cre = 23;
                        break;
                    }
                    sCre = sCre + cre;
                    sum = sum + credit[i] * cre;
                  }
                } else {
                  sum = 1000;
                }
              }
              if (sum != 1000) {
                j = sCre.toDouble();
                sum = sum / j;
                kkkk = sum.toStringAsFixed(2);
                kkkk = "CGPA:" + kkkk;
              }
            } else {
              kkkk = "Specify S1/S2";
            }
          }
        } else {
          kkkk = "select scheme";
        }
      } else {
        kkkk = "Select sem";
      }
    });
  }

  /*sum=0;
        count=0;
        for (i = 2; i <= sel; i++) {
          count=count+1;
        if (credit[i] > 10 || credit[i] == 0) {
          sum = 1000;
          break;
        }
        print(sel);
        sum = sum + credit[i];
        print(sum);
      }
      print("val i is $i");
      print("count is $count");
      if(count>0){
      jj =count.toDouble();
      if (sum != 1000) {
        sum = sum / jj;
      }}
      print(sum);
      if(radioclick=="item 1"){ 
        rr=credit[0]*23+credit[1]*24;
        rr=rr/47;
      }
      if(radioclick=="item 2"){
        
        rr=credit[0]*24+credit[1]*23;
        rr=rr/47;
      }
      sum=(sum+rr)/2;
      print(sum);
      if(sel==1){
        sum=rr;
      }
      if(credit[0]>10 || credit[0]==0 || credit[1]>10 || credit[1]==0)
        {
          sum=1000;
        }
      if(sel==0){
        sum=credit[0];
      }
      
      kkkk=sum.toStringAsFixed(2);
      kkkk="CGPA:"+kkkk;*/
  /*credia(){
    return showDialog(context: context,
    builder: (context){
      return Center(
              child: AlertDialog(
          title: Text("dfghjk"),          /*for popup not working*/
          content: Text("ffe"),
          actions: <Widget>[
            MaterialButton(onPressed: (){
              Navigator.of(context).pop();
            },elevation: 5,child: Text("ok"),)
          ],
        ),
      );
    }
    );
  }*/
  void loaddata() {
    listdrop = [];
    listdrop = drop
        .map((val) => DropdownMenuItem<int>(
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    val,
                    style: TextStyle(
                      color: sel == drop.indexOf(val)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ],
              ),
              value: drop.indexOf(val),
            ))
        .toList();
  }

  Widget ad(int l, int se, int se2) {
    String k;
    switch (l) {
      case 1:
        k = "1ST";
        break;
      case 2:
        k = "2ND";
        break;
      case 3:
        k = "3RD";
        break;
      case 4:
        k = "4TH";
        break;
    }
    return Row(
      children: <Widget>[
        sel >= (se - 1)
            ? Expanded(
                child: Text(
                "$k  YEAR",
                style: TextStyle(color: Colors.black),
              ))
            : SizedBox(),
        SizedBox(
          width: 20,
        ),
        sel >= (se - 1)
            ? Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "S $se",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  onChanged: (String z) {
                    setState(() {
                      if (z == '') {
                        z = "0";
                      }
                      credit[se - 1] = double.parse(z);
                      print(credit);
                    });
                  },
                ),
              )
            : SizedBox(),
        SizedBox(
          width: 20,
        ),
        sel >= (se2 - 1)
            ? (Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: "S $se2",
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  onChanged: (String z) {
                    setState(() {
                      if (z == '') {
                        z = "0";
                      }
                      credit[se2 - 1] = double.parse(z);
                    });
                  },
                ),
              ))
            : Expanded(
                child: SizedBox(),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    loaddata();
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage("images/a.jpeg"))),
        // color: Colors.blue,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white70,
          ),

          padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
          margin: EdgeInsets.fromLTRB(25, 50, 25, 50),
          //:Border.all(width:20),

          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                      value: sel,
                      items: listdrop,
                      onChanged: (value) {
                        setState(() {
                          sel = value;
                          yyyy = yyyy + 1;
                        });
                      },
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  schdropbutton1(),
                  Expanded(child: SizedBox()),
                ],
              ),
              gggg > 0 && schsel == 0
                  ? Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          "Select sem which had graphics",
                          style: TextStyle(color: Colors.black),
                        )),
                        Radio(
                          activeColor: Colors.green,
                          value: "item 1",
                          groupValue: radioclick,
                          onChanged: (val) {
                            setState(() {
                              radioclick = val;
                              print(radioclick);
                            });
                          },
                          //dense: false,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          //title: Text("S1"),
                        ),
                        Text(
                          "S1",
                          style: TextStyle(color: Colors.black),
                        ),
                        Radio(
                          activeColor: Colors.green,
                          value: "item 2",
                          groupValue: radioclick,
                          onChanged: (val) {
                            setState(() {
                              radioclick = val;
                            });
                          },
                        ),
                        Text(
                          "S2",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                height: 20,
              ),
              gggg > 0 && yyyy > 0
                  ? Row(
                      children: <Widget>[
                        Text(
                          "Enter SGPA of each sem in the textbox",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )
                  : SizedBox(),
              Expanded(
                child: Container(
                  height: 255,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        yyyy > 0 && gggg > 0 ? ad(1, 1, 2) : SizedBox(),
                        yyyy > 0 && gggg > 0 ? ad(2, 3, 4) : SizedBox(),
                        yyyy > 0 && gggg > 0 ? ad(3, 5, 6) : SizedBox(),
                        yyyy > 0 && gggg > 0 ? ad(4, 7, 8) : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.black,
                padding: EdgeInsets.only(left: 20, right: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Text(
                  "Calculate",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                onPressed: cal,
              ),
              SizedBox(
                height: 20,
              ),
              sum <= 10
                  ? Text(
                      "$kkkk",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    )
                  : SizedBox(),
              sum == 1000
                  ? Text("Enter a vaild credit",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
