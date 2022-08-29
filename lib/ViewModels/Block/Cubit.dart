import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/CartModel/CartModel.dart';
import 'package:shop_app/Models/UserModel/UserModel.dart';
import '../../Models/CategoryModel/ProductCategoryModel.dart';
import '../../Models/ProductModel/ProductModel.dart';
import '../../Models/WishListModel/WishListModel.dart';
import '../constants.dart';
import 'States.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopLInitState());
  Map<int, bool> favouritesProd = {};
  Map<int, bool> cartProd = {};
  Map<int, int> cartProdCount = {};

  static ShopCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  //new -------------------------------------------------------------------
  //bottomNavigation
  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(MoveToWishList());
    print(currentIndex);
  }

  //Firebase
  List<ProductCategoryModel> cats = [];

  void getCats() {
    emit(GetCategoriesLoading());
    FirebaseFirestore.instance.collection("Categories").get().then((value) {
      value.docs.forEach((element) {
        cats.add(ProductCategoryModel.fromJson(element.data()));
      });
    }).then((value) {
      emit(GetCategoriesSuccess());
    }).catchError((err) {
      emit(GetCategoriesError());
    });
  }

  List<ProductModel> products = [];

  Future getProducts() async {
    emit(GetProductsLoading());
    products = [];
    FirebaseFirestore.instance.collection("products").get().then((value) {
      value.docs.forEach((element) {
        var product = ProductModel.fromJson(element.data());
        products.add(product);
        favouritesProd.addAll({product.productId!: product.inFavourites!});
        cartProd.addAll({product.productId!: product.inCart!});
        cartProdCount.addAll({product.productId!: 0});
      });
    }).then((value) {
      emit(GetProductsSuccess());
    }).catchError((err) {
      emit(GetProductsError());
      print(err);
    });
  }

  getProductsTany() {
    products.forEach((element) {
      favourites.forEach((fProduct) {
        if (element.productId == fProduct.productId) {
          element.inFavourites = true;
          favouritesProd.addAll({element.productId!: element.inFavourites!});
          emit(ShopChangeFavUIScreen());
        }
        return;
      });

      carts.forEach((cProduct) {
        if (element.productId == cProduct.productId) {
          element.inCart = true;
          cartProd.addAll({element.productId!: element.inCart!});
          emit(ShopChangeFavUIScreen());
        }
        return;
      });
    });
  }

  List<WishListModel> favourites = [];

  getFavorites() {
    favourites = [];
    FirebaseFirestore.instance.collection("Favourites").get().then((value) {
      canChangeFav = true;
      emit(ShopGetFavSuccessScreen());
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          if (element.data()["userId"] == uId) {
            favourites.add(WishListModel.fromJson(element.data()));
          }
        });
      }
      getProdFav();
    }).catchError((err) {
      emit(ShopGetFavFailScreen());
    });
  }

  var itemId;
  bool canChangeFav = false;

  Future addFavourites(ProductModel product) async {
    itemId = FirebaseFirestore.instance.collection("Favourites").doc().id;
    return FirebaseFirestore.instance.collection("Favourites").doc(itemId).set(
        {"ItemId": itemId, "productId": product.productId, "userId": uId});
  }

  Future removeFavourites(ProductModel product) async {
    favourites.forEach((element) {
      if (element.productId == product.productId) {
        itemId = element.ItemId;
        return;
      }
    });
    FirebaseFirestore.instance.collection("Favourites").doc(itemId).delete();
  }

  bool itemInFavourite = false;

  changeFav(ProductModel product) {
    canChangeFav = false;
    favouritesProd[product.productId!] = !favouritesProd[product.productId!]!;
    emit(ShopChangeFavUIScreen());
    itemInFavourite = false;
    favourites.forEach((element) {
      if (element.productId == product.productId) {
        itemInFavourite = true;
        return;
      }
    });
    if (itemInFavourite == false) {
      addFavourites(product).then((value) {
        itemInFavourite == true;
        emit(ShopChangeFavSuccessScreen());
        getFavorites();
      }).catchError((err) {
        emit(ShopChangeFavFailScreen());
        favouritesProd[product.productId!] =
            !favouritesProd[product.productId!]!;
      });
    } else {
      removeFavourites(product).then((value) {
        itemInFavourite = false;
        emit(ShopChangeFavSuccessScreen());
        getFavorites();
      }).catchError((err) {
        emit(ShopChangeFavFailScreen());
        favouritesProd[product.productId!] =
            !favouritesProd[product.productId!]!;
      });
    }
  }

  List<ProductModel> prodFav = [];

  getProdFav() {
    prodFav = [];
    products.forEach((product) {
      favourites.forEach((favourite) {
        if (product.productId == favourite.productId) {
          prodFav.add(product);
        }
      });
    });
    emit(ShopGetFavSuccessScreen());
  }

  //get Product Per Cat
  Map<String, List<ProductModel>> categoriesProducts = {};

  void getProductsPerCat() {
    cats.forEach((category) {
      categoriesProducts[category.name] = [];
      products.forEach((product) {
        if (category.name == product.categoryName) {
          categoriesProducts[category.name]?.add(product);
        }
      });
    });
  }

  //add To Cart
  List<CartModel> carts = [];

  getCart() {
    emit(ShopCartLoadingScreen());
    carts = [];
    FirebaseFirestore.instance.collection("Carts").get().then((value) {
      emit(ShopGetCartSuccessScreen());
      print("uId========");
      print(uId);
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          print("uId========");
          print(uId);
          if (element.data()["userId"] == uId) {
            carts.add(CartModel.fromJson(element.data()));
          }
        });
        print("carts.length");
        print(carts.length);
      }
      getCartProducts();
      print(canChangeCart);
    }).catchError((err) {
      emit(ShopGetCartFailScreen());
    });
  }

  var cartItemId;
  bool canChangeCart = false;

  Future addToCart(ProductModel product, {bool first = false}) async {
    int count = 0;
    itemId = FirebaseFirestore.instance.collection("Carts").doc().id;
    if (first == false) {
      carts.forEach((element) {
        if (element.productId == product.productId) {
          count = element.NoProductsInCart;
          itemId = element.ItemId;
          return;
        }
      });
    }

    if (count == 0) {
      cartProd[product.productId!] = !cartProd[product.productId!]!;
      return FirebaseFirestore.instance.collection("Carts").doc(itemId).set({
        "ItemId": itemId,
        "productId": product.productId,
        "userId": uId,
        "NoProductsInCart": ++count
      }).then((value) {
        getProduct(product.productId!).then((value) {
          // addProduct(product);
          getCart();
        });
      });
    } else {
      return FirebaseFirestore.instance.collection("Carts").doc(itemId).update({
        "ItemId": itemId,
        "productId": product.productId,
        "userId": uId,
        "NoProductsInCart": ++count
      }).then((value) {
        getProduct(product.productId!).then((value){
          // addProduct(product);
          getCart();
        });
      });
    }
  }

  Future removeFromCart(ProductModel product, {bool all = false}) async {
    int count = 1;
    carts.forEach((element) {
      if (element.productId == product.productId) {
        itemId = element.ItemId;
        count = element.NoProductsInCart;
        return;
      }
    });

    if (count > 0) {
      if (count == 1 || all == true) {
        cartProd[product.productId!] = !cartProd[product.productId!]!;
        FirebaseFirestore.instance
            .collection("Carts")
            .doc(itemId).get().then((value) {
              count= value.data()!["NoProductsInCart"];
          FirebaseFirestore.instance
              .collection("Carts")
              .doc(itemId)
              .delete()
              .then((value) {
            getProduct(product.productId!).then((value){
              // removeAllProduct(product, count);
              getCart();
              itemInCart = false;
            });
          });
        });
      } else {
        return FirebaseFirestore.instance
            .collection("Carts")
            .doc(itemId)
            .update({
          "ItemId": itemId,
          "productId": product.productId,
          "userId": uId,
          "NoProductsInCart": --count
        }).then((value) {
          getProduct(product.productId!).then((value){
            // removeProduct(product);
            getCart();
            itemInCart = true;
          });
        });
      }
    }
  }

  bool itemInCart = false;

  changeCart(ProductModel product, {bool remove = false}) {
    itemInCart = false;
    canChangeCart = false;
    emit(ShopChangeCartUIScreen());
    carts.forEach((element) {
      if (element.productId == product.productId) {
        itemInCart = true;
        return;
      }
    });
    if (itemInCart == false) {
      addToCart(product, first: true).then((value) {
        itemInCart == true;
        emit(ShopChangeCartSuccessScreen());
      }).catchError((err) {
        emit(ShopChangeCartFailScreen());
        cartProd[product.productId!] = !cartProd[product.productId!]!;
      });
    } else {
      removeFromCart(product, all: true).then((value) {
        emit(ShopChangeFavSuccessScreen());
      }).catchError((err) {
        emit(ShopChangeCartFailScreen());
        cartProd[product.productId!] = !cartProd[product.productId!]!;
      });
    }
  }

  List<ProductModel> cartProducts = [];

  getCartProducts() {
    cartProducts = [];
    products.forEach((product) {
      carts.forEach((cartProduct) {
        if (product.productId == cartProduct.productId) {
          cartProducts.add(product);
          cartProdCount[product.productId!] = cartProduct.NoProductsInCart;
        }
      });
    });
    canChangeCart = true;
    emit(ShopGetCartSuccessScreen());
    getCartPrice(cartProducts);
  }

  bool productExist(ProductModel product) {
    if (product.noItemsInStock == cartProdCount[product.productId]) {
      return false;
    }
    return true;
  }

  dynamic cartProdPrice = 0;

  void getCartPrice(List<ProductModel> products) {
    cartProdPrice = 0;
    products.forEach((element) {
      carts.forEach((cElement) {
        if (element.productId == cElement.productId) {
          cartProdPrice += element.price * cElement.NoProductsInCart;
        }
      });
    });
  }

  //users
  UserModel? user;
  void Register({
    @required String? email,
    @required String? password,
    @required String? name,
    @required String? phone,
  }) {
    emit(ShopSignUpLoadingScreen());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      CreateUser(
        email: email,
        password: password,
        name: name,
        phone: phone,
        uId: value.user?.uid,
      );
      uId= value.user?.uid;
      print(uId);
      getUser();
       emit(ShopSuccessSignUpScreen(user!));
    }).catchError((err) {
      print(err);
      emit(ShopFailSignUpScreen());
    });
  }

  void CreateUser({
    @required String? email,
    @required String? password,
    @required String? name,
    @required String? phone,
    @required String? uId,
  }) {
    user = UserModel(
        name: name,
        email: email,
        phone: phone!,
        password: password,
        userId: uId!);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(user!.toJson())
        .then((value) {})
        .catchError((err) {
      print(err);
    });
  }

  void signIn({@required email, @required password}) {
    emit(ShopLLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId= value.user?.uid;
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'+uId!);
      emit(ShopLLoginSuccessState());
    }).catchError((err) {
      emit(ShopLLoginErrorState(err.toString()));
      print(err);
    });
  }


  void getUser() {
    emit(ShopGetUserLoading());
   /* FirebaseFirestore.instance.collection("Users").doc(uId).get().then((value) {
      if (value.data() != null) {
        user = UserModel.fromJson(value.data()!);
        print(user);
      }*/

    FirebaseFirestore.instance
        .collection('Users')
        .where('userId', isEqualTo: uId)
        .snapshots()
        .listen((data) {
      if (data.docs.isNotEmpty) {
        print("data.docs.first");
        print(uId);
        user= UserModel(userId: uId!, name: data.docs.first["name"],
            phone: data.docs.first["phone"], password: data.docs.first["password"], email: data.docs.first["email"] );
        print(data.docs.first["name"]);
        print(user?.name);
      }
    });
      /*emit(ShopGetUserSuccess());
      print(value.data());
    }).catchError((err) {
      print(err);
      emit(ShopGetUserFail());
    });*/
  }

  //cart
  removeProduct(ProductModel product)
  {
    FirebaseFirestore.instance.collection("products").doc(prodctDocId).update({
      "productId":product.productId,
      'name':product.name,
      'oldPrice': product.oldPrice,
      'price': product.price,
      'description': product.description,
      'discount': product.discount,
      'image': product.image,
      'prodImages': product.prodImages,
      'categoryName': product.categoryName,
      "noItemsInStock": product.noItemsInStock +1
    });
    print(prodctDocId);
  }
  addProduct(ProductModel product)
  {
  FirebaseFirestore.instance.collection("products").doc(prodctDocId).update({
      "productId":product.productId,
      'name':product.name,
      'oldPrice': product.oldPrice,
      'price': product.price,
      'description': product.description,
      'discount': product.discount,
      'image': product.image,
      'prodImages': product.prodImages,
      'categoryName': product.categoryName,
      "noItemsInStock": product.noItemsInStock -1
    });
  }
  removeAllProduct(ProductModel product, int count)
  {
    FirebaseFirestore.instance.collection("products").doc(prodctDocId).update({
      "productId":product.productId,
      'name':product.name,
      'oldPrice': product.oldPrice,
      'price': product.price,
      'description': product.description,
      'discount': product.discount,
      'image': product.image,
      'prodImages': product.prodImages,
      'categoryName': product.categoryName,
      'noItemsInStock': product.noItemsInStock+ count
    });
  }
  var prodctDocId;
  Future getProduct(int productId) async
  {
    return FirebaseFirestore.instance.collection("products").
    where("productId", isEqualTo: productId ).snapshots()
        .listen((data) => data.docs.forEach((element) {prodctDocId = element.id; print(productId);}));
  }

  void upDateUser({@required name, @required phone,  password,primaryState,primaryCity,primaryaddressDetails}) {
    user?.name= name;
    user?.phone= phone;
    user?.password= password;
    user?.city =primaryCity.toString();
    user?.state =primaryState.toString();
    user?.description =primaryaddressDetails.toString();
    print("from cubit: $primaryCity");
    emit(ShopUpdateUserLoadingScreen());
    FirebaseFirestore.instance.collection('Users')
        .where('userId', isEqualTo: uId)
        .snapshots()
        .listen((data) {
    if (data.docs.isNotEmpty) {
      FirebaseFirestore.instance.collection("Users").doc(data.docs.first.id).update(
{
      'name': name,
      'password': password,
      'phone': phone,
      'state': state.toString(),
      'city': primaryCity.toString(),
      'description': primaryaddressDetails.toString(),
}
      )
          .then((value) {
      emit(ShopUpdateUserSuccessScreen());
      }
      ).catchError((err) {
      print(err);
      emit(ShopUpdateUserFailScreen());
    });
    }
    });
  }

  List<ProductModel> searchList= [];
  searchProduct(String searchWord)
  {
    emit(ShopSearchLoadScreen());
  searchList= products.where((element) =>
     element.name!.contains(searchWord)).toList();
     emit(ShopSearchSuccessScreen());
  print("searchList.length");
  print(searchList.length);
  }
}
