import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoweromics/data/models/beans/service.dart';

class ServicesResponse {
  List<Service> data;

  ServicesResponse(this.data);

  factory ServicesResponse.fromJson(
          List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) =>
      ServicesResponse(
          List<Service>.from(docs.map((x) => Service.fromJson(x.data()))));
}
