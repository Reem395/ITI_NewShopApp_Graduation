import 'package:flutter/material.dart';
import '../../ViewModels/constants.dart';

class RestPasswordScreen extends StatelessWidget {
  const RestPasswordScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.symmetric(
              vertical: 30.0, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Current Password",style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: currentPasswordController,
                    decoration: const InputDecoration(
                      hintText: "Enter your current Password"
                    ),
                  ),
                  const SizedBox(height: 25,),
                  
                  const Text("New Password",style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 8,),
                  TextFormField(
                    controller: currentPasswordController,
                    decoration: const InputDecoration(
                      hintText: "Enter New Password"
                    ),
                  ),

                  const SizedBox(height: 25,),
                  
                  const Text("Confirm New Password",style: TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold
                  ),),

                  const SizedBox(height: 8,),

                  TextFormField(
                    controller: currentPasswordController,
                    decoration: const InputDecoration(
                      hintText: "Confirm New Password"
                    ),
                  ),

                  const SizedBox(
                        height: 40,
                      ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(defaultColor)),
                          onPressed: () {
                            
                          },
                          child: const Text("Reset Password"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
    ),
    );
  }
}