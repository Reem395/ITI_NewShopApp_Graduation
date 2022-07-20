import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/Views/UserScreens/MyOrdersScreen.dart';
import 'package:shop_app/Views/UserScreens/addressReviewScreen.dart';
import 'package:shop_app/Views/UserScreens/cartpage.dart';
import '../../Service/firebase_auth_methods.dart';
import '../../ViewModels/Components.dart';
import '../../ViewModels/constants.dart';
import '../../ViewModels/Block/Cubit.dart';
import '../WishlistScreen/favouriteScreen.dart';
import 'LoginScreen.dart';
import 'account_info_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return SafeArea(
            child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const CircleAvatar(
                          radius: 59,
                          backgroundImage: NetworkImage(
                              'https://png.pngtree.com/png-clipart/20220117/original/pngtree-original-cartoon-avatar-girl-png-image_7145782.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              alignment: AlignmentDirectional.center,
                              icon: const Icon(
                                Icons.edit,
                                size: 13,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Full Name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const Text(
                    "Anything Here",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      height: 100,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 3 / 3.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildRow(
                            icon: Icons.person_outline,
                            title: "Account Information",
                            onTap: () {
                              navigateTo(context, const AccountInfoScreen());
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildRow(
                                icon: Icons.location_on_outlined,
                                title: "My Addresses",
                                onTap: () {
                                  navigateTo(
                                      context, const addressReviewScreen());
                                }),
                          ],
                        ),
                        buildRow(
                            icon: Icons.shopping_cart,
                            title: "My Cart",
                            onTap: () {
                              ShopCubit.get(context).changeCurrentIndex(3);
                              navigateTo(context, CartPage());
                            }),
                        buildRow(
                            icon: Icons.shopify,
                            title: "My Orders",
                            onTap: () {
                              navigateTo(context, MyOrdersScreen());
                            }),
                        buildRow(
                            icon: Icons.favorite_outline,
                            title: "My Wishlist",
                            onTap: () {
                              ShopCubit.get(context).changeCurrentIndex(2);
                              navigateTo(context, const FavouriteScreen());
                            }),
                        buildRow(
                            icon: Icons.logout,
                            title: "Logout",
                            onTap: () {
                              FirebaseAuthMethods(FirebaseAuth.instance)
                                  .signOut(context);
                              Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute<bool>(
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) =>
                                      LoginScreen(),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }

  Widget buildRow(
      {@required IconData? icon,
      @required String? title,
      @required Function()? onTap}) {
    return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Icon(
                icon,
                size: 25,
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                title!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height * 0.5100000);
    path0.quadraticBezierTo(size.width * 0.5306250, size.height * 0.9512500,
        size.width, size.height * 0.6050000);
    path0.quadraticBezierTo(size.width * 1.0143750, size.height * 0.5962500,
        size.width, size.height * 0.7350000);
    path0.quadraticBezierTo(size.width * 0.6306250, size.height * 1.1350000, 0,
        size.height * 0.8850000);
    path0.quadraticBezierTo(size.width * -0.0068750, size.height * 0.8975000, 0,
        size.height * 0.5100000);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
