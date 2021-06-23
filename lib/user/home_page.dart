import 'package:buy_it_flutter_app/constants.dart';
import 'package:buy_it_flutter_app/screens/login_screen.dart';
import 'package:buy_it_flutter_app/user/product_info.dart';
import 'package:buy_it_flutter_app/widgets/product_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "../constants.dart";
import "../functions.dart";
import '../models/product.dart';
import "package:shared_preferences/shared_preferences.dart";
import "../services/auth.dart";
class HomePage extends StatefulWidget {
  static const ROUTEHOMEPAGE="/HomePageroute";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabBarIndex=0;
  int _bottomBarIndex=0;
  List<Product> _products;
  Auth _auth=Auth();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget> [
          DefaultTabController(
            length: 4,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(unselectedItemColor: Colors.black38,type:BottomNavigationBarType.fixed,fixedColor: KMainColor,
                currentIndex: _bottomBarIndex,
                onTap: (value)async{
                if(value==2){
                 var sharedPref= await SharedPreferences.getInstance();
                 sharedPref.clear();
                 await _auth.signOut();
                 Navigator.of(context).popAndPushNamed(LoginScreen.ROUTELOGINSCREEN);
                }
                setState((){
                  _bottomBarIndex=value;
                });

              },items: [
                BottomNavigationBarItem(icon:Icon(Icons.person),label:"fdfdf"),
                BottomNavigationBarItem(icon:Icon(Icons.person),label:"fdfdf"),
                BottomNavigationBarItem(icon:Icon(Icons.close),label:"SingOut"),
              ],),
              appBar: AppBar(
                backgroundColor: Colors.white,
              // elevation: 0,
               bottom: TabBar(
                 indicatorColor:KMainColor,
                 onTap: (value){
                   setState((){
                     _tabBarIndex=value;
                   });

                 },
                 tabs: <Widget>[
                   Text("Jackets",style: TextStyle(color: _tabBarIndex==0?Colors.black:kUnActiveColor,fontSize: _tabBarIndex==0?16:null),),
                   Text("Trouser",style: TextStyle(color: _tabBarIndex==1?Colors.black:kUnActiveColor,fontSize: _tabBarIndex==1?16:null),),
                   Text("T-Shirt",style: TextStyle(color: _tabBarIndex==2?Colors.black:kUnActiveColor,fontSize: _tabBarIndex==2?16:null),),
                   Text("Shoes", style:  TextStyle(color: _tabBarIndex==3?Colors.black:kUnActiveColor,fontSize: _tabBarIndex==3?16:null),)
                 ],
               ),
              ),

              body: TabBarView(children: [
               jacketView(),
                productView(kTrousers,_products),
                productView(kTshirts,_products),
                productView(kShoes,_products),
              ],),
        ),
          ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Container(height: MediaQuery.of(context).size.height*.1,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:<Widget> [
              Text("Discover",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Icon(Icons.shopping_cart)
            ],),),
          ),
        )
      ],
    );
  }
  Widget jacketView() {

    var _collectionReference = FirebaseFirestore.instance.collection(kProductsCollection).snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _collectionReference,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc;
            products.add(Product(
                pDocumentId: doc.id,
                pPrice: data[kProductPrice],
                pName: data[kProductName],
                pDescription: data[kProductDescription],
                pLocation: data[kProductLocation],
                pCategory: data[kProductCategory]));
          }
          _products = [...products];
          products.clear();
          products = getProductByCategory(kJackets, _products);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductInfo.routeProductInfo,arguments:products[index]);
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(products[index].pLocation),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  products[index].pName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('\$ ${products[index].pPrice}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }


//  jacketView(String type) {
//    final CollectionReference<Map<String, dynamic>> _collectionReference =
//    FirebaseFirestore.instance.collection(kProductsCollection);
//   return Container(
//      child: StreamBuilder<QuerySnapshot>(
//        stream: _collectionReference.snapshots(),
//        builder:
//            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (snapshot.hasError) {
//            return new Text('Error: ${snapshot.error}');
//          }
//          if (snapshot.connectionState == ConnectionState.waiting) {
//            return Center(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Text("Loading..."),
//                  SizedBox(
//                    height: 50.0,
//                  ),
//                  CircularProgressIndicator()
//                ],
//              ),
//            );
//          } else {
//            return GridView(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: .8,crossAxisSpacing: 5,mainAxisSpacing: 10),
//                children: snapshot.data.docs
//                    .map((data) =>Padding(
//                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//                    child: GridProductItemUsers(type,{ kProductName: data[kProductName],
//                      kProductDescription: data[kProductDescription],
//                      kProductLocation: data[kProductLocation],
//                      kProductCategory: data[kProductCategory],
//                      kProductPrice: data[kProductPrice],
//                      kDocumentId:data.id}
//                    )
//                ))
//                    .toList());
//
//
//
//
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
//          }
//        },
//      ),
//    );
//  }
}
