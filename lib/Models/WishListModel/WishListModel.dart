class WishListModel{

  String? ItemId;
  late String userId;
  late int productId;
  WishListModel({this.ItemId, required this.userId, required this.productId});

  WishListModel.fromJson(Map<dynamic,dynamic>map){
    ItemId = map['ItemId'];
    userId = map['userId'];
    productId = map['productId'];
  }

  toJson(){
    return {
      'categoryId':ItemId,
      'userId':userId,
      'productId':productId
    };
  }
}