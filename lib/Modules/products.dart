import 'package:flutter/material.dart';

import '../Shared/Components.dart';
import '../Shared/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: 10,
        itemBuilder: (ctx, i) => (const ProductItem()),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
      );

    
  }
}
