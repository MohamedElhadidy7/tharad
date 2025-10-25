// registration_response_model.dart

class RegistrationResponseModel {
  final String message;
  final String status;
  final RegistrationData? data;

  RegistrationResponseModel({
    required this.message,
    required this.status,
    this.data,
  });

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    return RegistrationResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      data: json['data'] != null
          ? RegistrationData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'status': status, 'data': data?.toJson()};
  }
}

class RegistrationData {
  final String email;
  final String image;
  final String username;
  final int otp;

  RegistrationData({
    required this.email,
    required this.image,
    required this.username,
    required this.otp,
  });

  factory RegistrationData.fromJson(Map<String, dynamic> json) {
    return RegistrationData(
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      username: json['username'] ?? '',
      otp: int.tryParse(json['otp'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'image': image, 'username': username, 'otp': otp};
  }
}
