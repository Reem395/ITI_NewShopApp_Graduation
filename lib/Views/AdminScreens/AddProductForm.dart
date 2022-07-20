import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/ViewModels/constants.dart';
import '../../Models/CategoryModel/ProductCategoryModel.dart';
import '../../Models/ProductModel/ProductModel.dart';
import 'package:shop_app/Service/fireStore_Product.dart';

import '../../ViewModels/Block/Cubit.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({Key? key}) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  bool addDiscount = false;
  String? categoryName;
  List<String> allCategoriesName = [];
  @override
  void initState() {
    super.initState();
    for (var item in ShopCubit.get(context).cats) {
      allCategoriesName.add(item.name);
    }
  }

  @override
  Widget build(BuildContext context) {
  int productId= ShopCubit.get(context).products.length+1;
    String? name, description, image;
    int? noItemsInStock;
    double? oldPrice, price, discount;
    List<String> prodImages = [];
    TextEditingController imageTwo = TextEditingController();
    TextEditingController imageThree = TextEditingController();
    WidgetsFlutterBinding.ensureInitialized();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Product Name',
              ),
              onChanged: (value) {
                name = value;
              },
            ),

            const SizedBox(
              height: 10,
            ),

            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
                hintText: 'Product Price',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                price = double.parse(value);
              },
            ),

            const SizedBox(
              height: 10,
            ),

            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
                hintText: 'Product Description',
              ),
              onChanged: (value) {
                description = value;
              },
            ),

            const SizedBox(
              height: 10,
            ),

            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'No Of Items In Stock',
                hintText: 'No Of Items In Stock',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                noItemsInStock = int.parse(value);
              },
            ),

            const SizedBox(
              height: 10,
            ),

            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Main image',
                hintText: 'Main image',
              ),
              onChanged: (value) {
                image = value;
              },
            ),

            const SizedBox(
              height: 10,
            ),

            //Second Image
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Second Image',
                hintText: 'Second Image',
              ),
              // onChanged: (value){
              //   prodImages.add(value);
              // },
              controller: imageTwo,
            ),

            const SizedBox(
              height: 10,
            ),

            //Third Image
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Third Image',
                hintText: 'Third Image',
              ),
              // onChanged: (value){
              //   prodImages.add(value);
              // },
              controller: imageThree,
            ),

            const SizedBox(
              height: 10,
            ),

            //Cat Name
            DropdownButton<String>(
              value: categoryName,
              hint: const Text(
                "Select Category",
                style: TextStyle(fontSize: 17),
              ),
              elevation: 16,
              style: TextStyle(color: defaultColor),
              underline: Container(
                height: 2,
                color: defaultColor,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  categoryName = newValue;
                });
              },
              items: allCategoriesName
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            const SizedBox(
              height: 45,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.discount,
                      color: defaultColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "Add Discount: ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        addDiscount = true;
                        print(addDiscount);
                      });
                    },
                    icon: Icon(Icons.add)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            addDiscount == true
                ? TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Discount',
                      hintText: 'Product Discount',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      discount = double.parse(value);
                    },
                  )
                : const SizedBox(
                    height: 5,
                  ),
            const SizedBox(
              height: 45,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 14,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(defaultColor)),
                  onPressed: () async {
                    try {
                      if (name == "" ||
                          description == "" ||
                          image == "" ||
                          imageTwo.text == "" ||
                          imageThree.text == "" ||
                          categoryName == "") {
                        Fluttertoast.showToast(
                            msg: "Please enter all fields",
                            toastLength: Toast.LENGTH_SHORT);
                      } else if (price == 0.0||noItemsInStock==0) {
                        Fluttertoast.showToast(
                            msg: "Please enter valid Number",
                            toastLength: Toast.LENGTH_SHORT);
                      } else if (discount! > 0) {
                        oldPrice = price;
                        price = (oldPrice! * (100 - discount!)) / 100;
                      } else {
                        prodImages.add(imageTwo.text);
                        prodImages.add(imageThree.text);
                        ProductModel product = ProductModel(
                            productId:productId,
                            name: name,
                            oldPrice: oldPrice!,
                            price: price!,
                            description: description,
                            image: image,
                            prodImages: prodImages,
                            noItemsInStock: noItemsInStock!,
                            categoryName: categoryName,
                            discount: discount);

                        await FireStoreProduct().addProductToFireStore(product);

                        prodImages.clear();

                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Success",
                                  style: TextStyle(color: defaultColor),
                                ),
                                content:
                                    const Text("Product Added Successfully"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Ok"),
                                  )
                                ],
                              );
                            });
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                    // try {} catch (e) {}
                  },
                  child: const Text("Add New Product")),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       FireStoreProduct().getProducts();
            //     },
            //     child: Text("Get")),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
