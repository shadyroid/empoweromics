import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empoweromics/data/models/beans/user.dart';
import 'package:empoweromics/data/models/responses/auth_response.dart';
import 'package:empoweromics/data/models/states/states.dart';
import 'package:empoweromics/data/preferences/user_manager.dart';
import 'package:empoweromics/ui/base/base_stateful_widget.dart';
import 'package:empoweromics/ui/componants/app_button.dart';
import 'package:empoweromics/ui/componants/app_svg.dart';
import 'package:empoweromics/ui/componants/type_text_field.dart';
import 'package:empoweromics/ui/screens/complete_data/screen.dart';
import 'package:empoweromics/ui/screens/login/cubit.dart';
import 'package:empoweromics/ui/screens/verification/screen.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends BaseStatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BaseStatefulWidgetState<LoginScreen> {
  LoginCubit cubit = LoginCubit();
  final inputsFormKey = GlobalKey<FormState>();
  TextEditingController mobileNumberTextEditingController =
      TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  GoogleSignIn _googleSignIn;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: AppSvg.load("assets/icons/ic_back_arrow.svg"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          leadingWidth: AppSizes.w0_17,
        ),
        body: BlocListener<LoginCubit, BaseState>(
            bloc: cubit,
            listener: (BuildContext context, state) {
              if (state is LoadingState) {
                onLoading(state.isLoading);
              } else if (state is ErrorState) {
                onApiError(state.response);
              } else if (state is LoginResponseState) {
                _onLoginResponse(state.response);
              }
            },
            child: Container(
              color: AppColors.white,
              child: Form(
                  key: inputsFormKey,
                  child: Center(
                    child: SingleChildScrollView(
                        child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppSizes.w0_116),
                      child: Column(children: <Widget>[
                        Image.asset(
                          'assets/images/logo.png',
                          height: AppSizes.h0_221,
                        ),
                        SizedBox(
                          height: AppSizes.h0_056,
                        ),
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text('login'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppSizes.txt_20))),
                        SizedBox(
                          height: AppSizes.h0_01,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text('login_with_your_phone_number'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xB3313131),
                                  fontSize: AppSizes.txt_16)),
                        ),
                        SizedBox(
                          height: AppSizes.h0_018,
                        ),
                        TypeTextField(
                            labelText: 'insert_mobile_number'.tr,
                            textInputType: TextInputType.number,
                            textEditingController:
                                mobileNumberTextEditingController,
                            validator: validation.isNotEmpty),
                        SizedBox(
                          height: AppSizes.h0_018,
                        ),
                        AppButton(
                          text: 'login'.tr,
                          onPressed: _onLoginClick,
                          color: AppColors.colorPrimary,
                        ),
                        SizedBox(
                          height: AppSizes.h0_018,
                        ),
                        Text('or'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: const Color(0xB3313131),
                                fontSize: AppSizes.txt_16)),
                        SizedBox(
                          height: AppSizes.h0_018,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: _onGoogleSignInClick,
                                child: SvgPicture.asset(
                                    "assets/icons/ic_google.svg")),
                            SizedBox(
                              width: AppSizes.w0_05,
                            ),
                            GestureDetector(
                                onTap: _onFacebookLoginClick,
                                child: SvgPicture.asset(
                                    "assets/icons/ic_facebook.svg"))
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.h0_018,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(fontSize: AppSizes.txt_15),
                            children: [
                              TextSpan(
                                  text: 'notice'.tr,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: AppSizes.txt_15,
                                    fontFamily: 'din',
                                  )),
                              TextSpan(
                                  text: 'completing_the_registration_you_agree'
                                      .tr,
                                  style: TextStyle(
                                      color: AppColors.gray,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'din',
                                      fontSize: AppSizes.txt_15)),
                              TextSpan(
                                  text:
                                      'on_terms_and_conditions_in_the_empoweromics'
                                          .tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      log('Shady');
                                    },
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black,
                                    fontSize: AppSizes.txt_15,
                                    fontFamily: 'din',
                                  )),
                            ],
                          ),
                        )
                      ]),
                    )),
                  )),
            )));
  }

  bool _isValid() {
    return inputsFormKey.currentState.validate();
  }

  void _onLoginResponse(AuthResponse response) {}

  void _onLoginClick() {
    if (!_isValid()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              VerificationScreen(mobileNumberTextEditingController.text)),
    ).then((value) {
      if (value != null) {
        _requestLogin(value, mobileNumberTextEditingController.text);
      }
    });
  }

  Future<void> _onGoogleSignInClick() async {
    try {
      await _googleSignIn.signOut();
      GoogleSignInAccount account = await _googleSignIn.signIn();
      _requestLogin(account.id, null);
    } catch (error) {
      print(error);
    }
  }

  void _requestLogin(value, mobile) {
    final docRef = db.collection("users").doc(value);
    docRef.get().then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          User user = User.fromJson(data);
          if (user.is_data_completed) {
            UserPreferences.setName(user.name);
            UserPreferences.setEmail(user.email);

            Navigator.pop(context);
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => CompleteDataScreen(
                        userId: value,
                        mobile: mobile,
                      )),
            );
          }
        } else {
          db
              .collection("users")
              .doc(value)
              .set(User(id: value, is_data_completed: false, mobile: mobile)
                  .toJson())
              .onError((e, _) => print("Error writing document: $e"));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CompleteDataScreen(
                    userId: value,
                    mobile: mobileNumberTextEditingController.text)),
          );
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> _onFacebookLoginClick() async {
    // Create an instance of FacebookLogin
    final fb = FacebookLogin();
    await fb.logOut();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
      FacebookPermission.userFriends,
    ]);

    switch (res.status) {
      case FacebookLoginStatus.success:
        final profile = await fb.getUserProfile();
        _requestLogin(profile.userId, null);

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }
}
