class CompleteDataRequest {
  final String name;
  final String email;
  final String mobile;

  Map<String, String> getParams() => {
        "name": name,
        "email": email,
        "mobile": mobile,
      };

  CompleteDataRequest({this.name, this.email, this.mobile});
}
