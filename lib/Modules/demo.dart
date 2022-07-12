import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({ Key? key }) : super(key: key);

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
        return(
            Scaffold(body: 
            Center(child: ElevatedButton(child: Text("Click"),
            onPressed: (){
              FirebaseDatabase.instance.ref().child("Product").set(520);
            },),),)
        );
      },      
    );


    // return(
    //   Scaffold(body: 
    //         Center(child: ElevatedButton(child: Text("Click"),
    //         onPressed: (){
    //           // FirebaseDatabase.instance.ref().child("Product").set(20);
    //         },),),)
    // );
  }
}