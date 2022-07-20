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
final TextEditingController name = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController image = TextEditingController();
  final TextEditingController noItemsInStock =TextEditingController();
    double? oldPrice ;
     TextEditingController price = TextEditingController();
    final TextEditingController discount = TextEditingController();
    final List<String> prodImages = [];
    final TextEditingController imageTwo = TextEditingController();
    final TextEditingController imageThree = TextEditingController();
  @override
  Widget build(BuildContext context) {
  int productId= ShopCubit.get(context).products.length+1;
  

    // TextEditingController oldPrice = TextEditingController();
    
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
              controller: name,
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
              controller: price,
   
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
              controller: description,
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
              controller: noItemsInStock,
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
              controller: image,
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
                  // categoryName = newValue;

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
                    controller: discount,
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
                      int flag =0;
                      print(categoryName);
                      if (name.text.isEmpty  ||
                          description.text.isEmpty ||
                          image.text.isEmpty||
                          imageTwo.text.isEmpty ||
                          imageThree.text.isEmpty ||
                          categoryName!.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please enter all fields",
                            toastLength: Toast.LENGTH_SHORT);
                            flag =1;
                      } 
                      else if (double.parse(price.text) == 0.0||int.parse(noItemsInStock.text)==0) {
                        Fluttertoast.showToast(
                            msg: "Please enter valid Number",
                            toastLength: Toast.LENGTH_SHORT);
                            flag=1;
                      }
                       if (double.parse(discount.text) > 0) {
                        oldPrice = double.parse(price.text);
                        price.text = ((oldPrice! * (100 - double.parse(discount.text))) / 100).toString();
                      } 
                      if(flag==0) {
                        print("Product: $productId , $name, $oldPrice ,$price , $description , $image , ${imageTwo.text},${imageThree.text},$noItemsInStock,$categoryName,$discount");
                        prodImages.add(imageTwo.text);
                        prodImages.add(imageThree.text);
                        ProductModel product = ProductModel(
                            productId:productId,
                            name: name.text,
                            oldPrice: oldPrice,
                            price: double.parse(price.text) ,
                            description: description.text,
                            image: image.text,
                            prodImages: prodImages,
                            noItemsInStock: int.parse(noItemsInStock.text),
                            categoryName: categoryName,
                            discount: double.parse(discount.text));

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
                       
                      
                      // }
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
