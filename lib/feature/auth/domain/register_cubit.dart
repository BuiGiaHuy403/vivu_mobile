import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_service.dart';

sealed class RegisterState {}

class RegisterInitial extends RegisterState {

}

class RegisterLoading extends RegisterState {

}
class RegisterSuccess extends RegisterState {
}
class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure({
    required this.message,
  });
}

class RegisterCubit extends Cubit<RegisterState> {
  final AuthService service;

  RegisterCubit({required this.service}) : super(RegisterInitial());

  Future<void> register(String email, String username, String password) async {
    emit(RegisterLoading());
    try {
      final response = await service.register(email, password, username);

      switch (response.code) {
        case 200:
          emit(RegisterSuccess());
          break;
        case 409:
          emit(RegisterFailure(
            message: "Tài khoản đã tồn tại",
          ));
          break;
        default:
          emit(RegisterFailure(
            message: "Có lỗi không xác định",
          ));
      }
    } catch (e) {
      emit(RegisterFailure(
        message: "Có lỗi xảy ra: $e",
      ));
    }
  }
}