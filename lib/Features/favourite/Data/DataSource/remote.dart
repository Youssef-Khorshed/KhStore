import 'package:dio/dio.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/favourite/Data/Model/favModel.dart';

abstract class RemoteFav {
  Future<FavModel> getfav({required String token});
  Future<String> addfav({required int productid, required String token});
}

class RemoteFavImp extends RemoteFav {
  Dio dio;
  RemoteFavImp({required this.dio});

  @override
  Future<String> addfav({required int productid, required String token}) async {
    final resopnse = await dio.post('${baseUrl}favorites',
        options: Options(headers: headers(token: token)),
        data: {"product_id": productid});
    if (resopnse.statusCode == 200 || resopnse.data == null) {
      final res = resopnse.data['message'];
      return Future.value(res);
    } else {
      throw AuthException();
    }
  }

  @override
  Future<FavModel> getfav({required String token}) async {
    final resopnse = await dio.get('${baseUrl}favorites',
        options: Options(headers: headers(token: token)));

    if (resopnse.statusCode == 200 || resopnse.data == null) {
      final res = FavModel.fromJson(resopnse.data);
      return Future.value(res);
    } else {
      throw AuthException();
    }
  }
}
