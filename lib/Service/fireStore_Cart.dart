import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/CartModel.dart';


class FireStoreCart {
    List<CartModel> userCart = [];
    final CollectionReference _cartCollectionReference = 
    FirebaseFirestore.instance.collection('Cart');


///////////////*************Add To Cart******************** */

  Future<void> addToCartFireStore(CartModel cartModel)async{ 

    var id = _cartCollectionReference.doc().id;
    cartModel.ItemId = id;

    await _cartCollectionReference.doc(cartModel.ItemId)
    .set(cartModel.toJson())
    .then((value) {
        print("cart Item Id : ${cartModel.ItemId}");
    });
  }

///////////////*************Get Cart******************** */

  getUserCart(){
    FirebaseFirestore.instance.collection("Cart").get()
    .then((value) {
      value.docs.forEach((element) {
        userCart.add(CartModel.fromJson(element.data()));
        print(element.data());
       });
    });
  }

}