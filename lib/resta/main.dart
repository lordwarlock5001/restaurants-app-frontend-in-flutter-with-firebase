import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_temp/resta/fire_data.dart';
import 'package:flutter_temp/resta/product.dart';
import 'restDetail.dart';
import 'profile.dart';
import 'food.dart';
import 'noti.dart';
import 'fav.dart';
import 'package:flutter_temp/main.dart';
import 'package:flutter_temp/sign_in_out.dart';

class Home extends StatefulWidget {
  // home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

int _ci;
var title;
String nameuser;
String emainuser;
String photourl;
String uid;

class _HomeState extends State<Home> {
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
  void initState() {
    super.initState();
    log_in_data();
  }

  _HomeState() {
    title = "Home";
    _ci = 2;
  }
  Widget homefun(int i) {
    switch (i) {
      case 0:
        title = "Notifications";
        return Notipage();
        break;
      case 1:
        title = "Profile";
        return ProfilePage(uid, nameuser, emainuser, photourl);
        break;

      case 2:
        title = "Home";

        return Homepage();
        break;
      case 3:
        title = "My Orders";
        return FoodPage(
          uidt: uid,
        );
        break;
      case 4:
        title = "Favorites";
        return FavPage(uid: uid);
        break;
      default:
        return Homepage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(title,
              style: TextStyle(
                  color: Colors.orange, fontFamily: 'Manrope', fontSize: 20)),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Icon(
              Icons.shopping_cart,
              color: Colors.grey,
            ),
          )
        ],
      ),
      drawer: Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  image: photourl != null
                      ? DecorationImage(
                          image: NetworkImage(photourl), fit: BoxFit.cover)
                      : null),
            ),
            ListTile(
              title: Text(nameuser,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(41, 40, 40, 100))),
              subtitle: Text(emainuser),
            ),
            Divider(),
            Column(
              children: cust,
            ),
            InkWell(
              onTap: () {
                signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login_page()),
                    (Route<dynamic> rour) => false);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                      color: Color.fromRGBO(204, 204, 204, 10), width: 0.5),
                )),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.directions_run),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Log out")),
                        ],
                      ),
                      Icon(Icons.arrow_right)
                    ]),
              ),
            ),
          ],
        ),
        color: Colors.white,
      ),
      body: homefun(_ci),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _ci,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.deepOrangeAccent,
          onTap: (index) {
            setState(() {
              homefun(index);
              _ci = index;
            });
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>NextPage()));
            print(index);
          },
          items: [
            BottomNavigationBarItem(
              title: Text("Notifications"),
              icon: Icon(Icons.notifications),
            ),
            BottomNavigationBarItem(
                title: Text("Profile"), icon: Icon(Icons.person)),
            BottomNavigationBarItem(
                title: Text("Home"), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                title: Text("Cart"), icon: Icon(Icons.shopping_basket)),
            BottomNavigationBarItem(
                title: Text("Fav"), icon: Icon(Icons.favorite))
          ]),
    );
  }
}

List<CuctList> cust = [
  CuctList(Icons.person, "Profile"),
  CuctList(Icons.notifications, "Notification"),
  CuctList(Icons.shopping_cart, "Cart"),
];

class CuctList extends StatelessWidget {
  final String title;
  final IconData leadicon;
  const CuctList(this.leadicon, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom:
            BorderSide(color: Color.fromRGBO(204, 204, 204, 10), width: 0.5),
      )),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(leadicon),
                Padding(padding: EdgeInsets.all(10), child: Text(this.title)),
              ],
            ),
            Icon(Icons.arrow_right)
          ]),
    );
  }
}

//Home page
class Homepage extends StatefulWidget {
  //Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

List id = [];

class _HomepageState extends State<Homepage> {
  Future getPost() async {
    QuerySnapshot qn = await fire.collection("Resta").getDocuments();
    fire.collection("Resta").getDocuments().then((snapshot) {
      snapshot.documents.forEach((f) => {
            id.add(f.documentID),
          });
    });
    return qn.documents;
  }

  List pid = [];
  Future getPro() async {
    QuerySnapshot qn = await fire.collectionGroup("products").getDocuments();

    qn.documents.forEach((f) => {
          pid.add(f.reference.path),
        });
    return qn.documents;
  }

