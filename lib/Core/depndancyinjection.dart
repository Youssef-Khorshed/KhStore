import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/app.dart';
import 'package:store/Core/internet.dart';
import 'package:store/Features/auth/Data/DataSource/local.dart';
import 'package:store/Features/auth/Data/DataSource/remote.dart';
import 'package:store/Features/auth/Data/repoImplement/repo.dart';
import 'package:store/Features/auth/Domain/UseCases/login.dart';
import 'package:store/Features/auth/Domain/UseCases/register.dart';
import 'package:store/Features/auth/Domain/repo/repo.dart';
import 'package:store/Features/product/Data/datasources/remote.dart';
import 'package:store/Features/product/Domain/Repositories/product.dart';
import 'package:store/Features/product/Domain/UseCases/getbanner.dart';
import 'package:store/Features/product/Domain/UseCases/getProducts.dart';
import 'package:store/Features/product/Domain/UseCases/getcategories.dart';
import 'package:store/Features/product/Domain/UseCases/getcategory.dart';
import 'package:store/Features/product/Domain/UseCases/getuserdata.dart';
import '../Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import '../Features/product/Data/datasources/local.dart';
import '../Features/product/Data/repositories/repo.dart';
import '../Features/product/Presentation/Logic/bloc/checkinternetblock/check_internet_bloc_bloc.dart';
import '../Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';

final db = GetIt.instance;

Future<void> init() async {
  //Bloc
  db.registerFactory(() => ProdcutsBloc(
        userDataUsecase: db(),
        getproductUsecase: db(), getBannerUseCase: db(),
        getCategoriesUseCase: db(),
        categoryUseCase: db(),

        // deleteproductUsecase: db(),
        // updateproductUsecase: db()
      ));
  db.registerFactory(() => CheckInternetBlocBloc());
  db.registerFactory(() => AuthBloc(loginUseCase: db(), registerUseCase: db()));

  // UseCases
  // db.registerLazySingleton(() => AddproductUsecase(repo: db()));
  db.registerLazySingleton(() => GetBannerUseCase(repo: db()));
  db.registerLazySingleton(() => GetCategoryUseCase(repo: db()));
  db.registerLazySingleton(() => GetCategoriesUseCase(repo: db()));
  db.registerLazySingleton(() => GetproductUsecase(repo: db()));
  db.registerLazySingleton(() => LoginUseCase(repo: db()));
  db.registerLazySingleton(() => RegisterUseCase(repo: db()));
  db.registerLazySingleton(() => UserDataUsecase(repo: db()));

  //Reposatory
  db.registerLazySingleton<ProductRepo>(() => ProductRepoImp(
      connection: db(), local: db(), remote: db(), localAuth: db()));
  db.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(localAuth: db(), networkInfo: db(), remote: db()));

  // Network
  db.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(db()));

  //DataSource
  db.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImp(sharedPreferences: db()));
  db.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(dio: db()));
  db.registerLazySingleton<LocalAuth>(
      () => LocalAuthImp(sharedPreferences: db()));
  db.registerLazySingleton<AuthRemote>(() => AuthRemoteImp(dio: db()));
  //objects
  final sharedPreferences = await SharedPreferences.getInstance();
  final dio = Dio(BaseOptions());
  final app = MyApp();
  db.registerLazySingleton(() => sharedPreferences);
  db.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  db.registerLazySingleton(() => dio);
  db.registerLazySingleton(() => app);
}
