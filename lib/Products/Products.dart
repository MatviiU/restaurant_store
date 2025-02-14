

class Products{
  int? idProduct;
  String? productName;
  String? productDescription;
  double? productPrice;

  Products({
   this.idProduct,
   this.productName,
   this.productDescription,
   this.productPrice,
});

  static List<Products> productList = [];

  static void clearProductList(){
    productList.clear();
  }

  factory Products.fromMap(Map<String, dynamic> productJson) =>
      Products(
        idProduct: productJson['IDProduct'],
        productName: productJson['ProductName'],
        productDescription: productJson['ProductDescription'],
        productPrice: productJson['ProductPrice'],
      );

  Map<String, dynamic> toMap() => {
    'IDProduct': idProduct,
    'ProductName': productName,
    'ProductDescription': productDescription,
    'ProductPrice': productPrice,
  };

  Products parseFirebaseModel(record, String id){
    Map<String, dynamic> attributes  = {
      'IDProduct': 0,
      'ProductName': '',
      'ProductDescription': '',
      'ProductPrice': 0.0,
    };

    record.forEach((key, value) => {attributes[key] = value});
    Products products = Products(
      idProduct: attributes['IDProduct'],
      productName: attributes['ProductName'],
      productDescription: attributes['ProductDescription'],
      productPrice: attributes['ProductPrice'],
    );

    return products;
  }
}

