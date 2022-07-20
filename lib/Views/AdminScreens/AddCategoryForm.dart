import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/ViewModels/constants.dart';
import '../../Models/CategoryModel/ProductCategoryModel.dart';
import 'package:shop_app/Service/fireStore_Category.dart';

import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Components.dart';

class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name="", image="";
    int categoryNewID = ShopCubit.get(context).cats.length + 1;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Category Name',
              ),
              onChanged: (value) {
                name = value;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image URL',
                hintText: 'Category image',
              ),
              onChanged: (value) {
                image = value;
              },
            ),

            const SizedBox(
              height: 25,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height /14,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(defaultColor)),
                  onPressed: () async {
                    try {
                      if(name==""|| image==""){
                        Fluttertoast.showToast(msg: "Please enter all fields",
                        toastLength: Toast.LENGTH_SHORT);
                      }
                      else{
                          ProductCategoryModel category =
                          ProductCategoryModel(categoryId: categoryNewID, name: name!, image: image!);
                          await FireStoreCategory().addCategoryToFireStore(category);
                        showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text("Success",style: TextStyle(color: defaultColor),),
                              content: const Text("Category Added Successfully"),
                              actions: [
                                TextButton(onPressed: (){
                                   Navigator.of(context).pop();  
                                }, child: const Text("Ok"),)
                              ],
                            );
                        });
                        print("cat added");
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: const Text("Add New Category")),
            ),

            // ElevatedButton(onPressed: (){
            //     FireStoreCategory().getProductCategories();
            // },
            //  child: const Text("Get")),

            
            // ElevatedButton(onPressed: (){
            //     print("categoryNewId: $categoryNewID");
            // },
            //  child: const Text("categoryNewId")),
          ],
        ),
      ),
    );
  }
}
