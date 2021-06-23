import 'package:buy_it_flutter_app/models/product.dart';
import 'package:buy_it_flutter_app/provider/cart_item.dart';
import 'package:buy_it_flutter_app/user/cart_screen.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ProductInfo extends StatefulWidget {
  static const routeProductInfo="/ProductInfo";

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity=1;

  @override
  Widget build(BuildContext context) {
    Product productDetails=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(children: [
        Container(
          height:MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(image: AssetImage(productDetails.pLocation,),fit:BoxFit.cover,),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Container(height: MediaQuery.of(context).size.height*.1,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:<Widget> [
                GestureDetector(onTap: (){Navigator.of(context).pop();},child: Icon(Icons.arrow_back_ios,)),
                GestureDetector(onTap:() {Navigator.of(context).pushNamed(CartScreen.routeCartScreen);},child: Icon(Icons.shopping_cart))
              ],),),
          ),
        Positioned(
          bottom: 0,
          child: Column(children: [
            Opacity(
              child: Container(
                padding: EdgeInsets.all(10),
                color:Colors.white,
                height:MediaQuery.of(context).size.height*.3,
                width: MediaQuery.of(context).size.width,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:<Widget>[
                  Text("name: ${productDetails.pName}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900),),
                  SizedBox(height: 5,),
                  Text("descriotion: ${productDetails.pDescription}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900),),
                  SizedBox(height: 5,),
                  Text("price: \$${productDetails.pPrice}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900)),
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment:MainAxisAlignment.center,children: [
                    ClipOval(child: Material(color: Colors.yellow,child: GestureDetector(onTap: add,
                        child: SizedBox(height: 30,width: 30,child:Icon(Icons.add),)),),),
                         Container(margin:EdgeInsets.all(5),child: Text(_quantity.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900)),),

                         ClipRRect(borderRadius: BorderRadius.circular(30), child:GestureDetector(onTap:subtract,
                        child: Container(color: Colors.yellow,child: SizedBox(height: 30,width: 30,child:Icon(Icons.remove),))) ,)
                  ],)
                ]),
              ),
              opacity: .4,
            ),
           Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
              height:MediaQuery.of(context).size.height*.1,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                child: Text("Add to Cart".toUpperCase(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                onPressed: (){
                  addToCart(productDetails);
               },),
            ),
          ],

          ),

        )
      ],),
    );
  }
  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }

  void addToCart(Product product) {
    CartItem cartItem = Provider.of<CartItem>(context, listen: false);
    product.pQuantity = _quantity;
    bool exist = false;
    var productsInCart = cartItem.getProducts;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("this item added before"),));

    } else {
      cartItem.addProduct(product);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to Cart"),));
    }
  }
//  addedToCart(Product productItem){
//    productItem.pQuantity=_quantity.toString();
//    CartItem cartprovider=Provider.of<CartItem>(context,listen: false);
//    var  productInCart=cartprovider.getProducts;
//    for(var productLoop in productInCart ){
//      {
//        if(productLoop==productItem){
//
//        }else{
//          cartprovider.addProduct(productItem);
//
//        }
//      }
//    }
//
//  }

}

//sumQantity(String operation, int quantity) {
// int quantityy=quantity;
//  switch (operation) {
//    case "add":
//      return quantityy++;
//      break;
//    case "subtract":
//      if (quantity > 0) return quantityy--;
//      break;
//  }
//
//}