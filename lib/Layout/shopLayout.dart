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
import '../Modules/cartpage.dart';
import '../Modules/products.dart';
import '../Modules/profile.dart';
import '../Modules/searchScreen.dart';
import '../Shared/constants.dart';

class ShopLayout extends StatefulWidget {
  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {

 final myKey = new GlobalKey<_ShopLayoutState>();
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
            listener: (context, states) {},
            builder: (BuildContext context, Object? state) {
              var cubit = ShopCubit.get(context);
                List<Widget> pages = [
                ProductScreen(),
                CategoriesScreen(),
                FavouriteScreen(),
                CartPage(),
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
              // int currentIndex = cubit.currenyIndex;
              return CupertinoTabScaffold(
                controller: CupertinoTabController(
                    initialIndex: cubit.currenyIndex),
                tabBar: CupertinoTabBar(
                  onTap: (value) {
                    cubit.changePageIndex(value);
                    print("Tab Cubit current indx: ${cubit.currenyIndex}");
                  },
                  currentIndex: cubit.currenyIndex,
                  items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.apps_sharp), label: "Categories"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite), label: "Favourites"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_cart), label: "Cart"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), label: "Profile"),
                ],
                ),

                tabBuilder: ((context, index) {
                    return
                        Scaffold(
                        resizeToAvoidBottomInset: false,
                        
                        body: SafeArea(child: pages[cubit.currenyIndex]),
                      );
                }
                ),
                );
            },

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
