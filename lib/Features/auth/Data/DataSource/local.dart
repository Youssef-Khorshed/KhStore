import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';

abstract class LocalAuth {
  Future<Unit> cashpassword({required String password});
  Future<String> getcashedpassword();
  Future<Unit> cashtoken({required String tokenvalue});
  Future<String> getcashedtoken();
}

class LocalAuthImp extends LocalAuth {
  SharedPreferences sharedPreferences;
  LocalAuthImp({required this.sharedPreferences});

  @override
  Future<Unit> cashpassword({required String password}) async {
    return cash_item(value: password, key: userpasswrordkey);
  }

  @override
  Future<String> getcashedpassword() {
    return cahsed_item(key: userpasswrordkey);
  }

  @override
  Future<Unit> cashtoken({required String tokenvalue}) {
    return cash_item(key: usertokenkey, value: tokenvalue);
  }

  @override
  Future<String> getcashedtoken() {
    return cahsed_item(key: usertokenkey);
  }

// resueable methods
  Future<Unit> cash_item({required String key, required String value}) async {
    sharedPreferences.setString(key, value);
    return Future.value(unit);
  }

  Future<String> cahsed_item({required String key}) {
    String? resonse = sharedPreferences.getString(key);
    if (resonse == null) {
      throw CashException();
    } else {
      return Future.value(resonse);
    }
  }
}
