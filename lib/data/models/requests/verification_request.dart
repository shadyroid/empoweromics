class VerificationRequest {
  final String otp;
  final String mobile;

  Map<String, String> getParams() => {
    "otp": otp,
    "mobile": mobile,
  };

  VerificationRequest({this.otp, this.mobile});
}
