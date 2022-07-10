import 'dart:io';


import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/data/remote/api_service.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCubit extends Cubit<BaseState> {
  ApiService apiService;

  BaseCubit() : super(InitialState()) {
    apiService = ApiService();
  }


  bool isSuccess(BaseResponse response) {
    if (!response.success) {
      emit(ErrorState(response));
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isInternetNotAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return false;
      }
    } on SocketException catch (_) {
      return true;
    }
  }
}
