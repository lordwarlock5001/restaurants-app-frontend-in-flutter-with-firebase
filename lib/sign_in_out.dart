import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();
FirebaseUser user;
Future<FirebaseUser> signIn() async {
  
  try{
    GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();
  GoogleSignInAuthentication gSA=await googleSignInAccount.authentication;

  final AuthCredential credential=GoogleAuthProvider.getCredential(
    idToken: gSA.idToken, accessToken: gSA.accessToken);
    final AuthResult authResult=await _auth.signInWithCredential(credential);
    user=authResult.user;
    print(user.email);
    return user;
  }catch(e)
  {
    return e;
  }
  
}
void signOut(){
  googleSignIn.signOut();
  print("Sign out");
}
Widget spiner()
{
return Container(
  height: 100,
  width:100,
  color: Colors.transparent,
  child: CircularProgressIndicator(
    value:null,
    strokeWidth:5
  ),
);
}