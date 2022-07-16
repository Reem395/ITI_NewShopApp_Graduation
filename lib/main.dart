import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ViewModels/Block/Cubit.dart';
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
      token = CacheHelper.getData(key: "token");

      var boardingState = CacheHelper.getData(key: "onBoardingOpened");
      Widget widget;

      if (boardingState != null) {
        if (token != null) {
          print(token);
          widget = ShopLayout();
        } else {
          widget = LoginScreen();
        }
      } else {
        widget = OnBoarding();
      }
      // runApp(MyApp(widget));
      runApp(MyApp(const AuthScreen(title: "Auth Screen")));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  
  final Widget widget;
  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return BlocProvider<ShopCubit>(
      create: (context) {
        return ShopCubit()..getProfileData();
      },
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, states) {
          return MaterialApp(
            theme: ThemeData(
                primaryColor: const Color(0xff3b75a8),
                inputDecorationTheme: const InputDecorationTheme(
                    focusColor: Colors.red,
                    labelStyle: TextStyle(color: Color(0xff3b79a8)),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 10,
                        borderSide: BorderSide(color: Color(0xff3b75a8))))),
            home: widget,
            // home:DemoScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
        listener: (context, states) {},
      ),
=======
    return BlocProvider<ShopCubit>(create: (context){
      return ShopCubit();
    },
    child: BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state){
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
      listener: (context, state){

      },
    ),
>>>>>>> main
    );
  }
}
