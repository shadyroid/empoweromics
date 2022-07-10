class LoginRequest {
  final String mobile;

  Map<String, String> getParams() => {"mobile": mobile};

  LoginRequest({this.mobile});
}
