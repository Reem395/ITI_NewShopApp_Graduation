import 'package:flutter/material.dart';

import '../Shared/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: defaultColor,
      //   title: const Text("Name of Products"),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Image.asset(
                'assets/images/girl.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              '\$600',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: const Text(
                'description description description description description description description description description description description description description ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
