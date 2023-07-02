import 'package:dio/dio.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/auth/Data/Model/usermodel.dart';
import '../../Domain/Entity/userinfo.dart';

abstract class AuthRemote {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({required UserData userinfo});
  Future<UserModel> updateProfile(
      {required UserData userinfo, required String token});
  Future<String> logout({required String token});
  Future<String> forgetpassword({
    required String usertoken,
    required String oldpassword,
    required String newpassword,
  });
}

class AuthRemoteImp extends AuthRemote {
  Dio dio;
  AuthRemoteImp({required this.dio});

  @override
  Future<UserModel> login(
      {required String email, required String password}) async {
    final resopnse = await dio
        .post('${baseUrl}login', data: {"email": email, "password": password});

    // try{}on ApiException catch(){}
    if (resopnse.statusCode == 200 || resopnse.data == null) {
      final res = UserModel.fromJson(resopnse.data);
      // print(res.data);
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

  @override
  Future<String> logout({required String token}) async {
    final resopnse = await dio.post('${baseUrl}logout',
        options: Options(headers: headers(token: token)));
    if (resopnse.statusCode == 200) {
      final res = resopnse.data['message'];
      return Future.value(res);
    } else {
      throw AuthException();
    }
  }

  @override
  Future<UserModel> updateProfile(
      {required UserData userinfo, required String token}) async {
    final resopnse = await dio.put('${baseUrl}update-profile',
        data: {
          "name": userinfo.name,
          "phone": userinfo.phone,
          "email": userinfo.email,
        },
        options: Options(
            headers: headers(token: token), receiveDataWhenStatusError: true));
    if (resopnse.statusCode == 200) {
      final res = UserModel.fromJson(resopnse.data);
      return Future.value(res);
    } else {
      throw AuthException();
    }
  }

  @override
  Future<String> forgetpassword(
      {required String usertoken,
      required String oldpassword,
      required String newpassword}) async {
    final resopnse = await dio.post('${baseUrl}change-password',
        data: {"current_password": oldpassword, "new_password": newpassword},
        options: Options(
            headers: headers(token: usertoken),
            receiveDataWhenStatusError: true));
    if (resopnse.statusCode == 200) {
      final res = resopnse.data['message'];
      return Future.value(res);
    } else {
      throw AuthException();
    }
  }
}
