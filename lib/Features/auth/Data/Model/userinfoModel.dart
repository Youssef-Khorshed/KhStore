import 'package:store/Features/auth/Domain/Entity/userinfo.dart';

class UserinfoModel extends UserData {
  UserinfoModel(
      {required super.email,
      required super.name,
      required super.phone,
      required super.id,
      required super.image,
      required super.password,
      required super.token});

  factory UserinfoModel.fromJson(Map<String, dynamic> json) {
    return UserinfoModel(
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
        id: json['id'],
        password: '',
        image: json['image'],
        token: json['token']);
  }
}
