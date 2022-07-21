import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/ViewModels/Widgets/categories_items.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/Block/Cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getProductsPerCat();
    return CupertinoTabView(
      builder: (context){
        return Scaffold(
          appBar: ShopSearchAppbar(context, false),
          body: ConditionalBuilder(
            condition: ShopCubit.get(context).cats.isNotEmpty,
            builder: (context)
            {
              return ListView.separated(
                  itemBuilder: (context, index) => SizedBox(
                    height: 120,
                    width: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CategoriesItems(context, index),
                    ),
                  ),
                  separatorBuilder: (context, index) => Container(height: 1, color: Colors.grey[300],),
                  itemCount: ShopCubit.get(context).cats.length);
            },
            fallback: (context){
              return const Center(
                child: Text("Categories List Is Empty :("),
              );
            }
          ),
        );
      },
    );
  }
}
