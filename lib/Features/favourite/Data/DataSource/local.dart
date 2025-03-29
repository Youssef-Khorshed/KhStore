import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/exception.dart';
import 'package:store/Core/strings.dart';
import 'package:store/Features/favourite/Data/Model/favModel.dart';

abstract class LocalFav {
  Future<Unit> cashfav({required FavModel favdata});
  Future<FavModel> getcashedfav();
}

class LocalFavImp extends LocalFav {
  SharedPreferences sharedPreferences;
  LocalFavImp({required this.sharedPreferences});

  @override
  Future<Unit> cashfav({required FavModel favdata}) {
    sharedPreferences.setString(favitemskey, json.encode(favdata));
    return Future.value(unit);
  }

  @override
  Future<FavModel> getcashedfav() {
    String? resonse = sharedPreferences.getString(favitemskey);
    if (resonse == null) {
      throw CashException();
    } else {
      FavModel items = json.decode(resonse);
      return Future.value(items);
    }
  }

// resueable methods
}
