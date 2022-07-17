import 'package:flutter/material.dart';
import 'package:shop_app/ViewModels/constants.dart';

class orderReviewScreen extends StatefulWidget {
  const orderReviewScreen({Key? key}) : super(key: key);

  @override
  State<orderReviewScreen> createState() => _orderReviewScreenState();
}

class _orderReviewScreenState extends State<orderReviewScreen> {
  double orderTotalPrice = 115;
  double shippingPrice = 50;
  @override
  Widget build(BuildContext context) {
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
                        Text("EGP ${shippingPrice + orderTotalPrice}",
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
            Text(
              "Select Payment Method",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/gPay128.png'),
                              backgroundColor: Colors.white,
                              radius: 25,
                            ),
                            // const SizedBox(width: 15,),
                  //           Text("GPay",style: TextStyle(
                  // fontSize: 15,
                  // color: defaultColor,
                  // fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Checkbox(value: false, onChanged: (ischecked) {})
                      ],
                    ),
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
                        Checkbox(value: false, onChanged: (ischecked) {})
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
              onPressed: () {},
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
