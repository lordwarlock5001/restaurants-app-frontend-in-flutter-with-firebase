import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'fire_data.dart';

class Product extends StatefulWidget {
  final String uid;
  Product({this.uid});
  @override
  _ProductState createState() => _ProductState(uid: uid);
}

class _ProductState extends State<Product> {
  final String uid;
  String name;
  String info;
  String pic;
  int price;
  int rate;
  String hotel;
  _ProductState({this.uid}) {
    print(uid);
    getDataPro();
  }
  Future getDataPro() async {
    fire.document(uid).get().then((snapshot) {
      snapshot.reference.parent().parent().get().then((snap){
        setState(() {
        hotel=snap.data["name"];  
        });
        
      });
      setState(() {
        name = snapshot.data["name"];
        info = snapshot.data["info"];
        pic = snapshot.data["pic"];
        price = snapshot.data["price"];
        rate = snapshot.data["rate"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(84, 84, 82, 100)),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.shopping_cart,
                color: Color.fromRGBO(84, 84, 82, 100),
              ),
            ),
          ],
          backgroundColor: Colors.orange,
          title: Text(
            name == null ? "Loading" : name,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(84, 84, 82, 100),
            ),
          ),
        ),
        body: name != null
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).copyWith().size.width,
                       height: 200,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(41, 40, 40, 100),
                                  blurRadius: 3,
                                  spreadRadius: 0.5,
                                  offset: Offset(0, 5))
                            ],
                            image: DecorationImage(
                                image: NetworkImage(pic), fit: BoxFit.cover))),
                    Container(
                      //  height: 100,
                        width: MediaQuery.of(context).copyWith().size.width,
                        child: ListTile(
                          title: Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(41, 40, 40, 100),
                                fontSize: 24),
                          ),
                          subtitle: Text(
                            hotel==null?"Loading":hotel,
                            style: TextStyle(
                                color: Color.fromRGBO(41, 40, 40, 100),
                                fontSize: 18),
                          ),
                          trailing: Text("Rs.:${price.toString()}", style: TextStyle(
                                color: Color.fromRGBO(41, 40, 40, 100),
                                fontSize: 20),
                          ),
                        )),
                        SizedBox(height:10),
                        Container(
                          width:MediaQuery.of(context).copyWith().size.width-40,
                          padding: EdgeInsets.all(10),
                          child: Text(info,style: TextStyle(color: Color.fromRGBO(41, 40, 40, 100),),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width:10),
                              Container(
                                padding: EdgeInsets.all(5),
                                height:30,
                                width:55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.orangeAccent
                                ),
                               child: Text("Order",style: TextStyle(color:Colors.white),)
                              ),
                              SizedBox(width:10),
                               Container(
                                padding: EdgeInsets.all(5),
                                height:30,
                                width:110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.orangeAccent
                                ),
                               child: Row(
                                 children: <Widget>[
                                   Text("Add to Cart  ",style: TextStyle(color:Colors.white),),
                                   Icon(Icons.shopping_cart,color:Colors.white,size: 15,)                                 ],
                               )
                              ),
                              SizedBox(width:10),
                              Container(
                                padding: EdgeInsets.all(5),
                                height:30,
                                width:100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.orangeAccent
                                ),
                               child: Row(
                                 children: <Widget>[
                                   Text("Add to Fav  ",style: TextStyle(color:Colors.white),),
                                   Icon(Icons.favorite,color:Colors.white,size: 15,)                                 ],
                               )
                              )

                            ],
                          ),
                        )

                  ]),
                ))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
