import '../../Models/UserModel/UserModel.dart';

abstract class ShopStates{}

class ShopLInitState extends ShopStates{}
class ShopLLoginLoadingState extends ShopStates{}
class ShopLLoginSuccessState extends ShopStates{
  ShopLLoginSuccessState();
}

class ShopLLoginErrorState extends ShopStates{
  final String error;
  ShopLLoginErrorState(this.error);
}

class ShopHomeLoadScreen extends ShopStates{}
class ShopHomeSuccessScreen extends ShopStates{}
class ShopHomeFailScreen extends ShopStates{}

class ShopSearchLoadScreen extends ShopStates{}
class ShopSearchSuccessScreen extends ShopStates{}

class ShopUpdateUserLoadingScreen extends ShopStates{}
class ShopUpdateUserSuccessScreen extends ShopStates{}
class ShopUpdateUserFailScreen extends ShopStates{}

class ShopSearchFailScreen extends ShopStates{}
class ShopCatSuccessScreen extends ShopStates{}
class ShopCatFailScreen extends ShopStates{}

class ShopChangeFavUIScreen extends ShopStates{}
class ShopChangeFavSuccessScreen extends ShopStates{}
class ShopChangeFavFailScreen extends ShopStates{}

class ShopLoadingFavScreen extends ShopStates{}
class ShopGetFavSuccessScreen extends ShopStates{}
class ShopGetFavFailScreen extends ShopStates{}

class ShopLoadingProfileScreen extends ShopStates{}
class ShopSuccessProfileScreen extends ShopStates{}
class ShopFailProfileScreen extends ShopStates{}

class ShopSuccessLogoutScreen extends ShopStates{}
class ShopFailLogoutScreen extends ShopStates{}

class ShopLoadingUpdateScreen extends ShopStates{}
class ShopSuccessUpdateScreen extends ShopStates{}
class ShopFailUpdateScreen extends ShopStates{}

class ShopSignUpLoadingScreen extends ShopStates{}

class ShopSuccessSignUpScreen extends ShopStates{
  final UserModel userSignData;
  ShopSuccessSignUpScreen(this.userSignData);
}
class ShopFailSignUpScreen extends ShopStates{}

class MoveToWishList extends ShopStates{}

class GetProductsLoading extends ShopStates{}
class GetProductsSuccess extends ShopStates{}
class GetProductsError extends ShopStates{}

class GetCategoriesLoading extends ShopStates{}
class GetCategoriesSuccess extends ShopStates{}
class GetCategoriesError extends ShopStates{}

class GetCategoriesProductsLoading extends ShopStates{}
class GetCategoriesProductsSuccess extends ShopStates{}

class ShopChangeCartUIScreen extends ShopStates{}
class ShopChangeCartSuccessScreen extends ShopStates{}
class ShopChangeCartFailScreen extends ShopStates{}

class ShopCartLoadingScreen extends ShopStates{}
class ShopGetCartSuccessScreen extends ShopStates{}
class ShopGetCartFailScreen extends ShopStates{}

class ShopUpdateCartPrice extends ShopStates{}