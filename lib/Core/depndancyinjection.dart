import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/Core/internet.dart';
import 'package:store/Core/theme/theme_cubit.dart';
import 'package:store/Features/auth/Data/DataSource/local.dart';
import 'package:store/Features/auth/Data/DataSource/remote.dart';
import 'package:store/Features/auth/Data/repoImplement/repo.dart';
import 'package:store/Features/auth/Domain/UseCases/forgetpassword.dart';
import 'package:store/Features/auth/Domain/UseCases/login.dart';
import 'package:store/Features/auth/Domain/UseCases/logout.dart';
import 'package:store/Features/auth/Domain/UseCases/register.dart';
import 'package:store/Features/auth/Domain/UseCases/updateprofile.dart';
import 'package:store/Features/auth/Domain/repo/repo.dart';
import 'package:store/Features/cart/data/datasource/local.dart';
import 'package:store/Features/cart/data/datasource/remote.dart';
import 'package:store/Features/cart/data/repoImp/repoImp.dart';
import 'package:store/Features/cart/domain/repo/repo.dart';
import 'package:store/Features/cart/domain/usecase/addcart.dart';
import 'package:store/Features/cart/domain/usecase/removecart.dart';
import 'package:store/Features/cart/presentation/logic/bloc/cart_bloc.dart';
import 'package:store/Features/favourite/Data/DataSource/local.dart';
import 'package:store/Features/favourite/Data/DataSource/remote.dart';
import 'package:store/Features/favourite/Data/repoImplement/repo.dart';
import 'package:store/Features/favourite/domain/repo/repo.dart';
import 'package:store/Features/favourite/domain/usecase/addfav.dart';
import 'package:store/Features/favourite/domain/usecase/getfav.dart';
import 'package:store/Features/favourite/presentation/logic/bloc/fav_bloc.dart';
import 'package:store/Features/product/Data/datasources/remote.dart';
import 'package:store/Features/product/Domain/Repositories/product.dart';
import 'package:store/Features/product/Domain/UseCases/getbanner.dart';
import 'package:store/Features/product/Domain/UseCases/getProducts.dart';
import 'package:store/Features/product/Domain/UseCases/getcategories.dart';
import 'package:store/Features/product/Domain/UseCases/getcategory.dart';
import 'package:store/Features/product/Domain/UseCases/getuserdata.dart';
import '../Features/auth/Presentation/Logic/bloc/auth_bloc.dart';
import '../Features/cart/domain/usecase/getcart.dart';
import '../Features/cart/domain/usecase/updatecart.dart';
import '../Features/product/Data/datasources/local.dart';
import '../Features/product/Data/repositories/repo.dart';
import '../Features/product/Presentation/Logic/bloc/productBloc/prodcuts_bloc.dart';

final db = GetIt.instance;

Future<void> init() async {
  //Blocs

  //Product Bloc
  db.registerFactory(() => ProdcutsBloc(
        userDataUsecase: db(),
        getproductUsecase: db(),
        getBannerUseCase: db(),
        getCategoriesUseCase: db(),
        categoryUseCase: db(),
      ));
  // Favourite Bloc
  db.registerFactory(() => FavBloc(addTofavUsecase: db(), getFavUseCase: db()));
  // theme Bloc
  db.registerFactory(() => ThemeCubit());
  // Auth Bloc
  db.registerFactory(() => AuthBloc(
      loginUseCase: db(),
      registerUseCase: db(),
      forgetPasswordUseCase: db(),
      logoutUseCase: db(),
      updateProfileUseCase: db()));
  //cart Bloc
  db.registerFactory(() => CartBloc(
      addToCartUsecase: db(),
      getCartUseCase: db(),
      removeFromCartUsecase: db(),
      updateCartUsecase: db()));

  // UseCases
  // db.registerLazySingleton(() => AddproductUsecase(repo: db()));
  db.registerLazySingleton(() => GetBannerUseCase(repo: db()));
  db.registerLazySingleton(() => GetCategoryUseCase(repo: db()));
  db.registerLazySingleton(() => GetCategoriesUseCase(repo: db()));
  db.registerLazySingleton(() => GetproductUsecase(repo: db()));
  db.registerLazySingleton(() => LoginUseCase(repo: db()));
  db.registerLazySingleton(() => RegisterUseCase(repo: db()));
  db.registerLazySingleton(() => UserDataUsecase(repo: db()));
  db.registerLazySingleton(() => GetCartUseCase(repo: db()));
  db.registerLazySingleton(() => UpdateCartUsecase(repo: db()));
  db.registerLazySingleton(() => RemoveFromCartUsecase(repo: db()));
  db.registerLazySingleton(() => AddToCartUsecase(repo: db()));
  db.registerLazySingleton(() => AddTofavUsecase(repo: db()));
  db.registerLazySingleton(() => GetFavUseCase(repo: db()));
  db.registerLazySingleton(() => UpdateProfileUseCase(repo: db()));
  db.registerLazySingleton(() => LogoutUseCase(repo: db()));
  db.registerLazySingleton(() => ForgetPasswordUseCase(repo: db()));

  //Reposatory
  db.registerLazySingleton<ProductRepo>(() => ProductRepoImp(
      connection: db(), local: db(), remote: db(), localAuth: db()));
  db.registerLazySingleton<AuthRepo>(
      () => AuthRepoImp(localAuth: db(), networkInfo: db(), remote: db()));
  db.registerLazySingleton<CartRepo>(() => CartRepoImp(
      localAuth: db(), connection: db(), cartRemote: db(), cartLocal: db()));
  db.registerLazySingleton<FavRepo>(() => FavRepoImp(
      networkInfo: db(), localFav: db(), localAuth: db(), remoteFav: db()));
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
  db.registerLazySingleton<CartLocal>(
      () => CartLocalImp(sharedPreferences: db()));
  db.registerLazySingleton<CartRemote>(() => CartRemoteImp(dio: db()));
  db.registerLazySingleton<RemoteFav>(() => RemoteFavImp(dio: db()));
  db.registerLazySingleton<LocalFav>(
      () => LocalFavImp(sharedPreferences: db()));

  final sharedPreferences = await SharedPreferences.getInstance();

  final dio = Dio(BaseOptions());

  db.registerLazySingleton(() => sharedPreferences);
  db.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  db.registerLazySingleton(() => dio);
  db.registerLazySingleton(() => Widget);
  // db.registerLazySingleton(() => MyApp(
  //       nextwidget: db(),
  //     ));
}
