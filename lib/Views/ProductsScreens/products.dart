import 'package:flutter/material.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(title: const Text('Products'),
      backgroundColor: defaultColor,),
      body: GridView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: 10,
        itemBuilder: (ctx, i) => (const ProductItem()),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}
