class User {
  int id;
  String name;
  String email;
  String mobile;
  bool is_data_completed;

  User({this.id, this.name, this.email, this.mobile, this.is_data_completed});

  factory User.fromJson(Map<String, dynamic> json) => json != null
      ? User(
          id: json["id"],
          name: json["name"],
          email: json["email"],
          mobile: json["mobile"],
          is_data_completed: json["is_data_completed"],
        )
      : User();

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "is_data_completed": is_data_completed,
  };
}
