import 'package:empoweromics/data/models/responses/services_response.dart';
import 'package:get/get.dart';
import 'package:empoweromics/data/models/responses/auth_response.dart';

import 'package:empoweromics/data/models/responses/base_response.dart';

import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_cubit.dart';

class InstallmentCalculatorCubit extends BaseCubit {


  void requestServices() async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("errorInternetError".tr, false, 0)));
    } else {
      ServicesResponse _response = await apiService.requestServices();
      emit(LoadingState(false));
      emit(ServicesResponseState(_response));
    }
  }

}
