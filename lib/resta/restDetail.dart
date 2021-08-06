import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/resta/product.dart';
import 'fire_data.dart';

class RestDetail extends StatefulWidget {
  final String id;
  RestDetail({this.id});
  @override
  _RestDetailsState createState() => _RestDetailsState(id: id);
}

class _RestDetailsState extends State<RestDetail> {
  //const RestDetail({Key key}) : sup//er(key: key);
  final String id;
  String name = null;
  String info = null;
  int rate = null;
  String pic = null;
  _RestDetailsState({this.id}) {
    getData();
    getphotos();
  }
  Future getData() async {
    fire.collection("Resta").document(id).get().then((snapshot) => {
          setState(() {
            name = snapshot.data["name"].toString();
            info = snapshot.data["info"].toString();
            pic = snapshot.data["pic"].toString();
            rate = snapshot.data["rate"];
            print(name);
          })
        });
  }

  List pid = [];
  Future getItem() async {
    QuerySnapshot qn = await fire
        .collection("Resta")
        .document(id)
        .collection("products")
        .getDocuments();
    qn.documents.forEach((f) {
      pid.add(f.reference.path);
    });
    return qn.documents;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  List<dynamic> link = [];
  Future getphotos() async {
    fire.collection("photo_link").document(id).get().then((snapshot) => {
          setState(() {
            link = snapshot.data["link"];
            print(link);
          })
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).copyWith().size.width,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  image: pic != null
                      ? DecorationImage(
                          image: NetworkImage(pic), fit: BoxFit.cover)
                      : null),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Row(children: <Widget>[
                Container(
                    width: MediaQuery.of(context).copyWith().size.width - 90,
                    child: Text(
                      name == null ? "Loading" : name,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(84, 84, 82, 100),
                      ),
                    )),
                Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 30,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          rate.toString(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.star_border, color: Colors.white),
                      ],
                    )),
              ]),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: Container(
                height: 100,
                width: MediaQuery.of(context).copyWith().size.width - 90,
                child: Text(
                  info == null ? "Loading" : info,
                  style: TextStyle(
                      color: Color.fromRGBO(84, 84, 82, 100),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                  height: 250,
                  width: MediaQuery.of(context).copyWith().size.width,
                  child: link.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: link.length,
                          itemBuilder: (_, index) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    left: 0, right: 10, top: 0, bottom: 0),
                                child: Container(
                                  height: 200, width: 250,
                                  //color: Colors.orange,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                          image: NetworkImage(link[index]),
                                          fit: BoxFit.cover)),
                                ));
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
            Container(
              width: MediaQuery.of(context).copyWith().size.width,
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: <Widget>[
                Icon(Icons.list,
                    color: Color.fromRGBO(41, 40, 40, 100), size: 30),
                SizedBox(width: 20),
                Column(
                  // crossAxisAlignment:CrossAxisAlignment.stretch,
                  // mainAxisAlignment:MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "All Menu",
                      style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 28,
                          color: Color.fromRGBO(41, 40, 40, 100)),
                    ),
                  ],
                ),
              ]),
            ),
            Container(
                width: MediaQuery.of(context).copyWith().size.width,
                height: 200,
                child: FutureBuilder(
                    future: getItem(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (cotext) =>
                                                Product(uid: pid[index])));
                                  },
                                  trailing: Text(
                                    snapshot.data[index].data["price"]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(41, 40, 40, 100)),
                                  ),
                                  title: Text(
                                    snapshot.data[index].data["name"],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(41, 40, 40, 100)),
                                  ),
                                  subtitle: Text(
                                    snapshot.data[index].data["info"],
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: TextStyle(
                                        color: Color.fromRGBO(41, 40, 40, 100)),
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data[index].data["pic"]),
                                            fit: BoxFit.cover)),
                                  ));
                            });
                      }
                    }))
          ]),
        ));
  }
}
