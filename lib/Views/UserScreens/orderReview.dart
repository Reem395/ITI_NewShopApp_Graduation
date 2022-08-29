import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/ViewModels/constants.dart';
import 'package:shop_app/Views/LayoutScreen/shopLayout.dart';

import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Components.dart';
import '../HomeScreen/home_screen.dart';

class orderReviewScreen extends StatelessWidget {
  //  orderReviewScreen({Key? key}) : super(key: key);
  dynamic orderTotalPrice;
  double shippingPrice = 50;
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    orderTotalPrice = ShopCubit.get(context).cartProdPrice;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order summary"),
        backgroundColor: defaultColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Order Total Price: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "EGP $orderTotalPrice",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Shipping Cost: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text("EGP $shippingPrice",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Order Total Price: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text("EGP ${shippingPrice + orderTotalPrice!}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Text(
            //   "Select Payment Method",
            //   style: TextStyle(
            //       fontSize: 20,
            //       color: defaultColor,
            //       fontWeight: FontWeight.bold),
            // ),
            Text(
              "Payment Method: ",
              style: TextStyle(
                  fontSize: 20,
                  color: defaultColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           const CircleAvatar(
                    //             backgroundImage:
                    //                 AssetImage('assets/images/gPay128.png'),
                    //             backgroundColor: Colors.white,
                    //             radius: 25,
                    //           ),
                    //           // const SizedBox(width: 15,),
                    // //           Text("GPay",style: TextStyle(
                    // // fontSize: 15,
                    // // color: defaultColor,
                    // // fontWeight: FontWeight.bold),),
                    //         ],
                    //       ),
                    //       Checkbox(value: false, onChanged: (ischecked) {})
                    //     ],
                    //   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Image.asset("assets/images/cash-on-delivery.png",
                            // width: 40,),
                            // const SizedBox(width: 25,),

                            Text(
                              "Cash On Delivery",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: defaultColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // const CircleAvatar(
                        //   backgroundImage:
                        //       AssetImage('assets/images/COD.png'),
                        //   backgroundColor: Colors.white,
                        //   radius: 30,
                        // ),
                        Checkbox(
                            value: true,
                            onChanged: (ischecked) {
                              // setState(() {
                              //   checked = ischecked!;
                              // });
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Order Placed Successfully",
                    toastLength: Toast.LENGTH_SHORT);
                var id =
                    FirebaseFirestore.instance.collection('Orders').doc().id;

                FirebaseFirestore.instance.collection('Orders').add({
                  'orderId': id,
                  'userId': uId,
                  'prodIds': [],
                  'orderState': 'pending'
                });
                ////////yasser
                FirebaseFirestore.instance
                .collection('Carts')
                .where('userId', isEqualTo: uId)
                .snapshots()
                .listen((data) {
                 data.docs.forEach((element) {
                   
                FirebaseFirestore.instance.collection('Carts').doc(element.id).delete();
                  });
              
            });
            ShopCubit.get(context).carts.clear();
            ShopCubit.get(context).cartProd.clear();
            ShopCubit.get(context).changeCurrentIndex(0);
                navigateAndReplace(context,HomeScreen());
                // Navigator.pushReplacement(context, newRoute)
              },
              child: const Text("Place Order"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(defaultColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
