import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivu_mobile/feature/auth/data/auth_service.dart';

enum FailureStatus { userNotFound, wrongPassword, unknownError }

sealed class LoginState {}

class LoginInitial extends LoginState {

}

class LoginLoading extends LoginState {

}
class LoginSuccess extends LoginState {

}

class LoginFailure extends LoginState {
  final FailureStatus error;
  final String message;

  LoginFailure({
    required this.error,
    required this.message,
  });
}

class LoginCubit extends Cubit<LoginState> {
  final AuthService service;

  LoginCubit({required this.service}) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final response = await service.login(username, password);

      switch (response.code) {
        case 200:
          emit(LoginSuccess());
          break;
        case 401:
          emit(LoginFailure(
            error: FailureStatus.wrongPassword,
            message: "Sai mật khẩu",
          ));
          break;
        case 404:
          emit(LoginFailure(
            error: FailureStatus.userNotFound,
            message: "Người dùng không tồn tại",
          ));
          break;
        default:
          emit(LoginFailure(
            error: FailureStatus.unknownError,
            message: "Có lỗi không xác định",
          ));
      }
    } catch (e) {
      emit(LoginFailure(
        error: FailureStatus.unknownError,
        message: e.toString(),
      ));
    }
  }
}