import 'package:flutter/material.dart';
import '../../Models/ProductModel/ProductModel.dart';
import '../../ViewModels/constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsScreen(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title:  const Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Image.network(
                  product.image!,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
               Text(
                '\$${product.price!}',
                style: const TextStyle(
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
                child: Text(
                  product.description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
