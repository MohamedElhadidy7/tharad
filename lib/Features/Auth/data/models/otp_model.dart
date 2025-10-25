class VerifyOtpModel {
  final String message;
  final dynamic data;
  final String status;

  VerifyOtpModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      message: json['message'] ?? '',
      data: json['data'],
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data,
      'status': status,
    };
  }
}
