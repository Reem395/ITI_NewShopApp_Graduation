import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/Models/UserModel/UserModel.dart';

class FireStoreUser {
  List<UserModel> users = [];
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(UserModel userModel) async {
    // print("myID : ${productModel.productId}");
    await _userCollectionRef
        .add(userModel.toJson())
        .then((value) => {print("User Id : ${userModel.userId}")});
  }

  getUsers() {
// FirebaseFirestore.instance.collection("Products").get().then((value) {
    FirebaseFirestore.instance.collection("Users").get().then((value) {
      value.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
        print(element.data());
      });
// print("products List: ${products[0].name}");
    });
  }
}
