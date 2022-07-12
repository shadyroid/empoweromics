import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoweromics/data/models/beans/governorate.dart';
import 'package:empoweromics/data/models/beans/user.dart';
import 'package:empoweromics/data/models/responses/governrates_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/data/preferences/user_manager.dart';
import 'package:empoweromics/ui/base/base_stateful_widget.dart';
import 'package:empoweromics/ui/componants/app_button.dart';
import 'package:empoweromics/ui/componants/type_text_field.dart';
import 'package:empoweromics/ui/screens/complete_data/cubit.dart';
import 'package:empoweromics/ui/screens/message/screen.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';

class CompleteDataScreen extends BaseStatefulWidget {
  User user;

  CompleteDataScreen({this.user});

  @override
  CompleteDataScreenState createState() => CompleteDataScreenState();
}

class CompleteDataScreenState
    extends BaseStatefulWidgetState<CompleteDataScreen> {
  CompleteDataCubit cubit = CompleteDataCubit();
  final inputsFormKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController mobileTextEditingController = TextEditingController();
  TextEditingController companyTextEditingController = TextEditingController();

  Governorate _selectedGovernorate;
  List<DropdownMenuItem<Governorate>> governorates = [];

  bool isEmployedChecked = true;

  bool hasBankingObligationChecked = true;

  bool isAdibCustomerChecked = true;

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      cubit.requestGovernorates();
    });
    nameTextEditingController.text = widget.user.name;
    emailTextEditingController.text = widget.user.email;
    mobileTextEditingController.text = widget.user.mobile;
    companyTextEditingController.text = widget.user.company;
    isEmployedChecked = widget.user.is_employed;
    hasBankingObligationChecked = widget.user.has_banking_obligation;
    isAdibCustomerChecked = widget.user.is_adib_customer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'apply_now'.tr,
            style: TextStyle(color: AppColors.black),
          ),
        ),
        body: BlocListener<CompleteDataCubit, BaseState>(
            bloc: cubit,
            listener: (BuildContext context, state) {
              if (state is GovernoratesResponseState) {
                _onGovernoratesResponse(state.response);
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
                              child: DropdownButton<Governorate>(
                                  isExpanded: true,
                                  value: _selectedGovernorate,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'din',
                                  ),
                                  hint: RichText(
                                    text: TextSpan(
                                        text: 'select_governorate'.tr,
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
                                  items: governorates,
                                  menuMaxHeight: AppSizes.h0_5,
                                  onChanged: _onGovernorateSelect),
                            ),
                          ),
                          TypeTextField(
                              isRequired: true,
                              labelText: 'mobile'.tr,
                              textInputType: TextInputType.phone,
                              textEditingController:
                                  mobileTextEditingController,
                              validator: validation.isPhoneNumber),
                          Text("${'employed'.tr} / ${'self_employed'.tr}"),
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: isEmployedChecked
                                ? 'employed'.tr
                                : 'self_employed'.tr,
                            horizontalAlignment: MainAxisAlignment.start,
                            onChanged: (value) => setState(() {
                              setState(() {
                                if (value == 'employed'.tr) {
                                  isEmployedChecked = true;
                                } else if (value == 'self_employed'.tr) {
                                  isEmployedChecked = false;
                                }
                              });
                            }),
                            items: ['employed'.tr, 'self_employed'.tr],
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.blue),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                          Text('do_you_have_any_banking_obligation'.tr),
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: hasBankingObligationChecked
                                ? 'yes'.tr
                                : 'no'.tr,
                            horizontalAlignment: MainAxisAlignment.start,
                            onChanged: (value) => setState(() {
                              setState(() {
                                if (value == 'yes'.tr) {
                                  hasBankingObligationChecked = true;
                                } else if (value == 'no'.tr) {
                                  hasBankingObligationChecked = false;
                                }
                              });
                            }),
                            items: ['yes'.tr, 'no'.tr],
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.blue),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                          Text('are_you_an_adib_customer'.tr),
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue:
                                isAdibCustomerChecked ? 'yes'.tr : 'no'.tr,
                            horizontalAlignment: MainAxisAlignment.start,
                            onChanged: (value) => setState(() {
                              setState(() {
                                if (value == 'yes'.tr) {
                                  isAdibCustomerChecked = true;
                                } else if (value == 'no'.tr) {
                                  isAdibCustomerChecked = false;
                                }
                              });
                            }),
                            items: ['yes'.tr, 'no'.tr],
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.blue),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                          TypeTextField(
                              isRequired: true,
                              labelText: 'company'.tr,
                              textEditingController:
                                  companyTextEditingController,
                              validator: validation.isNotEmpty),
                          TypeTextField(
                              isRequired: true,
                              labelText: 'email'.tr,
                              textInputType: TextInputType.emailAddress,
                              textEditingController: emailTextEditingController,
                              validator: validation.isEmail),
                          SizedBox(
                            height: AppSizes.h0_036,
                          ),
                          AppButton(
                            text: 'send'.tr,
                            onPressed: _onCompleteDataClick,
                          ),
                        ]),
                  ))),
            )));
  }

  void _onCompleteDataClick() {
    if (!_isValid()) return;

    db
        .collection("users")
        .doc(widget.user.id)
        .set(User(
          is_data_completed: true,
          name: nameTextEditingController.text,
          email: emailTextEditingController.text,
          company: companyTextEditingController.text,
          governorate_id: _selectedGovernorate.id,
          is_employed: isEmployedChecked,
          mobile: mobileTextEditingController.text,
          has_banking_obligation: hasBankingObligationChecked,
          is_adib_customer: isAdibCustomerChecked,
        ).toJson())
        .onError((e, _) => print("Error writing document: $e"));
    UserPreferences.setLoggedIn(true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MessageScreen('your_data_is_sent_successfully'.tr)),
    );
  }

  bool _isValid() {
    return  inputsFormKey.currentState.validate()&&validation.isNotNull(_selectedGovernorate, 'select_governorate'.tr);
  }

  void _onGovernoratesResponse(GovernoratesResponse response) {
    for (int i = 0; i < response.data.length; i++) {
      if (widget.user.governorate_id != null &&
          response.data[i].id == widget.user.governorate_id) {
        _selectedGovernorate = response.data[i];
      }
      governorates.add(DropdownMenuItem<Governorate>(
          child: Text(
            response.data[i].name,
          ),
          value: response.data[i]));
    }

    setState(() {});
  }

  void _onGovernorateSelect(Governorate value) {
    setState(() {
      _selectedGovernorate = value;
    });
  }
}
