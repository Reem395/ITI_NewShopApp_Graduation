import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/ProductModel/ProductModel.dart';
import 'package:shop_app/ViewModels/Block/States.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Widgets/admin_Product_item_categories.dart';
import '../../ViewModels/Widgets/product_items_categries.dart';
import '../../ViewModels/constants.dart';

class AdminProductsScreen extends StatelessWidget {
  final String categoryName;
  AdminProductsScreen(this.categoryName,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String,List<ProductModel>> products= ShopCubit.get(context).categoriesProducts;

return BlocConsumer<ShopCubit,ShopStates>(
  builder: (context, state){
    return Scaffold(
      appBar: AppBar(title: const Text('Products'),
        backgroundColor: defaultColor,),
      body: ConditionalBuilder(
        fallback: (BuildContext context) {
          return const CircularProgressIndicator();
        },
        condition: state is !GetCategoriesProductsLoading,
        builder: (BuildContext context) {
          return GridView.builder(
            padding: const EdgeInsets.all(15.0),
            itemCount: products[categoryName]?.length,
            // itemBuilder: (ctx, index) => (ProductItem(products[categoryName]![index])),
            itemBuilder: (ctx, index) => (AdminProductItem(products[categoryName]![index])),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
          );
        },
      ),
    );
  },
  listener: (context, state){

  },
);
  }
}
