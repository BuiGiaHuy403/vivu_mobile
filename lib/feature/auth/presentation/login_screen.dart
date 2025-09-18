import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivu_mobile/core/common/constants/app_color.dart';
import 'package:vivu_mobile/core/routes/app_routes.dart';
import 'package:vivu_mobile/feature/auth/domain/login_cubit.dart';
import 'package:vivu_mobile/feature/auth/presentation/widget/input_field.dart';

import '../../../core/di/service_locator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => locator<LoginCubit>(),
      child: const LoginScreenView(),
    );
  }
}

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool _loadingDialogVisible = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<LoginCubit>().login(_email, _password);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          _showLoadingDialog();
        } else if (state is LoginFailure) {
          _hideLoadingDialog();
          String title;
          switch (state.error) {
            case FailureStatus.userNotFound:
              title = 'Người dùng không tồn tại';
              break;
            case FailureStatus.wrongPassword:
              title = 'Sai mật khẩu';
              break;
            default:
              title = 'Lỗi';
          }
          _showErrorDialog(title, state.message);
        } else if (state is LoginSuccess) {
          _hideLoadingDialog();
          // Navigate to home
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (routes) => false,
          );
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
                      // Replace with your logo asset path
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
                                  'Đăng nhập',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                // Email field
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      InputField(
                                        hintText: "Email",
                                        icon: Icons.email_outlined,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Vui lòng nhập email";
                                          }
                                          final regex = RegExp(
                                            r'^[^@]+@[^@]+\.[^@]+',
                                          );
                                          if (!regex.hasMatch(value)) {
                                            return "Email không hợp lệ";
                                          }
                                          return null;
                                        },
                                        onSaved: (val) => _email = val!.trim(),
                                      ),
                                      const SizedBox(height: 16),
                                      InputField(
                                        hintText: "Mật khẩu",
                                        icon: Icons.lock_outline,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Vui lòng nhập mật khẩu";
                                          }
                                          if (value.length < 6) {
                                            return "Mật khẩu ít nhất 6 ký tự";
                                          }
                                          return null;
                                        },
                                        onSaved: (val) => _password = val!,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                // Login button
                                _AuthButton(
                                  text: 'Đăng nhập',
                                  onPressed: () {
                                    _onLoginPressed(context);
                                  },
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Chưa có tài khoản?'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.signup,
                                        );
                                      },
                                      child: const Text('Đăng ký'),
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

class _SocialButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.color,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: onPressed,
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
