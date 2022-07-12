import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/responses/faqs_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_cubit.dart';
import 'package:get/get.dart';

class FAQsCubit extends BaseCubit {
  void requestFAQs() async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(BaseResponse("please_check_your_internet_connection".tr, false, 0)));
    } else {
      FAQsResponse _response = await apiService.requestFAQs();
      emit(LoadingState(false));
      emit(FAQsResponseState(_response));
    }
  }

 
}





