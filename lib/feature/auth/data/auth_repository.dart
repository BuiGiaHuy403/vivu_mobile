
import 'package:dio/dio.dart';
import 'package:vivu_mobile/core/network/api_client.dart';
import 'package:vivu_mobile/feature/auth/data/models/request/login_request.dart';
import 'package:vivu_mobile/feature/auth/data/models/request/register_request.dart';
import 'package:vivu_mobile/feature/auth/data/models/response/login_response.dart';

import '../../../core/common/models/api_response.dart';
import '../../../core/network/secure_storage.dart';


class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);
  // Simulate a login function
  Future<ApiResponse<LoginData>> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/accounts/login',
        data: request.toJson(),
      );

      final token = response.data['accessToken'];
      if (token != null) {
        await SecureStorage().writeSecureData(
          key: 'accessToken',
          value: token,
        );
      }
      return ApiResponse.fromJson(response.data,
          (data) => LoginData.fromJson(data as Map<String, dynamic>));
    } catch (e) {
      print("Login error: $e");
      throw Exception("Login failed: $e");
    }
  }
  Future<ApiResponse<void>> register(RegisterRequest request) async{
    try {
      final response = await _dio.post(
        '/accounts/register',
        data: request.toJson(),
      );
      return ApiResponse.fromJson(response.data, null);
    } catch (e) {
      print("Login error: $e");
      throw Exception("register failed: $e");
    }
  }

  Future<void> logout() async {
    await SecureStorage().deleteSecureData(key: 'accessToken');
  }
}