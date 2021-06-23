import 'package:buy_it_flutter_app/models/product.dart';
import 'package:buy_it_flutter_app/widgets/grid_product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import '../constants.dart';

class ManageProduct extends StatelessWidget {
  static const RouteEditProduct = "/EditProduct";
  final CollectionReference<Map<String, dynamic>> _collectionReference =
      FirebaseFirestore.instance.collection(kProductsCollection);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: _collectionReference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              print("ManageProuctScreen tring excute any code before return");
              return GridView(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .8,crossAxisSpacing: 5,mainAxisSpacing: 10),
                  children: snapshot.data.docs
                      .map((data) =>Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child: GridProductItem({ kProductName: data[kProductName],
                          kProductDescription: data[kProductDescription],
                          kProductLocation: data[kProductLocation],
                          kProductCategory: data[kProductCategory],
                          kProductPrice: data[kProductPrice],
                          kDocumentId:data.id}
                        )
                      ))
                      .toList());
//              data[kProductLocation],data[kProductName],data[kProductPrice],data.id
//                ListView.builder(
//                itemCount: snapshot.data.docs.length
//                itemBuilder: (_, index) {
//                  return Card(
//                    child: ListTile(
//                      title: Text(
//                          snapshot.data.docs[index].data[kProductName]), // getting the data from firestore
//                    ),
//                  );
//                },
//              );
            }
          },
        ),
      ),
    );
  }
}
