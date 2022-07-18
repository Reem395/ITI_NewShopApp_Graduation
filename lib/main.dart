import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ViewModels/Block/Cubit.dart';
import 'Service/firebase_auth_methods.dart';
import 'ViewModels/Block/States.dart';
import 'ViewModels/Local/CacheHelper.dart';
import 'ViewModels/Network/DioHelper.dart';
import 'Views/LayoutScreen/ShopLayout.dart';
import 'Views/OnBoardingScreen/on_boarding_screen.dart';
import 'Views/UserScreens/LoginScreen.dart';
import 'ViewModels/BlocObserver.dart';
import 'ViewModels/constants.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      DioHelper.init();
      await CacheHelper.init();
      // token = FirebaseAuthMethods(FirebaseAuth.instance).user?.uid;
      token = null;

      var boardingState = CacheHelper.getData(key: "onBoardingOpened");
      Widget widget;

      if (boardingState != null) {
        if (token != null) {
          widget = ShopLayout();
        } else {
          widget = const LoginScreen();
        }
      } else {
        widget = const OnBoardingScreen();
      }
      var collection = FirebaseFirestore.instance.collection('Users');
      var a = FirebaseAuthMethods(FirebaseAuth.instance).user;
      // collection
      //     .doc(
      //         "8VYUATqWJJqvFvVyd6uu") // <-- Doc ID where data should be updated.
      //     .update({
      //   'userId': 1,
      //   'email': 2,
      //   'name': 2,
      //   'phone': null,
      //   'state': null,
      //   'city': null,
      //   'description': null
      // });
      // print("sssssssssssss ${a}");
      // print("sssssssssssss ${a}");
      runApp(MyApp(widget));
      // runApp(MyApp(const AuthScreen(title: "Auth Screen")));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp(this.widget, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopCubit>(
      create: (context) {
        return ShopCubit();
      },
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
                primaryColor: const Color(0xff00695C),
                inputDecorationTheme: const InputDecorationTheme(
                    focusColor: Colors.red,
                    labelStyle: TextStyle(color: Color(0xff3b79a8)),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 10,
                        borderSide: BorderSide(color: Color(0xff3b75a8))))),
            home: widget,
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
