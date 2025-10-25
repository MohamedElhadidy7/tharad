class LoginResponseModel {
  final String message;
  final String status;
  final LoginData? data;

  LoginResponseModel({required this.message, required this.status, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'status': status, 'data': data?.toJson()};
  }
}

class LoginData {
  final String token;
  final String username;
  final String email;

  LoginData({required this.token, required this.username, required this.email});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'username': username, 'email': email};
  }
}
