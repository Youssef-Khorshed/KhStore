import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/internet.dart';
import 'package:store/Data/datasources/remote.dart';
import 'package:store/Domain/Repositories/product.dart';
import 'package:store/Domain/UseCases/addproduct.dart';
import 'package:store/Domain/UseCases/deleteproduct.dart';
import 'package:store/Domain/UseCases/getProducts.dart';
import 'package:store/Domain/UseCases/updateproduct.dart';
import 'package:store/Presentation/Logic/bloc/check_internet_bloc_bloc.dart';
import '../Data/datasources/local.dart';
import '../Data/repositories/repo.dart';
import '../Presentation/Logic/bloc/prodcuts_bloc.dart';

final db = GetIt.instance;

Future<void> init() async {
  //Bloc
  db.registerFactory(() => ProdcutsBloc(
      addproductUsecase: db(),
      deleteproductUsecase: db(),
      getproductUsecase: db(),
      updateproductUsecase: db()));
  db.registerFactory(() => CheckInternetBlocBloc());

  // UseCases
  db.registerLazySingleton(() => AddproductUsecase(repo: db()));
  db.registerLazySingleton(() => UpdateproductUsecase(repo: db()));
  db.registerLazySingleton(() => DeleteproductUsecase(repo: db()));
  db.registerLazySingleton(() => GetproductUsecase(repo: db()));

  //Reposatory
  db.registerLazySingleton<ProductRepo>(
      () => ProductRepoImp(connection: db(), local: db(), remote: db()));

  // Network

  db.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(db()));

  //DataSource
  db.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImp(sharedPreferences: db()));
  db.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(dio: Dio(BaseOptions())));

  //SharedPrefrences
  final sharedPreferences = await SharedPreferences.getInstance();
  db.registerLazySingleton(() => sharedPreferences);
  db.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
