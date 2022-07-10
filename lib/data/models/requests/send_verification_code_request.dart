class SendVerificationCodeRequest {
  final String mobile;

  Map<String, String> getParams() => {
        "mobile": mobile,
      };

  SendVerificationCodeRequest({this.mobile});
}
