import 'package:store/Features/auth/Data/Model/userinfoModel.dart';
import 'package:store/Features/auth/Domain/Entity/user.dart';

class UserModel extends UserEntiy {
  UserModel(
      {required super.data, required super.message, required super.status});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        data: UserinfoModel.fromJson(json['data']),
        message: json['message'],
        status: json['status']);
  }
}
