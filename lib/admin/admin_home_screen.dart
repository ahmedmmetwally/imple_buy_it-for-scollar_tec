import 'package:buy_it_flutter_app/admin/order_screen.dart';
import 'package:flutter/material.dart';
import "add_productScreen.dart";
import 'manageProduct.dart';
class AdminHome extends StatelessWidget {
  static const ROUTEADMINHOMW='/AdminHomeRoute';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){Navigator.of(context).pushNamed(AddProductScreen.routeAddProductScreen);},
          child: Text("Add Product"),),
          ElevatedButton(onPressed:()=>Navigator.pushNamed(context,ManageProduct.RouteEditProduct),child:Text("Edit Product")),
          ElevatedButton (onPressed:(){Navigator.of(context).pushNamed(OrderScreen.routOrderSceen);},child:Text("View Orders")),
      ],),
    );
  }
}
