import 'package:flutter/material.dart';
import '../Modules/CategoriesScreen.dart';
import '../Modules/favouriteScreen.dart';
import '../Modules/productScreen.dart';
import '../Modules/profile.dart';
import '../Shared/constants.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  TabNavigator({required this.navigatorKey, required this.tabItem});

  @override
  Widget build(BuildContext context) {
    Widget child ;
    if(tabItem == "Home") {
      child = Profile();
    } else if(tabItem == "Categories") {
      child = CategoriesScreen();
    } else if(tabItem == "Favourites") {
      child = FavouriteScreen();
    } else {
      child = Profile();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}