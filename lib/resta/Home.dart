import 'package:flutter/material.dart';
import 'restDetail.dart';

class Homepage extends StatefulWidget {
  //Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
            padding: EdgeInsets.all(10),
            child:
                ListView(scrollDirection: Axis.horizontal, children: listRect),
          ),
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
                        "Trending This Week",
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
              padding: EdgeInsets.all(10),
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                Container(
                    child: Row(
                  children: listbk,
                )),
              ])),
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

List<CustRest> listRect = [
  CustRest("Home Cooking Exprence", "latraset sheets containing looo"),
  CustRest("x y z", "latraset sheets containing looo"),
];

class CustRest extends StatelessWidget {
  //const CustRest({Key key}) : super(key: key);
  final String title;
  final String subtitle;
  CustRest(this.title, this.subtitle);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RestDetail()));
          },
            child: Column(children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(41, 40, 40, 100),
                    blurRadius: 1,
                    spreadRadius: 0.5,
                    offset: Offset(0, 0.5))
              ],
              //  border:Border.all(color:Color.fromRGBO(41, 40, 40, 100)),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              image: DecorationImage(
                  image: ExactAssetImage('assets/dining-table.jpg'),
                  fit: BoxFit.fill),
            ),
            width: 270,
            //child:
            //color: Colors.grey,
          ),
          Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(41, 40, 40, 100),
                    blurRadius: 1,
                    spreadRadius: 0.5,
                    offset: Offset(0, 0.5))
              ]),
              padding: EdgeInsets.all(10),
              height: 100,
              width: 270,
              // color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                              this.title,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(84, 84, 82, 100),
                                  fontSize: 20,
                                  fontFamily: 'Manrope'),
                            ),
                          )
                        ]),
                        Row(children: <Widget>[
                          SizedBox(
                            width: 190,
                            child: Text(
                              this.subtitle,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                  color: Color.fromRGBO(84, 84, 82, 100),
                                  fontFamily: 'Manrope_r'),
                            ),
                          )
                        ]),
                        Row(children: <Widget>[
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                        ])
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Icon(
                      Icons.directions,
                      color: Colors.white,
                    ),
                  )
                ],
              ))
        ])));
  }
}
