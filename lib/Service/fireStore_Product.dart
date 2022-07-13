import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/ProductModel.dart';

class FireStoreProduct {
  
  List<ProductModel> products=[] ;
  final CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  Future<void> addProductToFireStore(ProductModel productModel) async {
    var id = _productCollectionRef
        // .doc(productModel.productId).id;
        .doc().id;
        productModel.productId = id
        ;
        
  print("myID : ${productModel.productId}");
        await _productCollectionRef
        .doc(productModel.productId).set(productModel.toJson())
        .then((value) => {
        print("Product Id : ${productModel.productId}")
          
        });
  }
   getProducts () {
  
// FirebaseFirestore.instance.collection("Products").get().then((value) {
FirebaseFirestore.instance.collection("Products").get().then((value) {
value.docs.forEach((element) { 
  products.add(ProductModel.fromJson(element.data()));
  print(element.data());
});
// print("products List: ${products[0].name}");
});
  }
}
