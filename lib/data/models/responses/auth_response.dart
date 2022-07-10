
import 'package:empoweromics/data/models/beans/user.dart';

import 'base_response.dart';

class AuthResponse extends BaseResponse {
  String access_token;
  String token_type;
  User data;

  AuthResponse(json, this.access_token, this.token_type, this.data)
      : super(json["message"], json["success"], json["statusCode"]);

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        json,
        json["access_token"],
        json["token_type"],
        json["data"] == null ? null : User.fromJson(json["data"]),
      );
}
