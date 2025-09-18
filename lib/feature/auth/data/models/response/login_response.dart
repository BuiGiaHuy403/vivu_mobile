class LoginData {
  final String token;
  LoginData({required this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      LoginData(token: json['token'] ?? '');
}