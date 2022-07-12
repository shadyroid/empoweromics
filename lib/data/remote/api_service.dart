import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoweromics/data/models/beans/user.dart';
import 'package:empoweromics/data/models/responses/ads_response.dart';
import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/responses/faqs_response.dart';
import 'package:empoweromics/data/models/responses/governrates_response.dart';
import 'package:empoweromics/data/models/responses/login_response.dart';
import 'package:empoweromics/data/models/responses/services_response.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  static FirebaseFirestore db;

  factory ApiService() {
    db = FirebaseFirestore.instance;
    return _singleton;
  }

  ApiService._internal();

  requestCompleteData(request) async {
    db
        .collection("users")
        .doc(request.getParams().getUID())
        .set(request.getParams())
        .onError((e, _) => print("Error writing document: $e"));
    return BaseResponse("user added", true, 200);
  }

  requestGovernorates() async {
    var event = await db.collection("governorates").get();
    return GovernoratesResponse.fromJson(event.docs);
  }

  requestServices() async {
    var event = await db.collection("services").get();
    return ServicesResponse.fromJson(event.docs);
  }

  requestAds() async {
    var event = await db.collection("ads").get();
    return AdsResponse.fromJson(event.docs);
  }

  requestFAQs() async {
    var event = await db.collection("faqs").get();
    return FAQsResponse.fromJson(event.docs);
  }

  requestLogin(userId, mobile) async {
    final docRef = db.collection("users").doc(userId);
    DocumentSnapshot doc = await docRef.get();

    User user;
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      user = User.fromJson(data);
    } else {
      db
          .collection("users")
          .doc(userId)
          .set(User(id: userId, is_data_completed: false, mobile: mobile)
              .toJson())
          .onError((e, _) => print("Error writing document: $e"));
      user = User(id:userId,mobile: mobile);
    }

    return LoginResponse(user);
  }
}
