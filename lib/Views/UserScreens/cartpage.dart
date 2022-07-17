import 'package:flutter/material.dart';
import 'package:shop_app/Views/PaymentScreen/paymentscreen.dart';

import '../../ViewModels/constants.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 237, 237, 237),
      // appBar: AppBar(
      //   centerTitle: true,
      //   leading: Icon(Icons.arrow_back),
      //   title: Column(
      //     children: [
      //       const Text(
      //         "Your Cart",
      //         style: TextStyle(color: Colors.black),
      //       ),
      //       Text(
      //         "10 items",
      //         style: Theme.of(context).textTheme.caption,
      //       ),
      //     ],
      //   ),
      // ),

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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          // boxShadow:[
                                          //   BoxShadow(
                                          //     color: Colors.grey.withOpacity(0.5),
                                          //     spreadRadius: 5,
                                          //     blurRadius: 2,
                                          //     offset: Offset(0, 3), // changes position of shadow
                                          //   ),
                                          // ] ,
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
                                    fontSize: 19, fontWeight: FontWeight.bold),
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
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text("+"),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(35, 35)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    defaultColor),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                            ),
                                          )),
                                      const SizedBox(width: 11),
                                      Text("4"),
                                      const SizedBox(width: 11),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text("-"),
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(35, 35)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    defaultColor),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                            ),
                                          )),
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
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "\$ 500",
                              //       style: TextStyle(
                              //           fontSize: 16, color: defaultColor,
                              //           fontWeight: FontWeight.bold),
                              //     ),
                              //     Text(
                              //       "x1",
                              //       style: TextStyle(
                              //           fontSize: 14,
                              //           color: Colors.black.withOpacity(0.5),
                              //           fontWeight: FontWeight.bold),
                              //     )
                              //   ],
                              // )
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
        decoration: BoxDecoration(
          // color: Color.fromARGB(255, 249, 240, 240),
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
                    //mainAxisSize: MainAxisSize.min,
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
                  SizedBox(
                    width: 190,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(defaultColor)),
                      child: Text("Check Out"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
