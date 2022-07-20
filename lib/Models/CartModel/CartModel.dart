class CartModel{

  String? ItemId;
  late String userId;
  late int productId;
  late int NoProductsInCart;
  CartModel({this.ItemId, required this.userId,
   required this.productId, required this.NoProductsInCart});

  CartModel.fromJson(Map<dynamic,dynamic>map){
    ItemId = map['ItemId'];
    userId = map['userId'];
    productId = map['productId'];
    NoProductsInCart = map['NoProductsInCart'];
  }

  toJson(){
    return {
      'ItemId':ItemId,
      'userId':userId,
      'productId':productId,
      'NoProductsInCart':NoProductsInCart
    };
  }
}