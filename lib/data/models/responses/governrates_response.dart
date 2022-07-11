import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoweromics/data/models/beans/governorate.dart';
import 'package:empoweromics/data/models/beans/service.dart';

class GovernoratesResponse {
  List<Governorate> data;

  GovernoratesResponse(this.data);

  factory GovernoratesResponse.fromJson(
          List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) =>
      GovernoratesResponse(
          List<Governorate>.from(docs.map((x) => Governorate.fromJson(x.data()))));
}
