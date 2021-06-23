import 'package:buy_it_flutter_app/models/product.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "../constants.dart";
class OrderDetails extends StatelessWidget {
  static const routeOrderDetails="/OrderDetailsRoute";
  CollectionReference<Map<String, dynamic>> firebaseCollectionRef=FirebaseFirestore.instance.collection(kOrders);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String  docId=ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(stream: firebaseCollectionRef.doc(docId).collection(kOrderDetails).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
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
          List<Product> orderDetailsList=[];
          for(var data in orders){
            orderDetailsList.add(Product(pPrice: data[kProductPrice],pName:data[kProductName],pQuantity: data[kProductQuantity],
                pCategory:data[kProductCategory],pLocation:data[kProductLocation]));
          }
          return Column(children: <Widget>[
          Expanded(
            child: ListView.builder(itemCount: orderDetailsList.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){},
                    child: Container(height: screenHeight*.2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color:KTextFieldColor),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Text("product name:${orderDetailsList[index].pName}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("product quantity ${orderDetailsList[index].pQuantity}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Text("product category ${orderDetailsList[index].pCategory}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ],),

                    ),
                  );
                }),
          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:<Widget>[
                        Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(primary: KMainColor),
                          onPressed: (){},
                          child: Text("Confirm Order",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),)),
                        SizedBox(width: 10,),
                        Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(primary: KMainColor),
                          onPressed: (){},
                          child: Text("Delete Order",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),))

        ]),
                    )
              ]);

        }
      },)
    );
  }
}
