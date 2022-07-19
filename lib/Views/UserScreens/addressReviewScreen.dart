import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/ViewModels/constants.dart';

import '../../ViewModels/Components.dart';
import 'addAddress_screen.dart';

class addressReviewScreen extends StatefulWidget {
  const addressReviewScreen({Key? key}) : super(key: key);

  @override
  State<addressReviewScreen> createState() => _addressReviewScreenState();
}

class _addressReviewScreenState extends State<addressReviewScreen> {
  bool secondaryAddressExisted = false;
String primaryAddress="2526 Walt Nuzum Farm Road, Angelica,New York";
String secondaryAddress ="4661 Chipmunk Lane, Seattle Washington";
  @override
  Widget build(BuildContext context) {

           return Scaffold(
      appBar: AppBar(
        title: const Text("Your Addresses"),
        backgroundColor: defaultColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.home,
                    color: defaultColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Primary Address: ",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("$primaryAddress"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              secondaryAddressExisted == true
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.home,
                              color: defaultColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Secondary Address: ",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                              child: Text("$secondaryAddress"),
                      
                          ),
                        ),
                           const SizedBox(
                height: 25,
              ),
                      ],
                    )
                  : SizedBox(
                      height: 1,
                    ),
              ElevatedButton(
                onPressed: () {
                  navigateTo(context, const AddAddressScreen());
                },
                child: const Text("Edit Address"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(defaultColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
