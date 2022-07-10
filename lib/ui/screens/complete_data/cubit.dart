import 'package:empoweromics/data/models/responses/auth_response.dart';
import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_cubit.dart';
import 'package:get/get.dart';

class CompleteDataCubit extends BaseCubit {

  void requestCompleteData(request) async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("errorInternetError".tr, false, 0)));
    } else {
      AuthResponse _response = await apiService.requestCompleteData(request);
      emit(LoadingState(false));
      emit(CompleteDataResponseState(_response));
    }
  }
}
