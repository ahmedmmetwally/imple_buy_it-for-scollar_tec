import 'package:buy_it_flutter_app/models/product.dart';
import 'package:buy_it_flutter_app/user/product_info.dart';
import "package:flutter/material.dart";

import '../functions.dart';
Widget productView(String category,List<Product> productt) {
  List<Product> products = [];
  products = getProductByCategory(category, productt);
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
}