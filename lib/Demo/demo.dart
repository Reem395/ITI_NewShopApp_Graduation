import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Views/HomeScreen/home_screen.dart';
import '../ViewModels/Block/Cubit.dart';
import '../ViewModels/Block/States.dart';
import '../ViewModels/Local/CacheHelper.dart';
import '../Views/CategoriesScreen/CategoriesScreen.dart';
import '../Views/UserScreens/LoginScreen.dart';
import '../Views/UserScreens/account_info_screen.dart';
import '../Views/WishlistScreen/favouriteScreen.dart';
import '../ViewModels/Components.dart';
import '../Views/SearchScreen/searchScreen.dart';
import '../ViewModels/constants.dart';

class Layout extends StatefulWidget {
  @override
  State<Layout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<Layout> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:BlocProvider<ShopCubit>(
          create: (context) {
            return ShopCubit();
          },
          child: BlocConsumer<ShopCubit, ShopStates>(
            builder: (BuildContext context, Object? state) {
              List<Widget> pages = [
                HomeScreen(),
                CategoriesScreen(),
                FavouriteScreen(),
                // ProfileScreen()
                AccountInfoScreen(),
                // Address(),
                // RestPasswordScreen()
                // ProductsScreen(),
              ];
              return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: defaultColor,
                  title: const Text("ShopApp"),
                  actions: [
                    IconButton(
                        onPressed: () {
                        //  navigateTo(context, SearchScreen());
                        },
                        icon: const Icon(Icons.search))
                  ],
                ),
                body: SafeArea(child: pages[currentIndex]),
                bottomNavigationBar: BottomNavigationBar(
                  selectedItemColor: defaultColor,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.apps_sharp), label: "Categories"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: "Favourites"),
                    BottomNavigationBarItem(
                        // icon: Icon(Icons.settings), label: "Setting"),
                        icon: Icon(Icons.person), label: "Profile"),
                  ],
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                      print(currentIndex);
                    });
                  },
                ),
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
