import 'package:flutter/material.dart';
import '../../Models/ProductModel/ProductModel.dart';
import 'package:shop_app/Service/fireStore_Product.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({ Key? key }) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  @override
  Widget build(BuildContext context) {
   String? name,description ,image ,categoryName;
   int? noItemsInStock;
   double? oldPrice,price ,discount;
   List<String> prodImages=[];
   TextEditingController imageTwo = TextEditingController();
   TextEditingController imageThree = TextEditingController();
    WidgetsFlutterBinding.ensureInitialized();
   return SingleChildScrollView(
     child: Column(
        children: [
            TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        hintText: 'product Name',
                      ),
                      onChanged: (value){
                        name = value;
                      },
                  ),
   
            TextField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'old price',
              hintText: 'product old price',
            ),
              keyboardType: TextInputType.number ,
              onChanged: (value){
                oldPrice = double.parse(value);
              },
          ),
   
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'price',
                hintText: 'product price',
              ),
              keyboardType: TextInputType.number ,
              onChanged: (value){
                price = double.parse(value);
              },
            ),
   
            TextField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'description',
              hintText: 'product description',
            ),
              onChanged: (value){
                description = value;
              },
          ),
   
            TextField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'discount',
              hintText: 'product discount',
            ),
              keyboardType: TextInputType.number ,
              onChanged: (value){
                discount = double.parse(value);
              },
          ),
   
          TextField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'noItemsInStock',
              hintText: 'noItemsInStock',
            ),
              keyboardType: TextInputType.number ,
              onChanged: (value){
                noItemsInStock = int.parse(value);
              },
          ),
   
          TextField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'main image',
              hintText: 'main image',
            ),
              onChanged: (value){
                image = value;
              },
          ),
          
      
             TextField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'second Image',
              hintText: 'second Image',
            ),
              // onChanged: (value){
              //   prodImages.add(value);
              // },
              controller: imageTwo,
          ),
          TextField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'third Image',
              hintText: 'third Image',
            ),
              // onChanged: (value){
              //   prodImages.add(value);
              // },
              controller: imageThree,
          ),
          TextField(
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'categoryName',
              hintText: 'categoryName',
            ),
              keyboardType: TextInputType.number ,
              onChanged: (value){
                categoryName = value;
              },
          ),
       
          ElevatedButton(onPressed: ()async{
            try {
              // ProductModel product = ProductModel(name: name,price: price!,oldPrice: oldPrice!);
              prodImages.add(imageTwo.text);
              prodImages.add(imageThree.text);
              ProductModel product = ProductModel(name: name, oldPrice: oldPrice!, price: price!, description: description, image: image, prodImages: prodImages, noItemsInStock: noItemsInStock!, categoryName: categoryName,discount: discount);
              await  FireStoreProduct().addProductToFireStore(product);
              prodImages.clear();
            } catch (e) {
              print(e.toString());
            }
            try {
              
            } catch (e) {
            }
          }, child:const Text("Add")),
            ElevatedButton(onPressed: (){
            FireStoreProduct().getProducts();
          }, child: Text("Get"))
        ],
     ),
   );


  }
}