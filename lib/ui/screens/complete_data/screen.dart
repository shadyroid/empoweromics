import 'package:empoweromics/data/models/requests/complete_data_request.dart';
import 'package:empoweromics/data/models/responses/auth_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_stateful_widget.dart';
import 'package:empoweromics/ui/componants/app_button.dart';
import 'package:empoweromics/ui/componants/type_text_field.dart';
import 'package:empoweromics/ui/screens/complete_data/cubit.dart';
import 'package:empoweromics/ui/screens/main/screen.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

class CompleteDataScreen extends BaseStatefulWidget {
  String userId;

  CompleteDataScreen(this.userId);

  @override
  CompleteDataScreenState createState() => CompleteDataScreenState();
}

class CompleteDataScreenState
    extends BaseStatefulWidgetState<CompleteDataScreen> {
  CompleteDataCubit cubit = CompleteDataCubit();
  final inputsFormKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController mobileDateTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'register'.tr,
            style: TextStyle(color: AppColors.black),
          ),
        ),
        body: BlocListener<CompleteDataCubit, BaseState>(
            bloc: cubit,
            listener: (BuildContext context, state) {
              if (state is LoadingState) {
                onLoading(state.isLoading);
              } else if (state is ErrorState) {
                onApiError(state.response);
              } else if (state is CompleteDataResponseState) {
                _onCompleteDataResponse(state.response);
              }
            },
            child: Container(
              color: AppColors.white,
              child: Form(
                  key: inputsFormKey,
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.w0_037),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          TypeTextField(
                              isRequired: true,
                              labelText: 'name'.tr,
                              textEditingController: nameTextEditingController,
                              validator: validation.isNotEmpty),
                          TypeTextField(
                              isRequired: true,
                              labelText: 'mobile'.tr,
                              textInputType: TextInputType.phone,
                              textEditingController: mobileDateTextEditingController,
                              validator: validation.isNotEmpty),

                          TypeTextField(
                              isRequired: true,
                              labelText: 'email'.tr,
                              textInputType: TextInputType.emailAddress,
                              textEditingController: emailTextEditingController,
                              validator: validation.isNotEmpty),

                          SizedBox(
                            height: AppSizes.h0_036,
                          ),
                          AppButton(
                            text: 'enter'.tr,
                            onPressed: _onCompleteDataClick,
                          ),
                        ]),
                  ))),
            )));
  }

  void _onCompleteDataClick() {
    if (!_isValid()) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  CompleteDataRequest _getData() {
    return CompleteDataRequest(
        name: nameTextEditingController.text,
        email: emailTextEditingController.text,
        mobile: mobileDateTextEditingController.text);
  }

  bool _isValid() {
    return inputsFormKey.currentState.validate();
  }

  void _onCompleteDataResponse(AuthResponse response) {
    Toast.show(response.message, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }
}
