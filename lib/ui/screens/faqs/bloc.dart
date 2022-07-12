import 'package:empoweromics/data/models/events/events.dart';
import 'package:empoweromics/data/models/responses/faqs_response.dart';
import 'package:empoweromics/data/models/responses/common_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_bloc.dart';

class FAQsBloc extends BaseBloc {
  FAQsBloc() {
    on<FAQsRequestEvent>(requestFAQs);
  }

  void requestFAQs(event, emit) async {
    emit(LoadingState(true));
    if (await isInternetNotAvailable()) {
      emit(LoadingState(false));
      emit(ErrorState(CommonResponse(false, "no_internet_connection", 0, false)));
    } else {
      FAQsResponse _response = await apiService.requestFAQs(event);
      emit(LoadingState(false));
      emit(FAQsResponseState(_response));
    }
  }
}





