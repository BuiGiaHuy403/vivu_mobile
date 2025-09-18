

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vivu_mobile/feature/auth/data/auth_service.dart';

import '../../feature/auth/data/auth_repository.dart';
import '../../feature/auth/domain/login_cubit.dart';
import '../../feature/auth/domain/register_cubit.dart';
import '../network/api_client.dart';

final GetIt locator = GetIt.instance;

void setup(){
  // locator.registerLazySingleton<TypeController>(() => TypeController());

  //configure dependencies
  locator.registerLazySingleton<Dio>(() => ApiClient.dio);

  //services
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository(locator<Dio>()));
  locator.registerLazySingleton<AuthService>(() => AuthService(locator<AuthRepository>()));


  //cubit
  locator.registerFactory(() => RegisterCubit(service: locator<AuthService>()));
  locator.registerFactory(() => LoginCubit(service: locator<AuthService>()));
}