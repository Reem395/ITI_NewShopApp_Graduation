import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/ViewModels/Block/Cubit.dart';
import 'package:shop_app/ViewModels/Block/States.dart';
import 'package:shop_app/ViewModels/Local/CacheHelper.dart';
import 'package:shop_app/Views/UserScreens/UserFullInfo.dart';
import 'package:shop_app/Views/UserScreens/orderReview.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/constants.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getCartProducts();
    cart = CacheHelper.getData(key: "cart");
    if (cart == null) {
      showMessage("Swap right or left to remove item");
    }
    //  CacheHelper.removeKey(key: "cart");
    CacheHelper.setData(key: "cart", value: true);
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (cntext, state) {
          return CupertinoTabView(
            builder: ((context) {
              return Scaffold(
                appBar: ShopSearchAppbar(context, false),
                backgroundColor: const Color.fromARGB(255, 237, 237, 237),
                body: Container(
                  color: const Color.fromARGB(255, 237, 237, 237),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: List.generate(
                              ShopCubit.get(context).cartProducts.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Dismissible(
                                    key: UniqueKey(),
                                    background: Container(
                                      color: defaultColor,
                                      child: const Icon(Icons.delete),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Center(
                                                  child: Container(
                                                    width: 120,
                                                    height: 120,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                ShopCubit.get(
                                                                        context)
                                                                    .cartProducts[
                                                                        index]
                                                                    .image!),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ShopCubit.get(context)
                                                  .cartProducts[index]
                                                  .name!,
                                              style: const TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              ShopCubit.get(context)
                                                  .cartProducts[index]
                                                  .price
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: defaultColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons
                                                            .remove_circle_outline,
                                                      ),
                                                      onPressed: () {
                                                        !ShopCubit.get(context)
                                                                .canChangeCart
                                                            ? null
                                                            : ShopCubit.get(
                                                                    context)
                                                                .removeFromCart(
                                                                    ShopCubit.get(
                                                                            context)
                                                                        .cartProducts[index]);
                                                      },
                                                      color: defaultColor,
                                                    ),
                                                    Text(
                                                      ShopCubit.get(context)
                                                          .cartProdCount[
                                                              ShopCubit.get(
                                                                      context)
                                                                  .cartProducts[
                                                                      index]
                                                                  .productId]
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    IconButton(
                                                      disabledColor:
                                                          Colors.grey,
                                                      icon: const Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                      ),
                                                      onPressed: !ShopCubit.get(
                                                                      context)
                                                                  .productExist(
                                                                      ShopCubit.get(context)
                                                                              .cartProducts[
                                                                          index]) ||
                                                              !ShopCubit.get(
                                                                      context)
                                                                  .canChangeCart
                                                          ? null
                                                          : () {
                                                              ShopCubit.get(
                                                                      context)
                                                                  .addToCart(ShopCubit
                                                                          .get(
                                                                              context)
                                                                      .cartProducts[index]);
                                                            },
                                                      color: defaultColor,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                    onDismissed: (direction) {
                                      !ShopCubit.get(context).canChangeCart
                                          ? null
                                          : ShopCubit.get(context)
                                              .removeFromCart(
                                                  ShopCubit.get(context)
                                                      .cartProducts[index],
                                                  all: true);
                                    }),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: Container(
                  padding: EdgeInsets.all(20),
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 249, 240, 240),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              //mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ShopCubit.get(context)
                                      .cartProdPrice
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: defaultColor,
                              ),
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: const [
                                      Text(
                                        "Check out",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  print("check");
                                  FirebaseFirestore.instance
                                      .collection('Users')
                                      .where('userId', isEqualTo: uId)
                                      .snapshots()
                                      .listen((data) {
                                    if (data.docs.first['state'] == null ||
                                        data.docs.first['city'] == null ||
                                        data.docs.first['description'] ==
                                            null ||
                                        data.docs.first['phone'] == null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserFullInfo()),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                orderReviewScreen()),
                                      );
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
        listener: (context, state) {});
  }
}
