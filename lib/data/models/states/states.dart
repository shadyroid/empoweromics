import 'package:empoweromics/data/models/responses/faqs_response.dart';
import 'package:empoweromics/data/models/responses/governrates_response.dart';
import 'package:meta/meta.dart';
import 'package:empoweromics/data/models/responses/ads_response.dart';
import 'package:empoweromics/data/models/responses/login_response.dart';
import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/responses/services_response.dart';

@immutable
abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {
  final bool isLoading;

  LoadingState(this.isLoading);
}

class ErrorState extends BaseState {
  final BaseResponse response;

  ErrorState(this.response);
}

class LoginResponseState extends BaseState {
  final LoginResponse response;

  LoginResponseState(this.response);
}

class VerificationResponseState extends BaseState {
  final BaseResponse response;

  VerificationResponseState(this.response);
}

class SendVerificationCodeResponseState extends BaseState {
  final BaseResponse response;

  SendVerificationCodeResponseState(this.response);
}

class CompleteDataResponseState extends BaseState {
  final BaseResponse response;

  CompleteDataResponseState(this.response);
}

class GovernoratesResponseState extends BaseState {
  final GovernoratesResponse response;

  GovernoratesResponseState(this.response);
}
class ServicesResponseState extends BaseState {
  final ServicesResponse response;

  ServicesResponseState(this.response);
}

class AdsResponseState extends BaseState {
  final AdsResponse response;

  AdsResponseState(this.response);
}
class FAQsResponseState extends BaseState {
  final FAQsResponse response;

  FAQsResponseState(this.response);
}