  Future temp() async {}
  //collection group tested code
  /*
  Future gettemp() async
  {
    print("innn");
    fire.collectionGroup("products").getDocuments().then((snapshot){
      snapshot.documents.forEach((f)=>{
        print(f.data),
      });
    });
  }
  */
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
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
            width: MediaQuery.of(context).copyWith().size.width,
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: <Widget>[
              Icon(Icons.star,
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
                    "Top Restaurant",
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 28,
                        color: Color.fromRGBO(41, 40, 40, 100)),
                  ),
                  Text(
                    "Ordered by Hearby first",
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'Mantope_r',
                        fontStyle: FontStyle.normal,
                        color: Color.fromRGBO(84, 84, 82, 100)),
                  )
                ],
              )
            ]),
          ),
          Container(
              height: 300,
              width: MediaQuery.of(context).copyWith().size.width,
              padding: EdgeInsets.all(10),
              child: FutureBuilder(
                  future: getPost(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RestDetail(id: id[index])));
                                    },
                                    child: Column(children: <Widget>[
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    41, 40, 40, 100),
                                                blurRadius: 1,
                                                spreadRadius: 0.5,
                                                offset: Offset(0, 0.5))
                                          ],
                                          //  border:Border.all(color:Color.fromRGBO(41, 40, 40, 100)),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data[index].data["pic"]),
                                              fit: BoxFit.fill),
                                        ),
                                        width: 270,
                                        //child:
                                        //color: Colors.grey,
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        41, 40, 40, 100),
                                                    blurRadius: 1,
                                                    spreadRadius: 0.5,
                                                    offset: Offset(0, 0.5))
                                              ]),
                                          padding: EdgeInsets.all(10),
                                          height: 100,
                                          width: 270,
                                          // color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 190,
                                                // color: Colors.white,
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(children: <Widget>[
                                                      SizedBox(
                                                        width: 190,
                                                        child: Text(
                                                          snapshot.data[index]
                                                              .data["name"],
                                                          overflow:
                                                              TextOverflow.fade,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      84,
                                                                      84,
                                                                      82,
                                                                      100),
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'Manrope'),
                                                        ),
                                                      )
                                                    ]),
                                                    Row(children: <Widget>[
                                                      SizedBox(
                                                        width: 190,
                                                        child: Text(
                                                          snapshot.data[index]
                                                              .data["info"],
                                                          overflow:
                                                              TextOverflow.fade,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      84,
                                                                      84,
                                                                      82,
                                                                      100),
                                                              fontFamily:
                                                                  'Manrope_r'),
                                                        ),
                                                      )
                                                    ]),
                                                    snapshot.data[index]
                                                                .data["rate"] ==
                                                            5
                                                        ? Row(
                                                            children: <Widget>[
                                                              Icon(Icons.star,
                                                                  color: Colors
                                                                      .yellow),
                                                              Icon(Icons.star,
                                                                  color: Colors
                                                                      .yellow),
                                                              Icon(Icons.star,
                                                                  color: Colors
                                                                      .yellow),
                                                              Icon(Icons.star,
                                                                  color: Colors
                                                                      .yellow),
                                                              Icon(Icons.star,
                                                                  color: Colors
                                                                      .yellow),
                                                            ],
                                                          )
                                                        : snapshot.data[index]
                                                                        .data[
                                                                    "rate"] ==
                                                                4
                                                            ? Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .yellow),
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .yellow),
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .yellow),
                                                                  Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .yellow),
                                                                ],
                                                              )
                                                            : snapshot.data[index].data[
                                                                        "rate"] ==
                                                                    3
                                                                ? Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.yellow),
                                                                      Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.yellow),
                                                                      Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.yellow),
                                                                    ],
                                                                  )
                                                                : snapshot.data[index]
                                                                            .data["rate"] ==
                                                                        2
                                                                    ? Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                              Icons.star,
                                                                              color: Colors.yellow),
                                                                          Icon(
                                                                              Icons.star,
                                                                              color: Colors.yellow),
                                                                        ],
                                                                      )
                                                                    : Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                              Icons.star,
                                                                              color: Colors.yellow),
                                                                        ],
                                                                      )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                height: 40,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: Icon(
                                                  Icons.directions,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ))
                                    ])));
                          });
                    }
                  })),
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            height: 100,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: <Widget>[
              Icon(Icons.trending_up,
                  color: Color.fromRGBO(41, 40, 40, 100), size: 30),
              SizedBox(width: 20),
              Column(
                // crossAxisAlignment:CrossAxisAlignment.stretch,
                // mainAxisAlignment:MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Trending This Weeks",
                        style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 28,
                            color: Color.fromRGBO(41, 40, 40, 100)),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Double click on the food to add it to the cart",
                        style: TextStyle(
                            fontSize: 14.5,
                            fontFamily: 'Mantope_r',
                            fontStyle: FontStyle.normal,
                            color: Color.fromRGBO(84, 84, 82, 100)),
                      )
                    ],
                  ),
                ],
              )
            ]),
          ),
          Container(
            height: 270,
            width: MediaQuery.of(context).copyWith().size.width,
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
                future: getPro(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Column(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Product(uid: pid[index])));
                                    },
                                    child: Container(
                                        width: 120,
                                        height: 180,
                                        child: Stack(
                                          children: <Widget>[
                                            Positioned(
                                              left: 10,
                                              top: 5,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Text(
                                                    snapshot.data[index]
                                                        .data["price"]
                                                        .toString(),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                              ),
                                            )
                                          ],
                                        ),
                                        // color:Colors.grey,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data[index].data["pic"]),
                                              fit: BoxFit.cover),
                                        )),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      width: 120,
                                      height: 70,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                              width: 110,
                                              child: Text(
                                                snapshot
                                                    .data[index].data["name"],
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        84, 84, 82, 100)),
                                              )),
                                          SizedBox(
                                              width: 110,
                                              child: Text(
                                                snapshot
                                                    .data[index].data["info"],
                                                overflow: TextOverflow.fade,
                                                softWrap: false,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        84, 84, 82, 100)),
                                              ))
                                        ],
                                      ))
                                ],
                              ));
                        });
                  }
                }),
          ),
          Container(
            width: MediaQuery.of(context).copyWith().size.width,
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(children: <Widget>[
              Icon(Icons.category,
                  color: Color.fromRGBO(41, 40, 40, 100), size: 30),
              SizedBox(width: 20),
              Column(
                // crossAxisAlignment:CrossAxisAlignment.stretch,
                // mainAxisAlignment:MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Food Categeties",
                    style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 28,
                        color: Color.fromRGBO(41, 40, 40, 100)),
                  ),
                  //Text("Ordered by Hearby first",style: TextStyle(fontSize:19,fontFamily:'Mantope_r',fontStyle: FontStyle.normal,color: Color.fromRGBO(84, 84, 82, 100)),)
                ],
              )
            ]),
          ),
          Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(Icons.grain, color: Colors.white, size: 70))
                ],
              ))
        ],
      ),
    );
  }
}

List<CustBlockFood> listbk = [
  CustBlockFood("American Friench Fries", "The lonesome the...", "250.00"),
  CustBlockFood("Mecican Friench Fries", "The lonesome the...", "350.00"),
  CustBlockFood("Itelin Friench Fries", "The lonesome the...", "150.00"),
];

class CustBlockFood extends StatelessWidget {
//const CustBlockFood({Key key}) : super(key: key);
  final String title, subtitle, price;

  CustBlockFood(this.title, this.subtitle, this.price);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Column(
          children: <Widget>[
            Container(
                width: 120,
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 50,
                      top: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(this.price,
                            textDirection: TextDirection.rtl,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    )
                  ],
                ),
                // color:Colors.grey,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      image: ExactAssetImage('assets/pizza.jpg'),
                      fit: BoxFit.cover),
                )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: 120,
                height: 70,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        width: 110,
                        child: Text(
                          this.title,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style:
                              TextStyle(color: Color.fromRGBO(84, 84, 82, 100)),
                        )),
                    SizedBox(
                        width: 110,
                        child: Text(
                          this.subtitle,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style:
                              TextStyle(color: Color.fromRGBO(84, 84, 82, 100)),
                        ))
                  ],
                ))
          ],
        ));
  }
}
