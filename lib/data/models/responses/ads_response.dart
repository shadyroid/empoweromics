import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoweromics/data/models/beans/ad.dart';

class AdsResponse {
  List<Ad> data;

  AdsResponse(this.data);

  factory AdsResponse.fromJson(
          List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) =>
      AdsResponse(List<Ad>.from(docs.map((x) => Ad.fromJson(x.data()))));
}
