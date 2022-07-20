import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Service/firebase_auth_methods.dart';
import '../Views/UserScreens/LoginScreen.dart';
import '../Views/ProductsScreens/product_details.dart';
import 'Local/CacheHelper.dart';
import 'constants.dart';

// FocusNode myFocusNode = FocusNode();
Widget defaultTextFormField(
    {@required String? label,
    @required TextEditingController? controller,
    @required String? Function(String?)? validate,
    // @required Function()? onTap,
    // @required FocusNode? myFocusNode,
    IconData? prefix,
    IconData? suffix,
    TextInputType? keyboard,
    bool password = false,
    double borderRaduis = 0,
    Function()? changePassword,
    Function()? onEditingComplate,
    Color? labelColor,
    bool readOnly = false}) {
  return TextFormField(
    keyboardType: keyboard,
    controller: controller,
    validator: validate,
    obscureText: password,
    readOnly: readOnly,
    onEditingComplete: onEditingComplate,
    // focusNode: myFocusNode,
    cursorColor: defaultColor,
    decoration: InputDecoration(
      fillColor: Colors.grey[200],
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: defaultColor)),
      isDense: true,
      labelText: label,
      //  labelStyle: TextStyle(
      //   color: myFocusNode!.hasFocus ? defaultColor : Colors.grey
      // ),
      prefixIcon: Icon(
        prefix,
        color: defaultColor,
      ),
      suffixIcon: GestureDetector(
        child: Icon(
          suffix,
          color: defaultColor,
        ),
        onTap: changePassword,
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: defaultColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(borderRaduis))),
    ),
    // onTap: onTap,
  );
}

Widget labelField(String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}

Future<bool?> buildShopToast(
    {@required String? message,
    Toast? toastLength,
    @required LoginState? state}) {
  return Fluttertoast.showToast(
      msg: message!,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor(state!),
      textColor: state == LoginState.warning ? Colors.black : Colors.white,
      fontSize: 16.0);
}

enum LoginState { success, fail, warning }

Color toastColor(LoginState state) {
  if (state == LoginState.success) return Colors.green;
  if (state == LoginState.fail) return Colors.red;
  return Colors.yellow;
}

Future<dynamic> navigateTo(BuildContext context, Widget screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

Future<dynamic> navigateAndReplace(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen));
}

/*Widget buildBanner(ShopHomeModel? homeModel) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: CarouselSlider(
      items: homeModel?.data.banners.map((e) {
        return Image(
          image: NetworkImage(e.image),
          fit: BoxFit.cover,
        );
      }).toList(),
      options:
          CarouselOptions(height: 200, autoPlay: true, viewportFraction: 1),
    ),
  );
}*/

//Widget buildCatItem(BuildContext context, int index) {
//   return Row(
//     children: [Image(image: NetworkImage(ShopCubit.get(context).categoryModel!.data.data[index].image),
//       fit: BoxFit.cover,
//       height: 120,
//       width: 120,),
//       const SizedBox(width: 10,),
//       Text(ShopCubit.get(context).categoryModel!.data.data[index].name, style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 17
//       ),),
//       const Spacer(),
//       IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios))
//     ],
//   );
// }

/*ListView buildSearchList(SearchModel model, bool favColor) {
  return ListView.separated(
      itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(6.0),
          color: Colors.white,
          height: 100,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                        // model!.data.data[index].image),
                        model.data.data[index].image),
                    height: 100,
                    width: 120,
                  ),
                  if (model.data.data[index].discount != null)
                    Container(
                      padding: EdgeInsets.all(2),
                      child: const Text(
                        "Discount",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.red.withOpacity(.8),
                    )
                ],
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.data.data[index].name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        model.data.data[index].price.toString(),
                        style: TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.data.data[index].discount != null &&
                          model.data.data[index].discount! > 0)
                        Text(
                          model.data.data[index].oldPrice.toString(),
                          style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      */ /*IconButton(
                            onPressed: () {
                              favColor = !favColor;
                              ShopCubit.get(context).changeFavourites(
                                  model.data.data[index].id);
                            },
                            icon: Icon(
                                ShopCubit.get(context).favouritesProd[
                                model.data.data[index]
                                    .id]!
                                    ? Icons.favorite
                                    : Icons.favorite_outline),
                            color: Colors.red,
                          ),*/ /*
                    ],
                  )
                ],
              )),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
              )
            ],
          )),
      separatorBuilder: (context, index) => Container(
            height: 2,
            color: Colors.grey[200],
          ),
      itemCount: model.data.data.length);
}*/

void navigateToLogin(BuildContext context) {
  CacheHelper.setData(key: "onBoardingOpened", value: true)
      .then((value) => navigateAndReplace(context, LoginScreen()));
}

AppBar ShopSearchAppbar(context) {
  return AppBar(
    backgroundColor: defaultColor,
    title: const Text("ShopApp"),
    actions: [
      IconButton(
          onPressed: () {
            // navigateTo(context, SearchScreen());
          },
          icon: const Icon(Icons.search)),
      IconButton(
          onPressed: () {
            FirebaseAuthMethods(FirebaseAuth.instance)
                .signOut(context)
                .then((value) {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute<bool>(
                  fullscreenDialog: true,
                  builder: (BuildContext context) => LoginScreen(),
                ),
              );
            });
          },
          icon: const Icon(Icons.logout))
    ],
  );
}
