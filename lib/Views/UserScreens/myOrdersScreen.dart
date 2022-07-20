import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Views/UserScreens/UserFullInfo.dart';
import 'package:shop_app/Views/UserScreens/orderReview.dart';

import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/constants.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String productName = "summer Dress";
  String productDescription =
      "Women Plus Size Sexy Lace Up Slim Dress with Belt Evening Party Cocktail";
  String orderStatus = "Arived";
  late double productPrice = 99.00;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: defaultColor,
      ),
      backgroundColor: Color.fromARGB(255, 237, 237, 237),
      body: Container(
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
                            offset: Offset(0, 3), // changes position of shadow
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
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    ShopCubit.get(context)
                                                        .cats[index]
                                                        .image),
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  productName,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: defaultColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  productDescription,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

            
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$ $productPrice",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: defaultColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      orderStatus,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: defaultColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                            ],
                          ),
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
    );
  }
}
