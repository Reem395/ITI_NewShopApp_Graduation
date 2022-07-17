import 'package:flutter/material.dart';
import 'package:shop_app/ViewModels/constants.dart';
import '../../Models/ProductModel/ProductModel.dart';
import '../Block/Cubit.dart';

class ProductGridView extends StatelessWidget {
  final List<ProductModel> products;
  ProductGridView(this.products, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1 / 1.4,
        children: List.generate(
          products.length,
          (index) => Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image.network(
                        products[index].image!,
                        height: 150,
                        width: double.infinity,
                      ),
                      if (products[index].discount > 0)
                        Container(
                          padding: EdgeInsets.all(1),
                          child: const Text(
                            "Discount",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                        )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].name!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(height: 1.3, fontSize: 13),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Row(children: [
                            Text(
                              products[index].price.round().toString(),
                              style: const TextStyle(color: Colors.blue),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            if (products[index].discount != 0)
                              Text(
                                products[index].oldPrice.toString(),
                                style: const TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            const Spacer(),
                            Row(children: [
                                    IconButton(
                                iconSize: 22,
                                onPressed: () {
                                 //Add To cart
                                },
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: defaultColor,
                                )),
                              IconButton(
                                iconSize: 22,
                                onPressed: () {
                                  ShopCubit.get(context)
                                      .changeFav(products[index]);
                                  products[index].productId;
                                },
                                icon: Icon(
                                  !ShopCubit.get(context).favouritesProd[
                                          products[index].productId]!
                                      ? Icons.favorite_outline
                                      : Icons.favorite,
                                  color: Colors.red,
                                )),

                          
                            ],),
                          ]),
                        ],
                      ))
                ],
              )),
        ));
  }
}
