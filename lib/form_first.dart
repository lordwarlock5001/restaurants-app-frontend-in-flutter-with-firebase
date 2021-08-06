import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_temp/resta/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/sign_in_out.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_temp/main.dart';

class Form_page extends StatefulWidget {
  @override
  _Form_pageState createState() => _Form_pageState();
}

class _Form_pageState extends State<Form_page> {
  final _formkey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _pin = TextEditingController();
  final _phone = TextEditingController();
  final Firestore fire = Firestore.instance;
  FirebaseUser user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log_in_data();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _pin.dispose();
    _phone.dispose();
    super.dispose();
  }

  String nameuser;
  String emainuser;
  String photourl;
  String uid;
  bool ispre;
  alertBox(BuildContext context) {
    Widget button = FlatButton(onPressed: null, child: Text("ok"));
    AlertDialog alert = AlertDialog(
      title: Text("test"),
      content: Text("your text ${_name.text}"),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Future _insertData() async {
    try {
      if (ispre) {
        fire.collection("Users_address").document(uid).updateData({
          "address": _name.text.toString(),
          "pincode": _pin.text.toString(),
          "phone": _phone.text.toString()
        });
      } else {
        fire.collection("Users_address").document(uid).setData({
          "address": _name.text.toString(),
          "pincode": _pin.text.toString(),
          "phone": _phone.text.toString()
        });
      }
      print("task fin");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }

  Future _getData() async {
    setState(() {
      fire.collection("Users_address").document(uid).get().then((snapshot) => {
            if (snapshot.data != null)
              {
                print(snapshot.data["address"]),
                _pin.text = snapshot.data["pincode"].toString(),
                _name.text = snapshot.data["address"].toString(),
                _phone.text = snapshot.data["phone"].toString(),
                ispre = true
              }
            else
              {ispre = false}
          });
    });
  }

  Future log_in_data() async {
    if (FirebaseAuth.instance.currentUser() != null) {
      FirebaseAuth.instance.currentUser().then((user) {
        print("in");
        setState(() {
          photourl = user.photoUrl;
          nameuser = user.displayName;
          emainuser = user.email;
          uid = user.uid;
        });
        _getData();
      }).catchError((e) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Login_page()),
            (Route<dynamic> route) => false);
      });
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login_page()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).copyWith().size.width,
              child: Center(
                child: photourl != null
                    ? Container(
                        height: 100,
                        width: 100,
                        //color: Colors.orangeAccent,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(204, 204, 204, 10)),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.orangeAccent,
                            image: DecorationImage(
                                image: NetworkImage(photourl),
                                fit: BoxFit.cover)),
                        //child: Image.network(photourl,fit:BoxFit.cover),
                      )
                    : Text("loading"),
              ),
            ),
            SizedBox(height: 20),
            Text(
              nameuser == null ? "Loading" : "Hello! ${nameuser}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            Text(emainuser == null ? "Loading" : emainuser),
            SizedBox(height: 20),
            Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: Color.fromRGBO(204, 204, 204, 10),
                            )),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: "Enter Phone number",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10)),
                            controller: _phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Phone number';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: Color.fromRGBO(204, 204, 204, 10),
                            )),
                        child: TextFormField(
                            decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: "Enter Address",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10)),
                            controller: _name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Address';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              color: Color.fromRGBO(204, 204, 204, 10),
                            )),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                disabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                hintText: "Enter a pincode",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10)),
                            controller: _pin,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter Pincode';
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ),
                    RaisedButton(
                        color: Colors.deepOrange,
                        child: Text("Next"),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            // alertBox(context);
                            _insertData();
                            //print(_name.text);
                            // Scaffold.of(context).showSnackBar(SnackBar(content: Text("processing on data"),));
                          }
                        }),
                    RaisedButton(
                      onPressed: () {
                        signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login_page()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text("Sign out"),
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
