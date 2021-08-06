import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() {

  
  runApp(
    HomeMain()
    );
}
class HomeMain extends StatelessWidget {
  //const HomeMain({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  //Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();
final Firestore fire=Firestore.instance;
final StorageReference ref=FirebaseStorage.instance.ref().child("Chicken-Biryani.jpg");
Uint8List image;
String url,urlt,profileurl,uid;
Future _getdata() async{
  fire.collection("Users_address").document(uid).get().then((snapshot)=>{
    print(snapshot.data)
  });

}
Future _getImage() async{
  urlt=(await ref.getDownloadURL()).toString();
  setState(() {
    url=urlt;
  
  });
  
  print(url);
//image = await storageRef.getData(7*1024*1024);
}
Future<FirebaseUser> _signIn() async {
  GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();
  GoogleSignInAuthentication gSA=await googleSignInAccount.authentication;

  final AuthCredential credential=GoogleAuthProvider.getCredential(
    idToken: gSA.idToken, accessToken: gSA.accessToken);
    final AuthResult authResult=await _auth.signInWithCredential(credential);
    FirebaseUser user=authResult.user;
    print(user.email);
    setState(() {
      profileurl=user.photoUrl;
      uid=user.uid;
    });
    _getdata();
    _getImage();
    return user;
}

void _signOut(){
  googleSignIn.signOut();
  setState(() {
    url=null;
  });
  print("Sign out");
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("demo"),),
      body: Center(
        child:Column(children: <Widget>[
          Container(
            child: RaisedButton(onPressed:(){ 
              _signIn().then((FirebaseUser user)=>print(user)).catchError((e)=>print(e));
              },
                  child:Text("Sign In"),
          ),),
          Container(
            child: RaisedButton(onPressed:(){ 
              _signOut();
              },
                  child:Text("Sign Out"),
          ),),
          Container(
            child:url!=null?Image.network(url,height: 200,width:200,fit: BoxFit.cover):Text("Loading"),
          ),
          Container(
            child:profileurl!=null?Image.network(profileurl,height: 200,width:200,fit: BoxFit.cover,):Text("Loading"),
          )
        ],)
      ),
    );
  }
}