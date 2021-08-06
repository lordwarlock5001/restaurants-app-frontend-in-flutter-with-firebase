import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'fire_data.dart';

class Notipage extends StatefulWidget {
  Notipage({Key key}) : super(key: key);

  @override
  _NotipageState createState() => _NotipageState();
}

class _NotipageState extends State<Notipage> {
  Future getData() async {
    QuerySnapshot qn = await fire
        .collection("Users_address")
        .document("KRYCeWj4IkaQOt6d89XHi9Z3lt22")
        .collection("Notifi")
        .orderBy("date", descending: true)
        .getDocuments();

    return qn.documents;
  }

  Timestamp t;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            height: 500,
            child: FutureBuilder(
                future: getData(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          t = snapshot.data[index].data["date"];
                          return Card(
                              child: ListTile(
                            title: Text(snapshot.data[index].data["content"]),
                            subtitle: Text(
                                "${t.toDate().day.toString()}-${t.toDate().month.toString()}"),
                            leading: Icon(Icons.crop_original),
                            isThreeLine: true,
                          ));
                        });
                  }
                })));
  }
}
