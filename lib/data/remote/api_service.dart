import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoweromics/data/models/responses/ads_response.dart';
import 'package:empoweromics/data/models/responses/auth_response.dart';
import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/responses/governrates_response.dart';
import 'package:empoweromics/data/models/responses/services_response.dart';
import 'package:empoweromics/utils/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  static FirebaseFirestore db;

  factory ApiService() {
    db = FirebaseFirestore.instance;
    return _singleton;
  }

  ApiService._internal();

  requestLogin(request) async {
    var url = CONSTANTS.BASE_URL + '';
    var response = await makeRequest(url, request.getParams(), null);
    return AuthResponse.fromJson(response);
  }

  requestCompleteData(request) async {

    db.collection("users").doc(request.getParams().getUID()).set(request.getParams()).onError((e, _) => print("Error writing document: $e"));
    return BaseResponse("user added", true, 200);
  }

  requestVerification(request) async {
    var url = CONSTANTS.BASE_URL + '';
    var response = await makeRequest(url, request.getParams(), null);
    return BaseResponse.fromJson(response);
  }

  requestSendVerificationCode(request) async {
    var url = CONSTANTS.BASE_URL + '';
    var response = await makeRequest(url, request.getParams(), null);
    return BaseResponse.fromJson(response);
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

  Future makeRequest(String url, Map<String, String> params,
      List<http.MultipartFile> files) async {}
}
