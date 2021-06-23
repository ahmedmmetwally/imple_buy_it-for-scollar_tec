import 'package:buy_it_flutter_app/admin/edit_product_screen.dart';
import 'package:buy_it_flutter_app/models/product.dart';
import "package:flutter/material.dart";
import "../widgets/custom_menu.dart";
import "../services/store.dart";
import "package:buy_it_flutter_app/constants.dart";

class GridProductItem extends StatelessWidget {
  //String image, name, price,
  // documentId;
  Map<String ,String>  productData;

  GridProductItem(this.productData);
  final _store=Store();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTapUp: (details){
          double dx=details.globalPosition.dx;
          double dy=details.globalPosition.dy;
          double dr=MediaQuery.of(context).size.width-dx;
          double db=MediaQuery.of(context).size.width-dy;
          showMenu(context: context, position:RelativeRect.fromLTRB(dx, dy-20, dr, db), items:[
            MyPopupMenuItem(child: Text("Edit"),
              onClick: (){Navigator.of(context).pushNamed(EditProductScreen.routeEditProductScreen,arguments: productData );},),
            MyPopupMenuItem(child: Text("Delete"),onClick: (){_store.deleteProduct(productData[kDocumentId]);},),
          ]);
        },
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: Image(
              image: AssetImage(productData[kProductLocation]),
              fit: BoxFit.fill,
            )),
            Positioned(
              bottom: 0,
              child: Opacity(
                opacity: .5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text(productData[kProductName],style: TextStyle(fontWeight: FontWeight.bold),), Text("\$${productData[kProductPrice]}")],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


