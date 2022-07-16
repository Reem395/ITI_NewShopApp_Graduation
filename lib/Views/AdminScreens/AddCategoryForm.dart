import 'package:flutter/material.dart';
import '../../Models/CategoryModel/ProductCategoryModel.dart';
import 'package:shop_app/Service/fireStore_Category.dart';

class AddCategoryForm extends StatelessWidget {
  const AddCategoryForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  String? name, image;

    return Column(
      children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
              hintText: 'Category Name',
            ),
            onChanged: (value){
              name = value;
            },
        ),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'image',
            hintText: 'Category image',
          ),
          onChanged: (value){
            image = value;
          },
      ),
      ElevatedButton(onPressed: () async{
          try {
            ProductCategoryModel category  = ProductCategoryModel(name: name!, image: image!);
            await FireStoreCategory().addCategoryToFireStore(category);
          } catch (e) {
              print(e.toString());
          }
      }, child: const Text("Add")),


      ElevatedButton(onPressed: (){
          FireStoreCategory().getProductCategories();
      },
       child: const Text("Get")),
      ],
    );
  }
}