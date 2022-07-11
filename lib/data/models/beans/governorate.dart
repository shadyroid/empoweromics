import 'package:get/get.dart';

class Governorate {
  int id;
  String name;

  Governorate({this.id, this.name});

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
        id: json["id"],
        name:
            Get.locale.languageCode == "en" ? json["name_en"] : json["name_ar"],
      );
}
