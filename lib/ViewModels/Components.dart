import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Views/UserScreens/LoginScreen.dart';
import '../Views/ProductsScreens/product_details.dart';
import 'Local/CacheHelper.dart';
import 'constants.dart';


Widget defaultTextFormField(
    {@required String? label,
    @required TextEditingController? controller,
    @required String? Function(String?)? validate,
    IconData? prefix,
    IconData? suffix,
    TextInputType? keyboard,
    bool password = false,
    Function()? changePassword,
    Function()? onEditingComplate,
    bool readOnly = false}) {
  return TextFormField(
    keyboardType: keyboard,
    controller: controller,
    validator: validate,
    obscureText: password,
    readOnly: readOnly,
    onEditingComplete: onEditingComplate,
    decoration: InputDecoration(
      fillColor: Colors.grey[200],
      isDense: true,
      label: Text(label!),
      prefixIcon: Icon(prefix),
      suffixIcon: GestureDetector(
        child: Icon(suffix),
        onTap: changePassword,
      ),
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
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
                      *//*IconButton(
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
                          ),*//*
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

//Hadeer
class ProductItem extends StatefulWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

//hadeer
class _ProductItemState extends State<ProductItem> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductDetailsScreen()),
            );
          },
          child: Image.asset(
            'assets/images/girl.png',
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: const Color.fromARGB(221, 78, 82, 87),
          leading: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Colors.red,
            onPressed: () {
              toggleFavoriteStatus();
            },
          ),
          title: const Text(
            "Girls",
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  void toggleFavoriteStatus() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }
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
          icon: const Icon(Icons.search))
    ],
  );
}