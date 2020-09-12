import 'dart:async';

import 'package:ktuhelp/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:ktuhelp/val.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final usersReference = Firestore.instance.collection("users");
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final DateTime timestamp = DateTime.now();
  String uid;
  String firstname = "";
  String college = "";
  double attendence = 75;
  String email;
  String password;
  String repassword;
  String useruid;
  int schsel = 2015;
  List<DropdownMenuItem<int>> semdrop = [];
  int semsel = 0;
  void semdata() {
    semdrop = [];
    semdrop = semester
        .map((val) => DropdownMenuItem<int>(
              child: Text(
                val,
              ),
              value: semester.indexOf(val),
            ))
        .toList();
  }

  Widget semdropbutton() {
    semdata();
    return DropdownButton(
        style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
        underline: Container(),
        iconEnabledColor: Colors.black,
        items: semdrop,
        value: semsel,
        onChanged: (value) {
          setState(() {
            semsel = value;
          });
        });
  }

  List<DropdownMenuItem<int>> bradrop = [];
  int brasel = 0;
  void bradata() {
    bradrop = [];
    bradrop = branch
        .map((k) => DropdownMenuItem<int>(
              child: Text(
                k,
              ),
              value: branch.indexOf(k),
            ))
        .toList();
  }

  Widget schemedropbutton() {
    return DropdownButton(
      style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
      underline: Container(),
      iconEnabledColor: Colors.black,
      items: [
        DropdownMenuItem(
            child: Text(
              '2015',
            ),
            value: 2015),
        DropdownMenuItem(
            child: Text(
              '2019',
              textAlign: TextAlign.right,
            ),
            value: 2019)
      ],
      value: schsel,
      // hint: Text(
      //   'Branch',
      //   style: TextStyle(color: Colors.grey),
      // ),
      onChanged: (value) {
        setState(() {
          schsel = value;
        });
      },
    );
  }

  Widget bradropbutton() {
    bradata();
    return DropdownButton(
      style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
      underline: Container(),
      iconEnabledColor: Colors.black,
      items: bradrop,
      value: brasel,
      onChanged: (value) {
        setState(() {
          brasel = value;
        });
      },
    );
  }

  submitUsername() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      Timer(Duration(seconds: 4), () {
        Navigator.pop(context, firstname);
      });
    }
  }

  savePostInfoToFireStore({useruid}) async {
    await usersReference
        .document(useruid)
        .collection("userdetails")
        .document()
        .setData({
      "id": useruid,
      "profileFirstName": firstname,
      "college": college,
      "attendencepercent": attendence,
      "scheme": schsel,
      "email": email,
      "timestamp": timestamp,
      "semester": semester[semsel],
      "branch": branch[brasel],
    });
    var subjects = usersReference.document(useruid).collection("attendence");
    int ind = 0;
    for (String i in subs[brasel][semsel]) {
      await subjects.document('$ind$i').setData({
        'top': 0,
        'bot': 0,
      });
      ind++;
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: TitleText(size: 35, con: false)),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 28),
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 26.0),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 26.0, fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: Field(
                        question: 'Name',
                        parent: (val) => firstname = val,
                        flex: 1,
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Field(
                        question: 'Email ID',
                        parent: (val) => email = val,
                        flex: 1,
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Field(
                        question: 'College',
                        parent: (val) => college = val,
                        flex: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Branch',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            width: 75,
                            height: 30,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Center(child: semdropbutton()),
                          ),
                          Text(
                            'Semester',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            width: 75,
                            height: 30,
                            child: Center(child: bradropbutton()),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ' Scheme ',
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: 75,
                              height: 30,
                              child: Center(
                                child: schemedropbutton(),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Field(
                        question: 'Desired Attendance Percentage',
                        parent: (val) => attendence = double.parse(val),
                        flex: 3,
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Field(
                        controler: _pass,
                        question: 'Create Password',
                        parent: (val) => password = val,
                        flex: 2,
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Field(
                        controler: _confirmPass,
                        question: 'Confirm Password',
                        validator: (val) {
                          if (val.isEmpty) {
                            return "password should not be empty";
                          }
                          if (val != _pass.text) {
                            return "above password should be equal";
                          }
                        },
                        parent: (val) {
                          if (password == val) repassword = val;
                        },
                        flex: 2,
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 25, bottom: 10, right: 70),
                    //   child: Container(
                    //     child: TextFormField(
                    //       style: TextStyle(color: Colors.white, fontSize: 17),
                    //       validator: (input) {
                    //         if (input.isEmpty) {
                    //           return 'Provide an email';
                    //         }
                    //         // return '';
                    //       },
                    //       onSaved: (val) => email = val,
                    //       decoration: InputDecoration(
                    //         labelText: "Email",
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 25, bottom: 10, right: 70),
                    //   child: Container(
                    //     width: (MediaQuery.of(context).size.width / 2) + 10,
                    //     child: TextFormField(
                    //       controller: _pass,
                    //       style: TextStyle(color: Colors.white, fontSize: 17),
                    //       validator: (val) {
                    //         if (val.isEmpty) {
                    //           return "password should not be empty";
                    //         }
                    //         if (val.trim().length < 8) {
                    //           return "password should be greater than 8 letters";
                    //         }
                    //         // return '';
                    //       },
                    //       onSaved: (val) => password = val,
                    //       obscureText: true,
                    //       decoration: InputDecoration(
                    //         labelText: "Password",
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 25, bottom: 10, right: 70),
                    //   child: Container(
                    //     width: (MediaQuery.of(context).size.width / 2) + 10,
                    //     child: TextFormField(
                    //       style: TextStyle(color: Colors.white, fontSize: 17),
                    //       controller: _confirmPass,
                    //       validator: (val) {
                    //         if (val.isEmpty) {
                    //           return "password should not be empty";
                    //         }
                    //         if (val != _pass.text) {
                    //           return "above password should be equal";
                    //         }
                    //         //return '';
                    //       },
                    //       onSaved: (val) => repassword = val,
                    //       obscureText: true,
                    //       decoration: InputDecoration(
                    //         labelText: "Re-type password",
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Center(
                        child: GestureDetector(
                          onTap: signUp,
                          child: Container(
                            height: 45.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFD5D5D5),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: load
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  bool load = false;
  void signUp() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        load = true;
      });
      _formKey.currentState.save();

      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        final FirebaseUser user = await FirebaseAuth.instance.currentUser();
        await user.sendEmailVerification();
        uid = user.uid.toString();
        await savePostInfoToFireStore(useruid: uid);
        setState(() {
          load = false;
        });

        Navigator.pop(
            context, MaterialPageRoute(builder: (context) => Login()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}

class Field extends StatefulWidget {
  final String question;
  final FormFieldSetter<String> parent;
  final FormFieldValidator<String> validator;
  final int flex;
  final TextEditingController controler;
  Field(
      {this.question, this.parent, this.flex, this.validator, this.controler});
  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: widget.flex,
          child: Text(
            '${widget.question}',
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
        ),
        Expanded(
          flex: 4 - widget.flex,
          // child: Padding(
          // padding: EdgeInsets.symmetric(vertical: 13),
          child: Container(
            height: 30,
            width: (MediaQuery.of(context).size.width / 2) - 50,
            child: TextFormField(
              controller: widget.controler ?? TextEditingController(),
              validator: widget.validator ??
                  (val) {
                    if (val.isEmpty) {
                      return "Enter Your ${widget.question}";
                    }
                    return null;
                  },
              obscureText: widget.flex == 2,
              keyboardType: widget.question == 'Email ID'
                  ? TextInputType.emailAddress
                  : widget.flex == 3
                      ? TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.text,
              style: TextStyle(
                  color: Colors.black, fontSize: 17, fontFamily: 'Montserrat'),
              onSaved: widget.parent,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
        // ),
      ],
    );
  }
}
