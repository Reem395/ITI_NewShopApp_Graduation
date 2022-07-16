import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ViewModels/Widgets/categories_list.dart';
import 'package:shop_app/ViewModels/Widgets/products_gridview.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getProductsTany();
    return CupertinoTabView(
      builder: ((context) {
        return  BlocConsumer<ShopCubit, ShopStates>(
          builder: (context, states) {
            return ConditionalBuilder(
              condition: ShopCubit.get(context).favouritesProd.isNotEmpty,
              builder: (context) => Scaffold(
                appBar: ShopSearchAppbar(context),
                body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   // buildBanner(homeModel),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Categories",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 23,
                                fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CategoriesList(context),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Products",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 23,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ProductGridView(ShopCubit.get(context).products)
                  ],
                ),
              ),
              ),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          listener: (context, states) {});
      }),
      
    );
  }
}
