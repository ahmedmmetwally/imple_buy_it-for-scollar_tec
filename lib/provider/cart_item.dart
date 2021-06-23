import 'package:buy_it_flutter_app/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get getProducts {
    return [..._products];
  }

  addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  deleteProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

//  addedToCart(Product productItem, int quantity) {
//    productItem.pQuantity = quantity.toString();
//    var productDataa = getProducts;
//    for (var data in productDataa) {
//      if (data.pName == productItem.pName &&
//          data.pCategory == productItem.pCategory) {
//        int quantitity = int.parse(data.pQuantity);
//        quantitity++;
//        data.pQuantity = quantitity.toString();
//        notifyListeners();
//      } else {
//        productItem.pQuantity = quantity.toString();
//        addProduct(productItem);
//      }
//    }
//    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to Cart"),));
//  }
}
