import 'package:flutter/material.dart';
import '../../Views/ProductsScreens/products.dart';
import '../Block/Cubit.dart';

class CategoriesItems extends StatelessWidget {
  BuildContext context;
  int index;
  CategoriesItems(this.context, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductsScreen()),
        );
      },
      child: Row(
        children: [
          Image(
            image: NetworkImage(
                ShopCubit.get(context).cats[index].image),
            fit: BoxFit.cover,
            height: 120,
            width: 120,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              ShopCubit.get(context).cats[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
