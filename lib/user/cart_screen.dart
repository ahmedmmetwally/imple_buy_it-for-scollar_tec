import 'package:buy_it_flutter_app/models/product.dart';
import 'package:buy_it_flutter_app/provider/cart_item.dart';
import 'package:buy_it_flutter_app/services/store.dart';
import 'package:buy_it_flutter_app/user/product_info.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../constants.dart';
import "../widgets/custom_menu.dart";

class CartScreen extends StatelessWidget {
  static const routeCartScreen = "/CartScreenRoute";

  @override
  Widget build(BuildContext context) {
    List<Product> productList = Provider.of<CartItem>(context).getProducts;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double appBarHeight=AppBar().preferredSize.height;
    double statusBarHeight=MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset:false ,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back,color: Colors.black,),
          onTap: (){
            Navigator.of(context).pop();
      },
        ),
        title: Text("My Cart",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
        body: Column(
      children: [
        LayoutBuilder(builder: (context,consts){
          if (productList.isEmpty){
            return Container(height: screenHeight-appBarHeight-statusBarHeight-screenHeight*.1,alignment: Alignment.center,
                child: Text("Cart is empty"));
          }else
          return Container(
            height: screenHeight-appBarHeight-statusBarHeight-screenHeight*.1 ,
            child: ListView.builder(

                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTapUp: (details){
                        showCutomeMenue(details,context,productList[index]);
                      },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      height: screenHeight * .15,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: screenHeight * .15 / 2,
                            backgroundImage:
                            AssetImage(productList[index].pLocation),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(productList[index].pName,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(productList[index].pPrice,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                ),
                                Text((productList[index].pQuantity).toString(),
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );}

        ),
        Container(
          height: screenHeight*.08,
          width: screenWidth,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                primary: Colors.red,
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
            child: Text("ORDER"),
            onPressed: () {showCustomDialog(productList,context);},
          ),
        ),
      ],
    ));
  }
  void showCutomeMenue(var details,BuildContext context,Product product) {

      double dx=details.globalPosition.dx;
      double dy=details.globalPosition.dy;
      double dr=MediaQuery.of(context).size.width-dx;
      double db=MediaQuery.of(context).size.width-dy;
      showMenu(context: context, position:RelativeRect.fromLTRB(dx, dy-20, dr, db), items:[
        MyPopupMenuItem(child: Text("Edit"),
          onClick: (){Navigator.of(context).pop();
          Provider.of<CartItem>(context,listen: false).deleteProduct(product);
          Navigator.of(context).pushNamed(ProductInfo.routeProductInfo,arguments: product);},),
        MyPopupMenuItem(child: Text("Delete"),onClick: (){Navigator.of(context).pop();
    Provider.of<CartItem>(context,listen: false).deleteProduct(product);},),
      ]);
    }

    void showCustomDialog(List<Product> product,BuildContext context) async {
    double totalPrice=getTotalPrice(product);
    String address;
     await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("total price = \$ $totalPrice"),
            content: TextField(decoration: InputDecoration(hintText: "Enter your adress"),
            onChanged: (value){
              address=value;
            },),
            actions: [
             TextButton(
                child: Text("confirm"),
                 onPressed: () {
                  try{Store store=new Store();
                  store.storeOrders({kTotallPrice: totalPrice, kAddress: address}, product);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Orderd successfully")));
                  Navigator.of(context).pop();
                  }catch(ex){print(ex);}

                  },
              )
            ],
          );;
        },
      );
    }


    double getTotalPrice(List<Product> product){
    double price=0;
    for(var data in product){
      price +=int.parse(data.pPrice);
      return price;
    }
    }

}
