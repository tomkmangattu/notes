import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'home_page.dart';
import 'package:ktuhelp/attendence/pages/FormPage.dart';
import 'package:ktuhelp/extras/ktutext.dart';
import 'package:ktuhelp/val.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

bool load = false;

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Firestore ins = Firestore.instance;
  String _email = '', _password;
  double opacityLevel = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 2, child: TitleText(size: 40, con: false)),
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Center(
                          child: Container(
                        width: 90,
                        height: 90,
                        color: Colors.pink,
                      )),
                    )),
                Expanded(
                  flex: 6,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Log In',
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 20),
                        ),
                        // width: MediaQuery.of(context).size.width - 75,
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Email ID',
                                style: TextStyle(fontFamily: 'Montserrat'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              // child: Padding(
                              //   // padding: EdgeInsets.symmetric(vertical: 13),
                              child: Container(
                                height: 30,
                                child: Center(
                                  child: TextFormField(
                                    // scrollPadding: EdgeInsets.all(0),
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return "Enter Your Email Id";
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontFamily: 'Montserrat'),
                                    onSaved: (val) => _email = val,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              //),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Password',
                                style: TextStyle(fontFamily: 'Montserrat'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      height: 30,
                                      child: TextFormField(
                                        validator: (input) {
                                          if (input.length < 6) {
                                            return 'Longer password please';
                                          }
                                        },
                                        obscureText: true,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontFamily: 'Montserrat'),
                                        onSaved: (val) => _password = val,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(10.0),
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: 'Montserrat',
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Color(0xFFD5D5D5),
                    onPressed: signIn,
                    child: Container(
                      width: 100,
                      height: 30,
                      child: Center(
                          child: load
                              ? CircularProgressIndicator()
                              : Text("Log in",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black))),
                    ),
                  ),
                ),
                Expanded(child: SizedBox(), flex: 1),
                Expanded(
                    child: InkWell(
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(fontFamily: 'Montserrat'),
                              children: [
                            TextSpan(text: 'Don\'t have an Account?'),
                            TextSpan(
                                text: ' Sign up',
                                style: TextStyle(
                                    decoration: TextDecoration.underline))
                          ])),
                      onTap: () {
                        navigateToSignUp();
                      },
                    ),
                    flex: 1),
                Expanded(child: SizedBox(), flex: 2)
              ],
            ),
          ),
        ),
      ),
      // ),
      //   ),
      //   //     ],
      //   //   ),
      //   // ),
      // ),
    );
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        load = true;
      });
      try {
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        FirebaseUser user = result.user;
        uid = user.uid;
        final details = await ins
            .collection('users')
            .document(uid)
            .collection('userdetails')
            .getDocuments();
        for (var i in details.documents) {
          sem = semester.indexOf(i['semester']);
          batch = branch.indexOf(i['branch']);
          attpercent = i['attendencepercent'];
        }
        int index = 0;
        final values = await ins
            .collection('users')
            .document(uid)
            .collection('attendence')
            .getDocuments();
        for (var i in values.documents) {
          if (i.documentID[0] != 'd') {
            top[index] = i['top'];
            bottom[index] = i['bot'];
            index++;
          }
        }
        setState(() {
          load = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } on NoSuchMethodError catch (e) {
        print(e);
      }
    }
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormPage(), fullscreenDialog: true));
  }
}
