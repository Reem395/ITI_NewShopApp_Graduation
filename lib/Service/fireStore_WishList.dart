import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/WishListModel/WishListModel.dart';


class FireStoreWishList {
    List<WishListModel> userWishList = [];
    final CollectionReference _wishListCollectionReference = 
    FirebaseFirestore.instance.collection('WishList');


///////////////*************Add WishList******************** */

  Future<void> addItemToWishListFireStore(WishListModel categoryModel)async{ 

    var id = _wishListCollectionReference.doc().id;
    categoryModel.ItemId = id;

    await _wishListCollectionReference.doc(categoryModel.ItemId)
    .set(categoryModel.toJson())
    .then((value) {
        print("WishList Item Id : ${categoryModel.ItemId}");
    });
  }

///////////////*************Get WishList******************** */

  getUserWishlist(){
    FirebaseFirestore.instance.collection("WishList").get()
    .then((value) {
      value.docs.forEach((element) {
        userWishList.add(WishListModel.fromJson(element.data()));
        print(element.data());
       });
    });
  }

}