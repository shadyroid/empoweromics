class BaseResponse {
  String message;
  bool success;
  int statusCode;

  BaseResponse(this.message, this.success, this.statusCode);

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        json["message"],
        json["success"],
        json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "statusCode": statusCode,
      };
}
