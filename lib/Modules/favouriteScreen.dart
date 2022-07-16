import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/Block/States.dart';
import 'package:shop_app/Modules/searchScreen.dart';
import '../Models/favouritesModel.dart';
import '../Shared/Components.dart';
import '../Shared/constants.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavouritesModel? cubit = ShopCubit.get(context).favouritesModel;
    bool favColor = true;
    return Scaffold(
      appBar: ShopSearchAppbar(context),
      body: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) => ConditionalBuilder(
            condition: state is !ShopLoadingFavScreen,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  child: buildProductList(cubit, favColor)),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator())),
        listener: (context, state){}),
    );

  }
}
