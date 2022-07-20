class OrderModel {
  String? orderId;
  late String userId, orderState;
  late String? state, city, description;
  List<String> prodIds = [];
  OrderModel(
      {this.orderId,
      required this.userId,
      required this.prodIds,
      required this.orderState});

  OrderModel.fromJson(Map<dynamic, dynamic> map) {
    orderId = map['orderId'];
    userId = map['userId'];
    for (var item in map['prodIds']) {
      // print("From Forloop: $item");
      prodIds.add(item);
    }
    orderState = map['orderState'];
  }

  toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'prodIds': prodIds,
      'orderState': orderState
    };
  }
}
