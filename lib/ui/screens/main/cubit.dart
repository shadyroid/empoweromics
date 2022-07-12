import 'package:empoweromics/data/models/responses/ads_response.dart';
import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/responses/services_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_cubit.dart';
import 'package:get/get.dart';

class MainCubit extends BaseCubit {
  void requestServices() async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("please_check_your_internet_connection".tr, false, 0)));
    } else {
      ServicesResponse _response = await apiService.requestServices();
      emit(LoadingState(false));
      emit(ServicesResponseState(_response));
    }
  }

  void requestAds() async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("please_check_your_internet_connection".tr, false, 0)));
    } else {
      AdsResponse _response = await apiService.requestAds();
      emit(LoadingState(false));
      emit(AdsResponseState(_response));
    }
  }
}
