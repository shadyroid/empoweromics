class Service {
  int id;
  String name_en;
  String name_ar;
  String image;
  String FTV;
  String Tenor;
  String financed_amount;

  Service({this.id, this.name_en, this.name_ar, this.image="", this.FTV, this.Tenor, this.financed_amount});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name_en: json["name_en"],
        name_ar: json["name_ar"],
        image: json["image"],
    FTV: json["FTV"],
    Tenor: json["Tenor"],
    financed_amount: json["financed_amount"],
      );

  String name(String lang) {
    if (lang == "en") {
      return name_en;
    } else {
      return name_ar;
    }
  }
}
