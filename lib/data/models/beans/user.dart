class User {
  String id;
  String name;
  String email;
  String mobile;
  String company;
  int governorate_id;
  bool is_employed;
  bool has_banking_obligation;
  bool is_adib_customer;
  bool is_data_completed;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.company,
      this.governorate_id,
      this.is_employed,
      this.has_banking_obligation,
      this.is_adib_customer,
      this.is_data_completed});

  factory User.fromJson(Map<String, dynamic> json) => json != null
      ? User(
          id: json["id"],
          name: json["name"],
          email: json["email"],
          mobile: json["mobile"],
          company: json["company"],
          governorate_id: json["governorate_id"],
          is_employed: json["is_employed"],
          has_banking_obligation: json["has_banking_obligation"],
          is_adib_customer: json["is_adib_customer"],
          is_data_completed: json["is_data_completed"],
        )
      : User();

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (id != null) json["id"] = id;
    if (name != null) json["name"] = name;
    if (email != null) json["email"] = email;
    if (mobile != null) json["mobile"] = mobile;
    if (company != null) json["company"] = company;
    if (governorate_id != null) json["governorate_id"] = governorate_id;
    if (is_employed != null) json["is_employed"] = is_employed;
    if (has_banking_obligation != null)
      json["has_banking_obligation"] = has_banking_obligation;
    if (is_adib_customer != null) json["is_adib_customer"] = is_adib_customer;
    if (is_data_completed != null)
      json["is_data_completed"] = is_data_completed;
    return json;
  }
}
