
import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_cubit.dart';
import 'package:get/get.dart';

class VerificationCubit extends BaseCubit {

  void requestVerification(request) async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("errorInternetError".tr, false, 0)));
    } else {
      BaseResponse _response = await apiService.requestVerification(request);
      emit(LoadingState(false));
      if (isSuccess(_response)) {
        emit(VerificationResponseState(_response));
      }
    }
  }

  void requestSendVerificationCode(request) async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("errorInternetError".tr, false, 0)));
    } else {
      BaseResponse _response =
      await apiService.requestSendVerificationCode(request);
      emit(LoadingState(false));
      if (isSuccess(_response)) {
        emit(SendVerificationCodeResponseState(_response));
      }
    }
  }
}
