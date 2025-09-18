import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivu_mobile/core/common/constants/app_color.dart';
import 'package:vivu_mobile/core/routes/app_routes.dart';
import 'package:vivu_mobile/feature/auth/domain/register_cubit.dart';
import 'package:vivu_mobile/feature/auth/presentation/widget/input_field.dart';

import '../../../core/di/service_locator.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (_) => locator<RegisterCubit>(),
      child: const SignupScreenView(),
    );
  }
}

class SignupScreenView extends StatefulWidget {
  const SignupScreenView({super.key});

  @override
  State<SignupScreenView> createState() => _SignupScreenViewState();
}

class _SignupScreenViewState extends State<SignupScreenView> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _loadingDialogVisible = false;

  void _showErrorDialog(String title, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showLoadingDialog() {
    if (_loadingDialogVisible) return;
    _loadingDialogVisible = true;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _hideLoadingDialog() {
    if (!_loadingDialogVisible) return;
    _loadingDialogVisible = false;
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> _showSuccessDialog(String title, String message) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _onSignupPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.read<RegisterCubit>().register(
        _email,
        _name,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          _showLoadingDialog();
        } else if (state is RegisterFailure) {
          _hideLoadingDialog();
          _showErrorDialog('Đăng ký thất bại', state.message);
        } else if (state is RegisterSuccess) {
          _hideLoadingDialog();
          _showSuccessDialog(
            'Đăng ký thành công',
            'Bạn đã đăng ký tài khoản thành công.',
          ).then((_) {
            // Sau khi dialog đóng mới chuyển trang
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(60),
                  width: double.infinity,
                  decoration: BoxDecoration(gradient: MAIN_LINEAR),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/icons/vivu_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: bottomInset),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight - bottomInset,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 32),
                                const Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      InputField(
                                        hintText: 'Họ và tên',
                                        icon: Icons.person_outline,
                                        obscureText: false,
                                        validator: (val) {
                                          if (val == null || val.isEmpty)
                                            return 'Vui lòng nhập họ tên';
                                          return null;
                                        },
                                        onSaved:
                                            (val) => _name = val?.trim() ?? '',
                                      ),
                                      const SizedBox(height: 16),
                                      InputField(
                                        hintText: 'Email',
                                        icon: Icons.email_outlined,
                                        obscureText: false,
                                        validator: (val) {
                                          if (val == null || val.isEmpty)
                                            return 'Vui lòng nhập email';
                                          final regex = RegExp(
                                            r'^[^@]+@[^@]+\.[^@]+',
                                          );
                                          if (!regex.hasMatch(val))
                                            return 'Email không hợp lệ';
                                          return null;
                                        },
                                        onSaved:
                                            (val) => _email = val?.trim() ?? '',
                                      ),
                                      const SizedBox(height: 16),
                                      InputField(
                                        hintText: 'Mật khẩu',
                                        icon: Icons.lock_outline,
                                        obscureText: true,
                                        controller: _passwordController,

                                        validator: (val) {
                                          if (val == null || val.isEmpty)
                                            return 'Vui lòng nhập mật khẩu';
                                          if (val.length < 6)
                                            return 'Mật khẩu ít nhất 6 ký tự';
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      InputField(
                                        hintText: "Nhap lại mật khẩu",
                                        icon: Icons.lock_reset,
                                        obscureText: true,
                                        controller: _confirmPasswordController,
                                        validator: (val) {
                                          if (val == null || val.isEmpty)
                                            return 'Vui lòng nhập lại mật khẩu';
                                          if (val != _passwordController.text)
                                            return 'Mật khẩu không khớp';
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                _AuthButton(
                                  text: 'Đăng ký',
                                  onPressed: _onSignupPressed,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Quay lại'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 44),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const _AuthButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF357AF6),
    this.textColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: 18, color: textColor)),
      ),
    );
  }
}
