import 'package:equatable/equatable.dart';
import 'package:store/Features/auth/Domain/Entity/userinfo.dart';

// ignore: must_be_immutable
class UserEntiy extends Equatable {
  bool? status;
  String? message;
  UserData? data;
  UserEntiy({required this.data, required this.message, required this.status});

  @override
  List<Object?> get props => [data, message, status];
}




// ignore: must_be_immutable
