import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  String? name;
  String? phone;
  String? email;
  int? id;
  String? password;
  String? image;
  String? token;
  UserData(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone,
      required this.id,
      required this.image,
      required this.token});

  @override
  List<Object?> get props => [email, name, phone, id, image, token];
}
