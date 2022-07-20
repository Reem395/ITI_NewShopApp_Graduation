import 'package:flutter/material.dart';
import 'package:shop_app/Models/ProductModel/ProductModel.dart';
import '../../Views/ProductsScreens/product_details.dart';
import '../Block/Cubit.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem(this.product,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(product)),
            );
          },
          child: Image.network(
          product.image!,
          fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: const Color.fromARGB(221, 78, 82, 87),
          leading: IconButton(
              onPressed:
                !ShopCubit.get(context).canChangeFav? null:() {
                  ShopCubit.get(context)
                      .changeFav(product);
              },
              icon: Icon(
                !ShopCubit.get(context).favouritesProd[
                product.productId]!
                    ? Icons.favorite_outline
                    : Icons.favorite,
                color: Colors.red,
              )),
          title: Text(
            product.name!,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
            color: Theme
                .of(context)
                .primaryColor,
          ),
        ),
      ),
    );
  }
}
