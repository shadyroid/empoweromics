import 'package:empoweromics/data/models/responses/login_response.dart';
import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/responses/governrates_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_cubit.dart';
import 'package:get/get.dart';

class CompleteDataCubit extends BaseCubit {

  void requestGovernorates() async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("please_check_your_internet_connection".tr, false, 0)));
    } else {
      GovernoratesResponse _response = await apiService.requestGovernorates();
      emit(LoadingState(false));
      emit(GovernoratesResponseState(_response));
    }
  }
}
