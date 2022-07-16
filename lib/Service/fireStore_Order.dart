import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/OrderModel/OrderModel.dart';

import '../Models/OrderModel/OrderModel.dart';


class FireStoreOrder {
    List<OrderModel> orders = [];
    final CollectionReference _orderCollectionReference = 
    FirebaseFirestore.instance.collection('Orders');


///////////////*************Add Order******************** */

  Future<void> addOrderToFireStore(OrderModel orderModel)async{ 

    var id = _orderCollectionReference.doc().id;
    orderModel.orderId = id;

    await _orderCollectionReference.doc(orderModel.orderId)
    .set(orderModel.toJson())
    .then((value) {
        print("order Id : ${orderModel.orderId}");
    });
  }

///////////////*************Get Order******************** */

  getOrders(){
    FirebaseFirestore.instance.collection("Orders").get()
    .then((value) {
      value.docs.forEach((element) {
        orders.add(OrderModel.fromJson(element.data()));
        print(element.data());
       });
    });
  }

}