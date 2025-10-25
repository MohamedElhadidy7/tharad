class UserProfileModel {
  final String username;
  final String email;
  final String? image;

  UserProfileModel({required this.username, required this.email, this.image});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, 'image': image};
  }
}

class UserProfileResponseModel {
  final String message;
  final String status;
  final UserProfileModel? data;

  UserProfileResponseModel({
    required this.message,
    required this.status,
    this.data,
  });

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UserProfileResponseModel(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      data: json['data'] != null
          ? UserProfileModel.fromJson(json['data'])
          : null,
    );
  }
}
