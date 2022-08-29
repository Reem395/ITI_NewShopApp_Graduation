import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/ViewModels/constants.dart';
import '../../Models/CategoryModel/ProductCategoryModel.dart';
import '../../Models/ProductModel/ProductModel.dart';
import 'package:shop_app/Service/fireStore_Product.dart';

import '../../ViewModels/Block/Cubit.dart';

class EditProductForm extends StatefulWidget {
  final ProductModel product;
  const EditProductForm(this.product, {Key? key}) : super(key: key);

  @override
  State<EditProductForm> createState() => _EditProductFormState();
}

class _EditProductFormState extends State<EditProductForm> {
  bool addDiscount = true;
  String? categoryName;
  List<String> allCategoriesName = [];
  @override
  void initState() {
    super.initState();
    for (var item in ShopCubit.get(context).cats) {
      allCategoriesName.add(item.name);
    }
  }

// final TextEditingController name = TextEditingController();
//   final TextEditingController description = TextEditingController();
//   final TextEditingController image = TextEditingController();
//   final TextEditingController noItemsInStock =TextEditingController();
//     double? oldPrice ;
//      TextEditingController price = TextEditingController();
//     final TextEditingController discount = TextEditingController();
//     final List<String> prodImages = [];
//     final TextEditingController imageTwo = TextEditingController();
//     final TextEditingController imageThree = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductModel myProduct = widget.product;

    int productId = ShopCubit.get(context).products.length + 1;
    String? name = myProduct.name;
    String? description = myProduct.description;
    String? image = myProduct.image;

    int? noItemsInStock = myProduct.noItemsInStock;
    dynamic oldPrice = myProduct.oldPrice;
    dynamic price = myProduct.price;
    dynamic discount = myProduct.discount;

    List<String> prodImages = myProduct.prodImages;
    TextEditingController imageTwo = TextEditingController();
    TextEditingController imageThree = TextEditingController();
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
        backgroundColor: defaultColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: name,
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: price.toString(),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: description,
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: noItemsInStock.toString(),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: image,
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
               
                controller: imageThree,
              ),

              const SizedBox(
                height: 10,
              ),

              //Cat Name
              DropdownButton<String>(
                value: categoryName,
                hint:  Text(
                  "${myProduct.categoryName}",
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: discount.toString(),
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
                        backgroundColor:
                            MaterialStateProperty.all(defaultColor)),
                    onPressed: () async {
                      try {
                        int flag =0;
                        if (name == "" ||
                            description == "" ||
                            image == "" ||
                            imageTwo.text == "" ||
                            imageThree.text == "" ||
                            categoryName == "") {
                          Fluttertoast.showToast(
                              msg: "Please enter all fields",
                              toastLength: Toast.LENGTH_SHORT);
                              flag=1;
                        } else if (price == 0.0 || noItemsInStock == 0) {
                          Fluttertoast.showToast(
                              msg: "Please enter valid Number",
                              toastLength: Toast.LENGTH_SHORT);
                              flag=1;
                        }  if (discount! > 0) {
                          oldPrice = price;
                          price = (oldPrice! * (100 - discount!)) / 100;
                        }
                         if(flag==0) {
                          prodImages.add(imageTwo.text);
                          prodImages.add(imageThree.text);
                          ProductModel product = ProductModel(
                              name: name,
                              oldPrice: oldPrice!,
                              price: price,
                              description: description,
                              image: image,
                              prodImages: prodImages,
                              noItemsInStock: noItemsInStock!,
                              categoryName: categoryName,
                              discount: discount);

                          String? productDocID;
                          FirebaseFirestore.instance
                              .collection("products")
                              .where("productId", isEqualTo: productId)
                              .snapshots()
                              .listen(((event) => event.docs.forEach((element) {
                                    // print("element.id: ${element.id}");
                                    productDocID = element.id;
                                    print("productDocID: $productDocID");
                                  })));
                          await FireStoreProduct()
                              .updateProduct(productDocID!, product);

                          prodImages.clear();

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Success",
                                    style: TextStyle(color: defaultColor),
                                  ),
                                  content: const Text(
                                      "Product Updated Successfully"),
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
                    child: const Text("Update Product")),
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
      ),
    );
  }
}
