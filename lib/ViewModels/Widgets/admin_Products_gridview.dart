import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/ViewModels/Block/States.dart';
import 'package:shop_app/ViewModels/constants.dart';
import 'package:shop_app/Views/HomeScreen/home_screen.dart';
import 'package:shop_app/Views/LayoutScreen/adminShopLayout.dart';
import '../../Models/ProductModel/ProductModel.dart';
import '../../Service/fireStore_Product.dart';
import '../../Views/AdminScreens/adminHome_screen.dart';
import '../Block/Cubit.dart';
import '../Components.dart';

class admin_ProductGridView extends StatelessWidget {
  final List<ProductModel> products;
  admin_ProductGridView(this.products, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(builder: (context,state){
      
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
                            Row(
                              children: [
                                IconButton(
                                    iconSize: 22,
                                    onPressed: () {
                                      int flag=0;
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Alert",
                                                style: TextStyle(
                                                    color: defaultColor),
                                              ),
                                              content: const Text(
                                                  "Are you sure you want to remove this product?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    flag=1;
                                                    if(flag==1){
                                                      print("Product Length: ${ShopCubit.get(context).products.length}");
                                                    print(
                                                        "prod id: ${products[index].productId}");
                                                    String? productDocID;
                                                    var productId =
                                                        products[index]
                                                            .productId;
                                                    FirebaseFirestore.instance
                                                        .collection("products")
                                                        .where("productId",
                                                            isEqualTo:
                                                                productId)
                                                        .snapshots()
                                                        .listen(((event) =>
                                                            event.docs.forEach(
                                                                (element) {
                                                              // print("element.id: ${element.id}");
                                                              productDocID =
                                                                  element.id;
                                                              FireStoreProduct()
                                                                  .deleteProduct(
                                                                      productDocID!,
                                                                      context);
                                                            })));
                                                    print(
                                                        "productDocID: $productDocID");

                                                    
                                                    await Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AdminShopLayout()), // this mainpage is your page to refresh
                                                      (Route<dynamic> route) =>
                                                          true,
                                                    );
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Product Removed Successfully!",
                                                        toastLength:
                                                            Toast.LENGTH_LONG);
                                                    }
                                                  },
                                                  child: const Text("Ok"),
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Cancel"))
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.highlight_remove,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ]),
                        ],
                      ))
                ],
              )),
        ));
  
  
    }, listener: (context,state){});
  }
}
