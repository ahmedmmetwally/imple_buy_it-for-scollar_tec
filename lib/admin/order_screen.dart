import 'package:buy_it_flutter_app/admin/order_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "../models/order.dart";
import '../constants.dart';
class OrderScreen extends StatelessWidget {
  static const routOrderSceen="/OrderScreen";
    Stream<QuerySnapshot<Map<String, dynamic>>> _fireStor=FirebaseFirestore.instance.collection(kOrders).snapshots();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStor,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Loading..."),
                  SizedBox(
                    height: 50.0,
                  ),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else {
            print("oreder tring excute any code before return");
            List<QueryDocumentSnapshot<Object>> orders=snapshot.data.docs;
            List<Order> orderList=[];
            for(var data in orders){
              orderList.add(Order(Adress: data[kAddress],totalPrice: data[kTotallPrice],documentId: data.id));
            }
            return ListView.builder(itemCount: orderList.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){Navigator.of(context).pushNamed(OrderDetails.routeOrderDetails,arguments:orderList[index].documentId );},
                    child: Container(height: screenHeight*.15,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:KTextFieldColor),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Text("total price: \$${orderList[index].totalPrice}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("adress is ${orderList[index].Adress}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ],),

                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
