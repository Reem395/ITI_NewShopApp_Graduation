import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Views/UserScreens/UserFullInfo.dart';
import 'package:shop_app/Views/UserScreens/orderReview.dart';

import '../../Service/firebase_auth_methods.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/constants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map userAllData = {};
  bool userInoAllComplete = true;
  String? userUID;
  String? userDocId;
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    userUID = FirebaseAuthMethods(FirebaseAuth.instance).user?.uid;
// Firebase.initializeApp();
    print("User UID: $userUID");
    return CupertinoTabView(
      builder: ((context) {
        return Scaffold(
          appBar: ShopSearchAppbar(context),
          backgroundColor: Color.fromARGB(255, 237, 237, 237),
          body: Container(
            color: Color.fromARGB(255, 237, 237, 237),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/girl.png"),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "name",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "\$ 500",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: defaultColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.remove_circle_outline,
                                                color: defaultColor,
                                              )),
                                          Text("4"),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.add_circle_outline,
                                                  color: defaultColor))
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                        ),
                                        onPressed: () {
                                          print("Remove Cliked");
                                        },
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(20),
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$ 6000.00",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: defaultColor,
                        ),
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: const [
                                Text(
                                  "Check out",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            // UserMissingData();

                            FirebaseFirestore.instance
                                .collection("Users")
                                .where("userId", isEqualTo: userUID)
                                .snapshots()
                                .listen(
                                    ((event) => event.docs.forEach((element) {
                                          // print("element.id: ${element.id}");
                                          userDocId = element.id;
                                          Map UserData = element.data();

                                          print("From Function : $userDocId");
                                          print("From Function : ${UserData}");
                                          UserData.forEach((key, value) {
                                            // print("Value: $value");
                                            // userAllData [key]=value;
                                            if (value == null) {
                                              print("Null Value Found $value");
                                              userInoAllComplete=false;
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           const UserFullInfo()),
                                              // );
                                              Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const UserFullInfo()),);
                                              navToComplete();
                                              throw "";
                                            }
                                          });
                                          // if(UserData['name']==null||UserData['email']==null){

                                          // }
                                          // print("userInoAllComplete from Fun: $userInoAllComplete");
                                        })));

                            print("After fun: $userInoAllComplete ");

                            print("User Missing Data? $userInoAllComplete");
                            // print("check");

                            // if (userInoAllComplete) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const orderReviewScreen()));
                            // } else {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const UserFullInfo()),
                            //   );
                            // }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // void UserMissingData() {
  //   FirebaseFirestore.instance
  //       .collection("Users")
  //       .where("userId", isEqualTo: userUID)
  //       .snapshots()
  //       .listen(((event) => event.docs.forEach((element) {
  //             // print("element.id: ${element.id}");
  //             userDocId = element.id;
  //           Map UserData = element.data();

  //           // print("From Function : $userDocId");
  //           // print("From Function : ${UserData}");
  //       // UserData.forEach((key, value) {
  //       //   // print("Value: $value");
  //       //   if(value==null){
  //       //     print("Null Value Found $value");
  //       //       userInoAllComplete=false;
  //       //       throw "";
  //       //   }
  //       // });
  //       if(UserData['name']==null||UserData['email']==null){

  //       }
  //           print("userInoAllComplete from Fun: $userInoAllComplete");
  //           })));
  // }
  void navToComplete() {
    userInoAllComplete = false;
    print("From method $userInoAllComplete");
  }
}
