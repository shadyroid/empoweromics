import 'package:get/get.dart';

class FAQ {
  int id;
  String question;
  String answer;

  FAQ({
    this.id,
    this.question,
    this.answer,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) => FAQ(
        id: json["id"],
        question: Get.locale.languageCode == "en"
            ? json["question_en"]
            : json["question_ar"],
        answer: Get.locale.languageCode == "en"
            ? json["answer_en"]
            : json["answer_ar"],
      );
}
