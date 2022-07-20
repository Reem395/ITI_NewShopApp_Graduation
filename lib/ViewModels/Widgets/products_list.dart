import 'package:flutter/material.dart';
import '../../Models/ProductModel/ProductModel.dart';
import '../Block/Cubit.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> products;
  const ProductList(this.products, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(ShopCubit.get(context).prodFav.isEmpty)
      {
        return const Center(
          child: Text("UR Fav Is Empty"),
        );
      }
    return ListView.separated(
        itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.all(6.0),
            color: Colors.white,
            height: 100,
            child: Row(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(products[index].image!),
                      height: 100,
                      width: 150,
                    ),
                    if (products[index].discount > 0)
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: const Text(
                          "Discount",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red.withOpacity(.8),
                      )
                  ],
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      products[index].name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Row(
                      children: [
                        Text(
                          products[index].price.toString(),
                          style: const TextStyle(color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (products[index].discount > 0)
                          Text(
                            products[index].oldPrice.toString(),
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                            onPressed:
                              !ShopCubit.get(context).canChangeFav? null:() {
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
                            ))
                      ],
                    )
                  ],
                )),
                Container(
                  alignment: AlignmentDirectional.bottomEnd,
                )
              ],
            )),
        separatorBuilder: (context, index) => Container(
              height: 2,
              color: Colors.grey[200],
            ),
        itemCount: products.length);
  }
}
