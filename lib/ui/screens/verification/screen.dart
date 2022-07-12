import 'dart:io';

import 'package:empoweromics/data/models/responses/base_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/ui/base/base_stateful_widget.dart';
import 'package:empoweromics/ui/componants/app_button.dart';
import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:empoweromics/ui/componants/pin_view.dart';
import 'package:empoweromics/ui/screens/verification/cubit.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

class VerificationScreen extends BaseStatefulWidget {
  String mobile;

  VerificationScreen(this.mobile);

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState
    extends BaseStatefulWidgetState<VerificationScreen> {
  VerificationCubit cubit = VerificationCubit();

  CountdownTimerController controller;
  FirebaseAuth auth = FirebaseAuth.instance;

  String code;

  String verificationId;

  int resendToken;

  @override
  void initState() {
    super.initState();
    controller = CountdownTimerController(
        endTime: DateTime.now().millisecondsSinceEpoch + 60000);
    controller.endTime = DateTime.now().millisecondsSinceEpoch + 60000;
    controller.start();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      requestSendVerificationCode();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'verification_code'.tr,
            style: TextStyle(color: AppColors.black),
          ),
          leading: IconButton(
            icon: AppSvg.load("assets/icons/ic_back_arrow.svg"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          leadingWidth: AppSizes.w0_17,
        ),
        body: BlocListener<VerificationCubit, BaseState>(
            bloc: cubit,
            listener: (BuildContext context, state) {
              if (state is SendVerificationCodeResponseState) {
                _onSendVerificationCodeResponse(state.response);
              }
            },
            child: Container(
              color: AppColors.white,
              child: SingleChildScrollView(
                  child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.w0_074),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSizes.h0_056,
                      ),
                      AppSvg.load("assets/icons/verification_illustration.svg"),
                      SizedBox(
                        height: AppSizes.h0_056,
                      ),
                      Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text('verify_your_number'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: AppSizes.txt_20))),
                      SizedBox(
                        height: AppSizes.h0_01,
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(fontSize: AppSizes.txt_16),
                          children: [
                            TextSpan(
                                text:
                                    'enter_the6_digit_code_sent_to_your_phone_number'
                                        .tr,
                                style: TextStyle(
                                    color: AppColors.gray,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'din',
                                    fontSize: AppSizes.txt_16)),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AppSizes.w0_016),
                                  child:
                                      AppSvg.load("assets/icons/ic_edit.svg")),
                            ),
                            TextSpan(
                                text: widget.mobile,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                  fontSize: AppSizes.txt_16,
                                  fontFamily: 'din',
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.h0_036,
                      ),
                      PinView(
                        count: 6,
                        inputDecoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        )),
                        requestFocus: true,
                        style: TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.w500),
                        dashStyle:
                            TextStyle(fontSize: 25.0, color: Colors.grey),
                        submit: (String code) {
                          this.code = code;
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                      SizedBox(
                        height: AppSizes.h0_036,
                      ),
                      CountdownTimer(
                        controller: controller,
                        widgetBuilder: (_, CurrentRemainingTime time) {
                          if (time == null) {
                            return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(fontSize: AppSizes.txt_16),
                                children: [
                                  TextSpan(
                                      text: 'code_not_sent'.tr,
                                      style: TextStyle(
                                        color: AppColors.gray,
                                        fontFamily: 'din',
                                      )),
                                  TextSpan(
                                      text: 'resend'.tr,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = _onResendCodeClick,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                        fontFamily: 'din',
                                      )),
                                ],
                              ),
                            );
                          }
                          return Text(
                            '00:${time.sec} ',
                            style: TextStyle(
                              color: AppColors.colorPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: AppSizes.h0_036,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSizes.w0_037),
                    child: AppButton(text: 'next'.tr, onPressed: _onNextClick)),
              ])),
            )));
  }

  void _onResendCodeClick() {
    if (!controller.isRunning) {
      requestSendVerificationCode();
    }
  }

  void _onSendVerificationCodeResponse(BaseResponse response) {
    controller.endTime = DateTime.now().millisecondsSinceEpoch + 60000;
    controller.start();
  }

  void _onVerificationResponse(UserCredential userCredential) {
    Navigator.pop(context, userCredential.user.uid);
  }

  Future<void> _onNextClick() async {
    if (!_isValid()) return;
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);

    // Sign the user in (or link) with the credential
    UserCredential userCredential = await auth.signInWithCredential(credential);

    _onVerificationResponse(userCredential);
  }

  bool _isValid() {
    return code != null;
  }

  void requestSendVerificationCode() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+2${widget.mobile}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        if (Platform.isAndroid) {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          _onVerificationResponse(userCredential);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Toast.show('The provided phone number is not valid.', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        } else {
          Toast.show(e.code, context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      },
      codeSent: (String verificationId, int resendToken) {
        this.verificationId = verificationId;
        this.resendToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }
}
