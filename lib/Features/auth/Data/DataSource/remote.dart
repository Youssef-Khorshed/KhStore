import 'package:dio/dio.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Data/Model/usermodel.dart';
import '../../Domain/Entity/userinfo.dart';

abstract class AuthRemote {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({required UserData userinfo});
}

class AuthRemoteImp extends AuthRemote {
  Dio dio;
  AuthRemoteImp({required this.dio});

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final resopnse = await dio
        .post('${baseUrl}login', data: {"email": email, "password": password});
    if (resopnse.statusCode == 200 || resopnse.data == null) {
      final res = UserModel.fromJson(resopnse.data);
      print(res.data);
      return Future.value(res);
    } else {
      throw AuthException();
    }
  }

  @override
  Future<UserModel> register({required UserData userinfo}) async {
    final resopnse = await dio.post('${baseUrl}register', data: {
      "name": userinfo.name,
      "phone": userinfo.phone,
      "email": userinfo.email,
      "password": userinfo.password,
      "image": userinfo.image
    });
    if (resopnse.statusCode == 200 || resopnse.data == null) {
      final res = UserModel.fromJson(resopnse.data);
      return Future.value(res);
    } else {
      throw AuthException();
    }
  }
}
