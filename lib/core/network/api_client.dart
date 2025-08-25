import 'package:dio/dio.dart';
import 'package:vivu_mobile/core/network/env.dart';
import 'package:vivu_mobile/core/network/secure_storage.dart';

class ApiClient {
  static final Dio dio = () {
    final d = new Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    d.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorage().readSecureData(
            key: 'accessToken',
          );
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (DioException err, handler) => handler.next(err),
      ),
    );
    return d;
  }();
}
