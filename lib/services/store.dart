import 'package:buy_it_flutter_app/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "../constants.dart";

class Store {
  final CollectionReference<Map<String, dynamic>> _firestore =
      FirebaseFirestore.instance.collection(kProductsCollection);

  void addProduct(Product product) {
    _firestore.add({
      kProductName: product.pName,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation,
      kProductCategory: product.pCategory,
      kProductPrice: product.pPrice,

    });
  }
   void deleteProduct(String productId){
    _firestore.doc(productId).delete();
  }
  void updateProduct(Product productt,String documentId){
    _firestore.doc(documentId).update({
      kProductName: productt.pName,
      kProductDescription: productt.pDescription,
      kProductLocation: productt.pLocation,
      kProductCategory: productt.pCategory,
      kProductPrice: productt.pPrice,
    });
  }

    storeOrders(data,List<Product> product){
   DocumentReference<Map<String, dynamic>> documentInstance= FirebaseFirestore.instance.collection(kOrders).doc();
   documentInstance.set(data);
   for(var pro in product){
     documentInstance.collection(kOrderDetails).doc().set({
       kProductName: pro.pName,
       kProductPrice: pro.pPrice,
       kProductQuantity: pro.pQuantity,
       kProductLocation: pro.pLocation,
       kProductCategory: pro.pCategory});
   }
    }

//  Future<List<Product>> loadProducts() async {
//    var snapShot = await _firestore.snapshots();
//    snapShot.d
//    List<Product> products = [];
//  }

}
