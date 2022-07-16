import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/CategoryModel/ProductCategoryModel.dart';
import '../../Models/ProductModel/ProductModel.dart';
import '../../Models/WishListModel/WishListModel.dart';
import '../Local/CacheHelper.dart';
import '../Network/DioHelper.dart';
import '../constants.dart';
import '../endpoints.dart';
import '../../Models/LoginModel.dart';
import '../Components.dart';
import 'States.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopLLoginInitialState());
  late ShopUserModel? userData;
  late ShopUserModel? userSignUpData;
  Map<int, bool> favouritesProd = {};
  ShopUserModel? getProfile;
  late String LogoutMessage;

  static ShopCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  void userLogin({@required String? email, @required String? password}) {
    emit(ShopLLoginLoadingState());

    DioHelper.postData(
            url: login,
            data: {"email": email, "password": password},
            lang: "en")
        .then((value) {
      userData = ShopUserModel.fromJson(value.data);
      print(userData?.data?.token);
      token = userData?.data?.token;
      emit(ShopLLoginSuccessState(userData!));
    }).catchError((error) {
      print(error);
      emit(ShopLLoginErrorState(error.toString()));
    });
  }

/*  void loadHome() {
    emit(ShopHomeLoadScreen());
    DioHelper.getData(url: home, token: token).then((value) {
      homeData = ShopHomeModel.fromJson(value.data);
      homeData?.data.products.forEach((element) {
        favouritesProd.addAll({element.id: element.inFavorites});
      });
      print(homeData?.status);
      emit(ShopHomeSuccessScreen());
    }).catchError((err) {
      print(err);
      emit(ShopHomeFailScreen());
    });
  }*/

  void getProfileData() {
    emit(ShopLoadingProfileScreen());
    DioHelper.getData(url: profile, token: token).then((value) {
      getProfile = ShopUserModel.fromJson(value.data);
      print(getProfile!.data?.token);
      emit(ShopSuccessProfileScreen());
    }).catchError((err) {
      print(err);
      emit(ShopFailProfileScreen());
    });
  }

  void UpdateUser({String? name, String? phone, String? email}) {
    emit(ShopLoadingUpdateScreen());
    DioHelper.putData(
        url: updateProfile,
        token: token,
        data: {"name": name, "phone": phone, "email": email}).then((value) {
      getProfileData();
      emit(ShopSuccessUpdateScreen());
    }).catchError((onError) {
      emit(ShopFailUpdateScreen());
    });
  }

  void SignUp(
      {@required String? name,
      @required String? phone,
      @required String? email,
      @required String? password}) {
    emit(ShopSignUpLoadingScreen());
    DioHelper.postData(url: register, data: {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password
    }).then((value) {
      userSignUpData = ShopUserModel.fromJson(value.data);
      print(userSignUpData?.status);
      token = userSignUpData?.data?.token;
      emit(ShopSuccessSignUpScreen(userSignUpData!));
    }).catchError((onError) {
      emit(ShopFailSignUpScreen());
      print(onError);
    });
  }

  void LogOut() {
    DioHelper.postData(url: logout, token: token).then((value) {
      LogoutMessage = value.data["message"];
      CacheHelper.removeKey(key: "token");
      buildShopToast(message: LogoutMessage, state: LoginState.success);
      emit(ShopSuccessLogoutScreen());
    }).catchError((onError) {
      emit(ShopFailLogoutScreen());
    });
  }


  //new -------------------------------------------------------------------
  //bottomNavigation
  int currentIndex= 0;
  void changeCurrentIndex(int index)
  {
    currentIndex= index;
    emit(MoveToWishList());
    print(currentIndex);
  }
  //Firebase
  List <ProductCategoryModel> cats=[];
  void getCats()
  {
    FirebaseFirestore.instance.collection("Categories").get().then((value) {
      value.docs.forEach((element) {
        cats.add(ProductCategoryModel.fromJson(element.data()));
      });
    });
  }

  List<ProductModel> products= [];
  Future getProducts() async
  {
    products= [];
    FirebaseFirestore.instance.collection("products").get().then((value) {
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
        favouritesProd.addAll({ProductModel.fromJson(element.data()).productId!: ProductModel.fromJson(element.data()).inFavourites!});
      });
    });
  }

  getProductsTany()
  {
    products.forEach((element) {
      favourites.forEach((fProduct) {
        if(element.productId == fProduct.productId)
        {
          element.inFavourites= true;
          favouritesProd.addAll({element.productId!: element.inFavourites!});
          emit(ShopChangeFavUIScreen());
        }
        return;
      });
    });
  }


  List<WishListModel> favourites= [];
  getFavorites()
  {
    favourites= [];
    FirebaseFirestore.instance.collection("Favourites").get()
        .then((value){
      emit(ShopGetFavSuccessScreen());
      if(value.docs.isNotEmpty)
      {
        value.docs.forEach((element) {
          if(element.data()["userId"]== token)
          {
            favourites.add(WishListModel.fromJson(element.data()));
          }
        });
      }
      getProdFav();
    }).catchError((err){
      emit(ShopGetFavFailScreen());
    });
  }


  var itemId;
  Future addFavourites(ProductModel product) async
  {
    itemId= FirebaseFirestore.instance.collection("Favourites").doc().id;
    return FirebaseFirestore.instance.collection("Favourites").doc(itemId)
        .set({
      "ItemId":itemId,
      "productId":product.productId,
      "userId": token
    });
  }

  Future removeFavourites(ProductModel product) async
  {
    favourites.forEach((element) {
      if(element.productId == product.productId)
      {
        itemId= element.ItemId;
        return;
      }
    });
    FirebaseFirestore.instance.collection("Favourites")
        .doc(itemId).delete();
  }

  bool itemInFavourite= false;
  changeFav(ProductModel product)
  {
    favouritesProd[product.productId!] = !favouritesProd[product.productId!]!;
    emit(ShopChangeFavUIScreen());
    itemInFavourite= false;
    favourites.forEach((element) {
      if(element.productId == product.productId)
      {
        itemInFavourite= true;
        return;
      }
    });
    if(itemInFavourite== false)
    {
      addFavourites(product).then((value){
        itemInFavourite== true;
        emit(ShopChangeFavSuccessScreen());
        getFavorites();
      }).catchError((err){
        emit(ShopChangeFavFailScreen());
        favouritesProd[product.productId!] = !favouritesProd[product.productId!]!;
      });
    }
    else
    {
      removeFavourites(product).then((value) {
        itemInFavourite= false;
        emit(ShopChangeFavSuccessScreen());
        getFavorites();
      }).catchError((err){
        emit(ShopChangeFavFailScreen());
        favouritesProd[product.productId!] = !favouritesProd[product.productId!]!;
      });
    }
  }

  List<ProductModel> prodFav= [];
  getProdFav()
  {
    prodFav=[];
    products.forEach((product) {
      favourites.forEach((favourite) {
        if(product.productId== favourite.productId)
        {
          prodFav.add(product);
          emit(ShopGetFavSuccessScreen());
        }
      });
    });
  }
}
