class ProductCategoryModel{

  int? categoryId;
  late String name, image;
  ProductCategoryModel({this.categoryId, required this.name, required this.image});

  ProductCategoryModel.fromJson(Map<dynamic,dynamic>map){
    categoryId = map['categoryId'];
    name = map['name'];
    image = map['image'];
  }

  toJson(){
    return {
      'categoryId':categoryId,
      'name':name,
      'image':image
    };
  }
}