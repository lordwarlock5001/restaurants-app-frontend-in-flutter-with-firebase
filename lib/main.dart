import 'package:flutter/material.dart';
import 'package:flutter_temp/form_first.dart';
import 'package:flutter_temp/resta/main.dart';
import 'package:flutter_temp/sign_in_out.dart';
import 'package:firebase_auth/firebase_auth.dart';

main() {
  runApp(Login_page());
}

class Login_page extends StatelessWidget {
  // const Login_page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restarunt",
      home: Login_main(),
      theme: ThemeData(
        fontFamily: 'Manrope_r',
        primarySwatch: Colors.deepOrange,
      ),
    );
  }
}

class Login_main extends StatefulWidget {
  @override
  _Login_mainState createState() => _Login_mainState();
}

class _Login_mainState extends State<Login_main> {
  _Login_mainState() {
   
  }
  alertBox(BuildContext context) {
    Widget button = FlatButton(onPressed: null, child: Text("ok"));
    AlertDialog alert = AlertDialog(
      title: Text("Error during Log in"),
      content: Text("Check Internet or try again"),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Login Page")),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _loading == true
                  ? <Widget>[spiner()]
                  : <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Material(
                          clipBehavior: Clip.hardEdge,
                          elevation: 0,
                          color: Colors.transparent,
                          //if u use separate
                          // borderRadius:BorderRadius.all(Radius.circular(1)),
                          //  shape: Border.all(color: Color.fromRGBO(204, 204, 204, 10),width: 0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color: Color.fromRGBO(204, 204, 204, 10),
                                  width: 0.5)),
                          child: InkWell(
                              splashColor: Colors.deepOrange,
                              onTap: () {
                                setState(() {
                                  _loading = true;
                                });

                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Form_page()));
                                // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Form_page()), (Route<dynamic> route)=>false);
                                signIn().whenComplete(() {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Form_page()),
                                      (Route<dynamic> route) => false);
                                }).catchError((e) {
                                  setState(() {
                                    _loading = false;
                                  });
                                  alertBox(context);
                                  print(e);
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Row(
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                        "assets/images/google-logo-png-open-2000.png",
                                        height: 20,
                                        width: 20,
                                        fit: BoxFit.cover),
                                    Text(
                                      "Login with Google1",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.blueGrey),
                                    ),
                                  ],
                                )),
                              )),
                        ),
                      ),
                    ]),
        ));
  }
}
