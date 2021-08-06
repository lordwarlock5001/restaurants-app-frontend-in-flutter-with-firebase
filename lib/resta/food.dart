import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/resta/fav.dart';

import 'fire_data.dart';
class FoodPage extends StatefulWidget {
  //FoodPage({Key key}) : super(key: key);
final String uidt;
FoodPage({this.uidt});
  @override
  _FoodPageState createState() => _FoodPageState(uid:uidt);
}

class _FoodPageState extends State<FoodPage> {
  final String uid;
  _FoodPageState({this.uid})
  {
    getOr();
  }
  int i=1;
  Future getOr()
  {
   // print(uid);
   expanList.clear();
    fire.collection("Users_address").document(uid).collection("Orders").getDocuments().then((snap){
      snap.documents.forEach((f){
       // print(f.data);
       setState(() {
         expanList.add(ExpanCust(1,1,f.data["items"],f.data["date"]));
       });
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
          Column(

        children:<Widget>[
          Padding(
            
            padding: EdgeInsets.symmetric(horizontal:10),
            child: Material(
              elevation:0,
              color: Colors.white,
              //if u use separate 
             // borderRadius:BorderRadius.all(Radius.circular(1)),
            //  shape: Border.all(color: Color.fromRGBO(204, 204, 204, 10),width: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(2),
              side:BorderSide(color: Color.fromRGBO(204, 204, 204, 10),width: 0.5)
            ),
              child:TextField(
                
                decoration:InputDecoration(
                 // filled:true,
                  fillColor: Colors.white,
                  border:InputBorder.none,
          
                  contentPadding:EdgeInsets.symmetric(horizontal:10,vertical:15),
                  hintText: 'Search for restaurants or food',
                  prefixIcon:Icon(Icons.search,color:Colors.orange,size:30),
                )
              ),
            ),
          ),
         Column(children:expanList)
          ]
          )
    );
  }
}
List<ExpanCust> expanList=[
 
];
int i=0;
class ExpanCust extends StatelessWidget {
  //const ExpanCust({Key key}) : super(key: key);
final int orderid,n;
final List<dynamic> ls;
final Timestamp t;
List<CustList> temp=[];
ExpanCust(this.orderid,this.n,this.ls,this.t){
//custlist.clear();
temp.clear();
String time="${t.toDate().year.toString()}-${t.toDate().month.toString()}-${t.toDate().day.toString()}/${t.toDate().hour.toString()}:${t.toDate().minute.toString()}";
for(int i=0;i<this.ls.length;i++)
{
  fire.document(ls[i]["pro_path"]).get().then((val){
    val.reference.parent().parent().get().then((val1){
      temp.add(CustList((ls[i]["qnt"]*val.data["price"]).toString(), "Rs:${val.data["price"].toString()}", time, "${val.data["name"]}*${ls[i]["qnt"]}", val1.data["name"],val.data["pic"]));
    });
  });

//name.add([CustList("Rs 250", "2020-2-22", "11:30", "Pizza Margherita", "Home Cooking Experince")]);
}

i++;

}
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(title: Text("Ordered On ${t.toDate().year.toString()}-${t.toDate().month.toString()}-${t.toDate().day.toString()}"),
         children:temp,
         
         );
  }
}
List name=[];
List<CustList> custlist=[];
class CustList extends StatelessWidget {
  //const CustList({Key key}) : super(key: key);
  final String price,date,time,title,subtitle,pic;
CustList(this.price,this.date,this.time,this.title,this.subtitle,this.pic);
  @override
  Widget build(BuildContext context) {
    return ListTile(
                    trailing: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget>[
                        Text(this.price,style: TextStyle(fontSize:16,
                    fontWeight: FontWeight.bold,color: Color.fromRGBO(41, 40, 40, 100)
                    ),),
                      Text(this.date,style: TextStyle(fontSize:12,
                    fontWeight: FontWeight.bold,color: Color.fromRGBO(41, 40, 40, 100)
                    ),),
                     
                      ]
                      ),
                    title: Text(this.title,style: TextStyle(fontSize:18,
                    fontWeight: FontWeight.bold,color: Color.fromRGBO(41, 40, 40, 100)
                    ),),
                    subtitle: Text(this.subtitle,
                    
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(color: Color.fromRGBO(41, 40, 40, 100)),),
                    leading:Container(height: 50,width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image:this.pic!=null?DecorationImage(image:NetworkImage(this.pic),
                      fit: BoxFit.cover
                      ):null
                    ),
                    
                  )
           );
  }
}