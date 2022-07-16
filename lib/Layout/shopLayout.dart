import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Modules/Admin/AddCategoryForm.dart';
import 'package:shop_app/Modules/Block/Cubit.dart';
import 'package:shop_app/Modules/Block/States.dart';
import 'package:shop_app/Modules/CategoriesScreen.dart';
import 'package:shop_app/Modules/LoginScreen.dart';
import 'package:shop_app/Modules/demo.dart';
import 'package:shop_app/Modules/favouriteScreen.dart';
import 'package:shop_app/Modules/productScreen.dart';
import 'package:shop_app/Modules/ProfileScreen.dart';
import 'package:shop_app/Shared/Components.dart';
import 'package:shop_app/Shared/Local/CacheHelper.dart';
import '../Modules/AccountInfoScreen.dart';
import '../Modules/AddressScreen.dart';
import '../Modules/Admin/AddProductForm.dart';
import '../Modules/ResetPassword.dart';
import '../Modules/products.dart';
import '../Modules/profile.dart';
import '../Modules/searchScreen.dart';
import '../Shared/constants.dart';

class ShopLayout extends StatefulWidget {
  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  // String currentPage= "Home";
  // List<String> pageKeys= ["Home","Categories","Favourites","Profile"];
  // Map<String, GlobalKey<NavigatorState>> navigatorKeys=
  // {
  //   "Home":GlobalKey<NavigatorState>(),
  //   "Categories":GlobalKey<NavigatorState>(),
  //   "Favourites":GlobalKey<NavigatorState>(),
  //   "Profile":GlobalKey<NavigatorState>(),
  // };

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:BlocProvider<ShopCubit>(
          create: (context) {
            return ShopCubit()
              ..loadHome()
              ..loadCategories()
              ..getFavourites()
              ..getProfileData();
          },
          child: BlocConsumer<ShopCubit, ShopStates>(
            builder: (BuildContext context, Object? state) {
              
                List<Widget> pages = [
                ProductScreen(),
                CategoriesScreen(),
                FavouriteScreen(),
                // ProfileScreen()
                // AccountInfoScreen(),
                // Address(),
                // RestPasswordScreen()
                // ProductsScreen(),
                // DemoScreen(),
                // AddCategoryForm()
                // AddProductForm()
                Profile()
              ];
              return CupertinoTabScaffold(
                tabBuilder: ((context, index) {
                  
            return
                Scaffold(
                resizeToAvoidBottomInset: false,
                
                body: SafeArea(child: pages[index]),
              );

                }),

                tabBar: CupertinoTabBar(items: const [
                    BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.apps_sharp), label: "Categories"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite), label: "Favourites"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: "Profile"),
                ]),
                );
            },
            listener: (context, states) {},
          )),
    );
  }

  TextButton buildTextButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        CacheHelper.removeKey(key: "token").then((value) => buildShopToast(
                message: "Logout done Successfully", state: LoginState.success)
            .then((value) => navigateAndReplace(context, LoginScreen())));
      },
      child: const Text("LogOut"),
    );
  }

  
 

}
