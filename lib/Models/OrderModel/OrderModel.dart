class OrderModel{

  String? orderId ;
  late String userId,state;
  List<String> prodIds=[];
  OrderModel({this.orderId, required this.userId,
   required this.prodIds,required this.state});

  OrderModel.fromJson(Map<dynamic,dynamic>map){
    orderId = map['orderId'];
    userId = map['userId'];
    for (var item in map['prodIds']) {
      // print("From Forloop: $item");
      prodIds.add(item);
    }
    state = map['state'];
  }

  toJson(){
    return {
      'orderId':orderId,
      'userId':userId,
      'prodIds':prodIds,
      'state':state    };
  }
}