class ProductModel {
 late  String? productId ,name,description ,image ,categoryName;
 late int oldPrice,price , noItemsInStock;
 late int? discount;
List<String> prodImages=[];

  ProductModel({this.productId, required this.name,
  required this.oldPrice , required this.price ,
  required this.description,required this.image,
  this.discount , required this.prodImages,
  required this.noItemsInStock ,required this.categoryName});

  ProductModel.fromJson(Map<String, dynamic> map){
    productId = map['productId'];
    name = map['name'];
    oldPrice  = map['oldPrice'];
    price  = map['price'];
    description = map['description'];
    discount = map['discount'];
    image = map['image'];
    // prodImages = map['prodImages'];
    for (var item in map['prodImages']) {
      // print("From Forloop: $item");
      prodImages.add(item);
    }
    noItemsInStock = map ['noItemsInStock'];
    categoryName = map ['categoryName'];
  }

  //If I have an obj and i want to make it a map
  toJson(){
    return {
      'productId':productId,
      'name':name,
      'oldPrice':oldPrice ,
      'price':price ,
      'description':description,
      'discount':discount,
      'image':image,
      'prodImages':prodImages,
      'noItemsInStock':noItemsInStock,
      'categoryName':categoryName
    };
  }

}