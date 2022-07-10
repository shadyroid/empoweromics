import 'dart:math';

import 'package:empoweromics/data/models/beans/service.dart';
import 'package:empoweromics/data/models/responses/services_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_stateful_widget.dart';
import 'package:empoweromics/ui/componants/app_button.dart';
import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:empoweromics/ui/componants/nav_drawer.dart';
import 'package:empoweromics/ui/componants/type_text_field.dart';
import 'package:empoweromics/ui/screens/installment_calculator/cubit.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class InstallmentCalculatorScreen extends BaseStatefulWidget {
  @override
  InstallmentCalculatorScreenState createState() =>
      InstallmentCalculatorScreenState();
}

class InstallmentCalculatorScreenState
    extends BaseStatefulWidgetState<InstallmentCalculatorScreen> {
  InstallmentCalculatorCubit cubit = InstallmentCalculatorCubit();
  final inputsFormKey = GlobalKey<FormState>();
  TextEditingController financeValueTextEditingController =
      TextEditingController();

  Service _selectedService;
  List<DropdownMenuItem<Service>> services = [];

  int selectedAge = 24;
  int selectedTenor = 1;
  double tenorMaxValue = 15;

  String totalMonthlyPayment;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      cubit.requestServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(2),
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          toolbarHeight: AppSizes.h0_1,
          title: Text(
            'installment_calculator'.tr,
            style: TextStyle(color: AppColors.black),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: AppSvg.load(
                'assets/icons/ic_navigation_icon.svg',
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        body: BlocListener<InstallmentCalculatorCubit, BaseState>(
            bloc: cubit,
            listener: (BuildContext context, state) {
              if (state is LoadingState) {
                onLoading(state.isLoading);
              } else if (state is ErrorState) {
                onApiError(state.response);
              } else if (state is ServicesResponseState) {
                _onServicesResponse(state.response);
              }
            },
            child: Container(
              color: AppColors.white,
              child: Form(
                  key: inputsFormKey,
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.w0_07),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: AppSizes.h0_028,
                          ),
                          Text(
                            'calculate_your_installments'.tr,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'monthly_installment_as_per_finance_amount_value'
                                .tr,
                          ),
                          SizedBox(
                            height: AppSizes.h0_028,
                          ),
                          Container(
                            alignment: AlignmentDirectional.centerStart,
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.screenWidth * 0.017),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.black,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Service>(
                                  isExpanded: true,
                                  value: _selectedService,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'din',
                                  ),
                                  hint: RichText(
                                    text: TextSpan(
                                        text: 'unit_type'.tr,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'din',
                                        ),
                                        children: [
                                          const TextSpan(
                                              text: ' *',
                                              style:
                                                  TextStyle(color: Colors.red))
                                        ]),
                                  ),
                                  items: services,
                                  menuMaxHeight: AppSizes.h0_5,
                                  onChanged: _onServiceSelect),
                            ),
                          ),
                          SizedBox(
                            height: AppSizes.h0_028,
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'age'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'din',
                                ),
                                children: [
                                  const TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: Colors.red)),
                                  TextSpan(
                                      text: ' $selectedAge',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'din',
                                      ))
                                ]),
                          ),
                          Slider(
                            max: 65,
                            min: 24,
                            value: selectedAge.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                selectedAge = value.toInt();
                              });
                            },
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'tenor_in_years'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'din',
                                ),
                                children: [
                                  const TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: Colors.red)),
                                  TextSpan(
                                      text: ' $selectedTenor',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'din',
                                      ))
                                ]),
                          ),
                          Slider(
                            max: tenorMaxValue,
                            min: 1,
                            value: selectedTenor.toDouble(),
                            onChanged: (value) {
                              setState(() {
                                selectedTenor = value.toInt();
                              });
                            },
                          ),
                          TypeTextField(
                              isRequired: true,
                              labelText: 'finance_value'.tr,
                              textInputType: TextInputType.number,
                              textEditingController:
                                  financeValueTextEditingController,
                              validator: validation.isNotEmpty),
                          TypeTextField(
                            labelText: 'unit_value'.tr,
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: AppSizes.h0_028,
                          ),
                          AppButton(
                            text: 'calculate'.tr,
                            onPressed: _onInstallmentCalculatorClick,
                          ),
                          SizedBox(
                            height: AppSizes.h0_028,
                          ),
                          Visibility(
                              visible: totalMonthlyPayment != null,
                              child: Text('total_monthly_payment'.tr +
                                  ": " +
                                  (totalMonthlyPayment ?? "")))
                        ]),
                  ))),
            )));
  }

  void _onInstallmentCalculatorClick() {
    if (!_isValid()) return;
    double loanTotalAmount = double.parse(financeValueTextEditingController.text);
    double interestRate = 0.00417;
    int mortgageMonths = selectedTenor * 12;

    setState(() {
      totalMonthlyPayment = (loanTotalAmount *
              (interestRate + pow((1 + interestRate), mortgageMonths)) /
              pow((1 + interestRate), mortgageMonths - 1))
          .toString();
    });
  }

  bool _isValid() {
    return validation.isNotNull(_selectedService, 'select_service'.tr) &&
        inputsFormKey.currentState.validate() &&
        validation.isAcceptableAge(selectedTenor + selectedAge,
            'your_age_plus_tenor_period_must_not_exceed65_years'.tr);
  }

  void _onServicesResponse(ServicesResponse response) {
    for (int i = 0; i < response.data.length; i++) {
      services.add(DropdownMenuItem<Service>(
          child: Text(
            response.data[i].name(Get.locale.languageCode),
          ),
          value: response.data[i]));
    }
    _selectedService = null;
    setState(() {});
  }

  void _onServiceSelect(value) {
    setState(() {
      _selectedService = value;
      if (selectedTenor > int.parse(_selectedService.Tenor)) {
        selectedTenor = int.parse(_selectedService.Tenor);
      }
      tenorMaxValue = double.parse(_selectedService.Tenor);
    });
  }
}
