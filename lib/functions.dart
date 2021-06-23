import 'models/product.dart';

List<String> convertMapToList(Map<String, String> map) {
  List<String> _productDataList = [];
  map.forEach((k, v) => _productDataList.add(map[k].toString()));
  return _productDataList;
}

List<Product> getProductByCategory(String kJackets, List<Product> allproducts) {
  List<Product> products = [];
  try {
    for (var product in allproducts) {
      if (product.pCategory == kJackets) {
        products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return products;
}

int sumQantity(String operation, int quantity) {
  switch (operation) {
    case "add":
      return quantity++;
      break;
    case "subtract":
      if (quantity > 0) return quantity--;
      break;
  }
}
