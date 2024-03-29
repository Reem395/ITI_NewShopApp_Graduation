import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/ProductModel/ProductModel.dart';
import '../ViewModels/Block/Cubit.dart';

class FireStoreProduct {
  List<ProductModel> products = [];
  final CollectionReference _productCollectionRef =
      FirebaseFirestore.instance.collection('products');

  Future<void> addProductToFireStore(ProductModel productModel) async {
    // var id = _productCollectionRef
    //     // .doc(productModel.productId).id;
    //     .doc().id;
    //     productModel.productId = id;

    print("myID : ${productModel.productId}");
    await _productCollectionRef
        .add(productModel.toJson())
        .then((value) => {print("Product Id : ${productModel.productId}")});
  }

  getProducts() {
// FirebaseFirestore.instance.collection("Products").get().then((value) {
    FirebaseFirestore.instance.collection("products").get().then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
        print(element.data());
      });
// print("products List: ${products[0].name}");
    });
  }


///************Update Product****************************** */
updateProduct(String productDocID,ProductModel prodUpdate){
FirebaseFirestore.instance.collection("products").doc(productDocID).update(prodUpdate.toJson());
}

///************delete Product****************************** */

  deleteProduct(String id,BuildContext context)  {
    var collection = FirebaseFirestore.instance.collection('products');
    collection
        .doc(id) // <-- Doc ID to be deleted.
        .delete().then((value){

        print("Length After delete: ${ShopCubit.get(context).products.length}");
  // ShopCubit.get(context).products.clear();
  ShopCubit.get(context).getProducts();
        });

  }
}
