import 'package:flutter/material.dart';
import 'fire_data.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  final String name;
  final String email;
  final String photourl;
  
  ProfilePage(this.uid, this.name, this.email, this.photourl) {}
  @override
  _ProfilePageState createState() =>
      _ProfilePageState(uid, name, email, photourl);
}

class _ProfilePageState extends State<ProfilePage> {
  final String uid;
  final String name;
  final String email;
  final String photourl;
  bool isdata=false;
  _ProfilePageState(this.uid, this.name, this.email, this.photourl);
  @override
  void initState() {
    super.initState();
    getData(uid);
  }

  void getData(uid) {
print(isdata);
    if(!isdata)
    {
    
      fire.collection("Users_address").document(uid).get().then((snapshot) => {
        setState(() {
            pin = snapshot.data["pincode"].toString();
            add = snapshot.data["address"].toString();
            phone = snapshot.data["phone"].toString();
            }),
            print(pin)
          });
    isdata=true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).copyWith().size.width,
                //  height: 200,
                child: ListTile(
                    title: Text(name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                    subtitle: Text(email),
                    trailing: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                              image: NetworkImage(photourl),
                              fit: BoxFit.cover)),
                    ))),
            Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(41, 40, 40, 100),
                        blurRadius: 0.2,
                        spreadRadius: 0.2,
                        offset: Offset(0, 0.5))
                  ],
                ),
                child: Column(children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    trailing: Text("Edit",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                    title: Text("Profile Setting",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                  ),
                  ListTile(
                    title: Text("Full Name:",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                    trailing: Text(name,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                  ),
                  ListTile(
                    title: Text("Email",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                    trailing: Text(email,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                  ),
                  ListTile(
                    title: Text("Phone",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                    trailing: Text(phone,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                  ),
                  ListTile(
                    title: Text("Address",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                    trailing: Text(add,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(41, 40, 40, 100))),
                  )
                ])),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(41, 40, 40, 100),
                      blurRadius: 0.2,
                      spreadRadius: 0.2,
                      offset: Offset(0, 0.5))
                ],
              ),
              child: Column(children: <Widget>[
                ListTile(
                  leading: Icon(Icons.credit_card),
                  trailing: Text("Edit",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(41, 40, 40, 100))),
                  title: Text("Payment Setting",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(41, 40, 40, 100))),
                ),
                ListTile(
                  title: Text("Default Credit Card",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(41, 40, 40, 100))),
                  trailing: Text("1522",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(41, 40, 40, 100))),
                ),
              ]),
            )
          ],
        ));
  }
}
