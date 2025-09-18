

import 'package:vivu_mobile/feature/auth/data/auth_repository.dart';
import 'package:vivu_mobile/feature/auth/data/models/response/login_response.dart';

import '../../../core/common/models/api_response.dart';
import 'models/request/login_request.dart';
import 'models/request/register_request.dart';

class AuthService {
  final AuthRepository _repository;

  AuthService(this._repository);

  Future<ApiResponse<LoginData>> login(String email, String password) async {
    return await _repository.login(
      // Assuming LoginRequest has a constructor that takes username and password
      LoginRequest(email: email, password: password),
    );
  }

  Future<ApiResponse> register(String email, String password, String name) async {
    return await _repository.register(
      // Assuming RegisterRequest has a constructor that takes username and password
      RegisterRequest(email: email, password: password, username: name),
    );
  }

  Future<void> logout() async {
    await _repository.logout();
  }
}