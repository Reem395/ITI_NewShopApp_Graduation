import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Views/UserScreens/profile_screen.dart';
import '../CategoriesScreen/CategoriesScreen.dart';
import '../HomeScreen/home_screen.dart';
import '../WishlistScreen/favouriteScreen.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../../ViewModels/Block/States.dart';

class ShopLayout extends StatelessWidget {
  final List<Widget> pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
    const ProfileScreen()
  ];

  ShopLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<ShopCubit>(
          create: (context) {
            return ShopCubit()
              ..getProfileData()
              ..getProducts()
              ..getFavorites()
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
                    onTap: (index) {
                      ShopCubit.get(context).changeCurrentIndex(index);
                    },
                    items: const [
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
}
