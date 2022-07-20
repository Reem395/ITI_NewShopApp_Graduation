import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/ViewModels/constants.dart';
import 'package:shop_app/Views/UserScreens/cartpage.dart';
import 'package:shop_app/Views/UserScreens/profile_screen.dart';
import '../../Demo/testPage.dart';
import '../../Service/firebase_auth_methods.dart';
import '../AdminScreens/AddCategoryForm.dart';
import '../AdminScreens/AddProductForm.dart';
import '../AdminScreens/adminHome_screen.dart';
import '../AdminScreens/adminProfileScreen.dart';
import '../CategoriesScreen/CategoriesScreen.dart';
import '../HomeScreen/home_screen.dart';
import '../UserScreens/LoginScreen.dart';
import '../UserScreens/UserFullInfo.dart';
import '../UserScreens/addAddress_screen.dart';
import '../UserScreens/addressReviewScreen.dart';
import '../UserScreens/orderReview.dart';
import '../WishlistScreen/favouriteScreen.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';

class AdminShopLayout extends StatelessWidget {
  AdminShopLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const AdminHomeScreen(),
      const CategoriesScreen(),
      const AddCategoryForm(),
      const AddProductForm(),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: BlocProvider<ShopCubit>(
          create: (context) {
            return ShopCubit()
              ..getProfileData()
              ..getProducts()
              // ..getFavorites()
              ..getCats();
          },
          child: BlocConsumer<ShopCubit, ShopStates>(
            builder: (BuildContext context, Object? state) {
              return CupertinoTabScaffold(
                controller: CupertinoTabController(
                    initialIndex: ShopCubit.get(context).currentIndex),
                tabBuilder: ((context, index) {
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: SafeArea(
                        child: pages[ShopCubit.get(context).currentIndex]),
                  );
                }),
                tabBar: CupertinoTabBar(
                    // activeColor: Color(0xff00695C),
                    activeColor: Color(0xff00695C),
                    onTap: (index) {
                      ShopCubit.get(context).changeCurrentIndex(index);
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.apps_sharp), label: "Categories"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.add_box_rounded),
                          label: "Add Category"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.add_box_rounded),
                          label: "Add Product"),
                    ]),
              );
            },
            listener: (context, states) {},
          )),
    );
  }
}
