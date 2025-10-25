class UpdateProfileModel {
  final String message;
  final String status;

  UpdateProfileModel({required this.message, required this.status});

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      message: json['message'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
