
import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/responses/login_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_cubit.dart';
import 'package:get/get.dart';

class LoginCubit extends BaseCubit {
  void requestLogin(userId,mobile) async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("please_check_your_internet_connection".tr, false, 0)));
    } else {
      LoginResponse _response = await apiService.requestLogin(userId,mobile);
      emit(LoadingState(false));
      emit(LoginResponseState(_response));
    }
  }
}
