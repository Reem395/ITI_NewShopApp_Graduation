import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/constants.dart';

import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    bool favColor = true;

    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: defaultColor,
            title: const Text("Search"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                defaultTextFormField(
                    label: "Search",
                    controller: searchController,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Search is Required";
                      }
                      return null;
                    },
                    prefix: Icons.search,
                    onEditingComplate: () {
                      cubit.searchProduct(searchController.text);
                    }),
                Expanded(
                  child: ConditionalBuilder(
                      condition: ShopCubit.get(context).searchList.isNotEmpty,
                      builder: (context) =>
                          buildSearchList(cubit.searchList!),
                      fallback: (context) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                            ],
                          )),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
