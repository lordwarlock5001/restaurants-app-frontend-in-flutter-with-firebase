import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/resta/product.dart';
import 'fire_data.dart';

class FavPage extends StatefulWidget {
  // FavPage({Key key}) : super(key: key);
  final String uid;
  FavPage({this.uid});
  @override
  _FavPageState createState() => _FavPageState(uid: uid);
}

class _FavPageState extends State<FavPage> {
  final String uid;
  _FavPageState({this.uid}) {
    getFav();
  }

  getFav() {
    //listData.clear();
    if (listData.length == 0) {
      print(uid);
      fire
          .collection("Users_address")
          .document(uid)
          .collection("Fav")
          .getDocuments()
          .then((snapshot) {
        snapshot.documents.forEach((f) {
          fire.document(f.data["pro_path"]).get().then((value) {
            value.reference.parent().parent().get().then((resta) {
              setState(() {
                //print(value.data["pic"]);
                listData.add(FavList(
                    value.data["price"].toString(),
                    value.data["name"],
                    resta.data["name"],
                    value.data["pic"],
                    f.data["pro_path"]));
              });
            });
          });
        });
      });
    }
    //return qn.documents;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              elevation: 0,
              color: Colors.white,
              //if u use separate
              // borderRadius:BorderRadius.all(Radius.circular(1)),
              //  shape: Border.all(color: Color.fromRGBO(204, 204, 204, 10),width: 0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                  side: BorderSide(
                      color: Color.fromRGBO(204, 204, 204, 10), width: 0.5)),
              child: TextField(
                  decoration: InputDecoration(
                // filled:true,
                fillColor: Colors.white,
                border: InputBorder.none,

                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                hintText: 'Search for restaurants or food',
                prefixIcon: Icon(Icons.search, color: Colors.orange, size: 30),
              )),
            ),
          ),
          Container(
              height: 80,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).copyWith().size.width,
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(
                      Icons.favorite,
                      size: 30,
                      color: Color.fromRGBO(41, 40, 40, 100),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Favorite Foods",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(41, 40, 40, 100),
                          fontWeight: FontWeight.bold),
                    ),
                  ])
                ],
              )),
          Container(
              height: 400,
              width: MediaQuery.of(context).copyWith().size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: //listData
                        listData),
              ))
        ]));
  }
}

List<FavList> listData = [];

class FavList extends StatelessWidget {
  //const FavList({Key key}) : super(key: key);
  final String price, title, subtitle, pic, path;
  FavList(this.price, this.title, this.subtitle, this.pic, this.path);
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Product(uid:this.path)));
        },
        trailing: Text(
          this.price,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(41, 40, 40, 100)),
        ),
        title: Text(
          this.title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(41, 40, 40, 100)),
        ),
        subtitle: Text(
          this.subtitle,
          overflow: TextOverflow.fade,
          softWrap: false,
          style: TextStyle(color: Color.fromRGBO(41, 40, 40, 100)),
        ),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image:
                  DecorationImage(image: NetworkImage(pic), fit: BoxFit.cover)),
        ));
  }
}
