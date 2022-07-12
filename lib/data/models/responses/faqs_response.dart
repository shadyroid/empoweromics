import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoweromics/data/models/beans/FAQ.dart';
import 'package:empoweromics/data/models/beans/ad.dart';

class FAQsResponse {
  List<FAQ> data;

  FAQsResponse(this.data);

  factory FAQsResponse.fromJson(
          List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) =>
      FAQsResponse(List<FAQ>.from(docs.map((x) => FAQ.fromJson(x.data()))));
}
