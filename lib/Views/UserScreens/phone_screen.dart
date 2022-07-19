import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Service/firebase_auth_methods.dart';
import '../../utils/showSnackbar.dart';
import '../LayoutScreen/shopLayout.dart';

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone';
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone number',
              hintText: 'Enter phone number',
            ),
            keyboardType: TextInputType.phone,
            controller: phoneController,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
            ),
            onPressed: () {
              FirebaseAuthMethods(FirebaseAuth.instance)
                  .phoneSignIn(context, phoneController.text)
                  .then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShopLayout()),
                );
              }).catchError((onError) {
                print("Error: ${onError.message!}");
                showSnackBar(context, onError.message!);
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
