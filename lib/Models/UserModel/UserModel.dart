class UserModel {
  late String? name, email, password, phone;
  late String? state, city, description;

  late String userId;

  UserModel(
      {required this.userId,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.state,
      this.city,
      this.description});

  UserModel.fromJson(Map<String, dynamic> map) {
    userId = map['userId'];
    name = map['name'];
    email = map['email'];
    password = map['password'];
    phone = map['phone'];
    state = map['state'];
    city = map['city'];
    description = map['description'];
  }

  //If I have an obj and i want to make it a map
  toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'state': state,
      'city': city,
      'description': description,
    };
  }
}
