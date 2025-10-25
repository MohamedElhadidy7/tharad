class LogoutModel {
  final String message;
  final String status;

  LogoutModel({required this.message, required this.status});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      message: json['message'] ?? 'تم تسجيل الخروج بنجاح',
      status: json['status'] ?? 'success',
    );
  }
}
