import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ViewModels/Widgets/products_list.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getProdFav();
    return Scaffold(
      appBar: ShopSearchAppbar(context, false),
      body: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) => ConditionalBuilder(
            condition: state is !ShopLoadingFavScreen ,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: ProductList(ShopCubit.get(context).prodFav),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            )),
        listener: (context, state){}),
    );

  }
}
