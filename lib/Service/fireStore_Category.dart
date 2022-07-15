import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/ProductCategoryModel.dart';


class FireStoreCategory {
    List<ProductCategoryModel> productCategories = [];
    final CollectionReference _categorycollectionReference = 
    FirebaseFirestore.instance.collection('Categories');


///////////////*************Add Categories******************** */

  Future<void> addCategoryToFireStore(ProductCategoryModel categoryModel)async{ 

    // var id = _categorycollectionReference.doc().id;
    // categoryModel.categoryId = id;

    await _categorycollectionReference
    .add(categoryModel.toJson())
    .then((value) {
        print("Category Id : ${categoryModel.categoryId}");
    });
  }

///////////////*************Get Categories******************** */

  getProductCategories(){
    FirebaseFirestore.instance.collection("Categories").get()
    .then((value) {
      value.docs.forEach((element) {
        productCategories.add(ProductCategoryModel.fromJson(element.data()));
        print(element.data());
       });
    });
  }

}