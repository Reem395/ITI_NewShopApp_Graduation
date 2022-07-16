import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Modules/phone_screen.dart';

import '../Layout/shopLayout.dart';
import '../Service/firebase_auth_methods.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PhoneScreen()),
                );
              },
              child: const Text('Sign in with Phone number'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                FirebaseAuthMethods(FirebaseAuth.instance)
                    .signInWithGoogle(context)
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayout()),
                  );
                });
              },
              child: const Text('Sign in with Google'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                FirebaseAuthMethods(FirebaseAuth.instance)
                    .signInWithFacebook(context)
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayout()),
                  );
                });
              },
              child: const Text('Sign in with Facebook'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: () {
                FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
