import 'package:flutter/material.dart';
import 'package:shop_app/Models/OrderModel.dart';
import 'package:shop_app/Service/fireStore_Order.dart';

import '../Models/OrderModel.dart';
import '../Service/fireStore_Cart.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({ Key? key }) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
   String? userId,state;
   List<String> productIds=[];
   TextEditingController prod1 = TextEditingController();
   TextEditingController Prod2 = TextEditingController();
   
   WidgetsFlutterBinding.ensureInitialized();
   return SingleChildScrollView(
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
          children: [

              TextField(
                decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'userId price',
                hintText: 'product old price',
              ),
                keyboardType: TextInputType.number ,
                onChanged: (value){
                  userId = value;
                },
            ),
   
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'productId',
                  hintText: 'productId price',
                ),
                keyboardType: TextInputType.number ,
                onChanged: (value){
                  state = value;
                },
              ),
   
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'prodId1',
                  hintText: 'prodId1',
                ),
                keyboardType: TextInputType.number ,
                controller: prod1,
              ),

             TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'prodId2',
                  hintText: 'prodId2',
                ),
                keyboardType: TextInputType.number ,
                controller: Prod2,
              ),
              ElevatedButton(onPressed: ()async{
              try {
                productIds.add(prod1.text);
                productIds.add(Prod2.text);
                OrderModel orderModel = OrderModel(userId: userId!, prodIds: productIds, state: state!);
                await  FireStoreOrder().addOrderToFireStore(orderModel);
                productIds.clear();
              } catch (e) {
                print(e.toString());
              }

            }, child:const Text("Add")),


            
              ElevatedButton(onPressed: (){
              FireStoreOrder().getOrders();
            }, child: Text("Get"),),
          ],
       ),
     ),
   );


  }
}