class RegisterRequest {
  final String email;
  final String password;
  final String username;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'display_name': username,
    };
  }
}