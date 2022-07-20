import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/ViewModels/Block/Cubit.dart';

import '../Models/CategoryModel/ProductCategoryModel.dart';


class FireStoreCategory {
    List<ProductCategoryModel> productCategories = [];
    final CollectionReference _categorycollectionReference = 
    FirebaseFirestore.instance.collection('Categories');


///////////////*************Add Categories******************** */

  Future<void> addCategoryToFireStore(ProductCategoryModel categoryModel, BuildContext context)async{ 

    // var id = _categorycollectionReference.doc().id;
    // categoryModel.categoryId = id;

    await _categorycollectionReference
    .add(categoryModel.toJson())
    .then((value) {
        print("Category Id : ${categoryModel.categoryId}");
    });
    ShopCubit.get(context).cats.clear();
        ShopCubit.get(context).getCats();
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