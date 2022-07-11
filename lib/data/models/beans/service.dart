import 'package:get/get.dart';

class Service {
  int id;
  String name;
  String image;
  String FTV;
  String Tenor;
  String financed_amount;

  Service(
      {this.id,
      this.name,
      this.image = "",
      this.FTV,
      this.Tenor,
      this.financed_amount});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        name: Get.locale.languageCode == "en" ? json["name_en"] : json["name_ar"],
        image: json["image"],
        FTV: json["FTV"],
        Tenor: json["Tenor"],
        financed_amount: json["financed_amount"],
      );
}
