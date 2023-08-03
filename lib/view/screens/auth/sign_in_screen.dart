import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/localization_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/custom_text_field.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/web_menu_bar.dart';
import 'package:sixam_mart/view/screens/auth/widget/code_picker_widget.dart';
import 'package:sixam_mart/view/screens/auth/widget/condition_check_box.dart';
import 'package:sixam_mart/view/screens/auth/widget/guest_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/store_model.dart';
import '../../../util/app_constants.dart';
import '../../base/custom_app_bar.dart';

class SignInScreen extends StatefulWidget {
  final bool exitFromApp;

  SignInScreen({@required this.exitFromApp});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _countryDialCode;
  bool _canExit = GetPlatform.isWeb ? true : false;
  bool _showPassword = true;

  @override
  void initState() {
    super.initState();

    _countryDialCode =
        Get.find<AuthController>().getUserCountryCode().isNotEmpty
            ? Get.find<AuthController>().getUserCountryCode()
            : CountryCode.fromCountryCode(
                    Get.find<SplashController>().configModel.country)
                .dialCode;
    _emailController.text = Get.find<AuthController>().getUserNumber() ?? '';
    _passwordController.text =
        Get.find<AuthController>().getUserPassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.exitFromApp) {
          if (_canExit) {
            if (GetPlatform.isAndroid) {
              SystemNavigator.pop();
            } else if (GetPlatform.isIOS) {
              exit(0);
            } else {
              Navigator.pushNamed(context, RouteHelper.getInitialRoute());
            }
            return Future.value(false);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('back_press_again_to_exit'.tr,
                  style: TextStyle(color: Colors.white)),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            ));
            _canExit = true;
            Timer(Duration(seconds: 2), () {
              _canExit = false;
            });
            return Future.value(false);
          }
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: ResponsiveHelper.isDesktop(context)
            ? WebMenuBar()
            : /*!widget.exitFromApp
                ?*/
            CustomAppBar(
                title: 'Sign In'.tr, onBackPressed: () => {Get.back()}),
        /*: null*/
        endDrawer: MenuDrawer(),
        body: SafeArea(
          child: /*Center(
          child: */
              Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: FooterView(
                child: Container(
                  width: context.width > 700 ? 700 : context.width,
                  padding: context.width > 700
                      ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                      : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  margin: context.width > 700
                      ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                      : EdgeInsets.zero,
                  decoration: context.width > 700
                      ? BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[Get.isDarkMode ? 700 : 300],
                                blurRadius: 5,
                                spreadRadius: 1)
                          ],
                        )
                      : null,
                  child: GetBuilder<AuthController>(builder: (authController) {
                    return Stack(children: [
                      Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Column(children: [
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: Dimensions.RADIUS_SMALL,
                                  right: Dimensions.RADIUS_SMALL),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).disabledColor),
                                color: Colors.transparent,
                              ),
                              child: Row(children: [
                                SizedBox(width: 10),
                                Expanded(
                                    child: TextButton(
                                  onPressed: () => {
                                    authController.changeLogin(),
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: authController.forUser
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3)
                                        : null,
                                    shape: authController.forUser
                                        ? RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_EXTRA_LARGE),
                                          )
                                        : null,
                                  ),
                                  child: Text('For User'.tr,
                                      textAlign: TextAlign.center,
                                      style: robotoBold.copyWith(
                                        color: !authController.forUser
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color
                                            : Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeDefault,
                                      )),
                                )),
                                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                Expanded(
                                    child: TextButton(
                                  onPressed: () => {
                                    {
                                      authController.changeLogin(),
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: !authController.forUser
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3)
                                        : null,
                                    shape: !authController.forUser
                                        ? RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_EXTRA_LARGE),
                                          )
                                        : null,
                                  ),
                                  child: Text('Security Officer'.tr,
                                      textAlign: TextAlign.center,
                                      style: robotoRegular.copyWith(
                                        color: authController.forUser
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color
                                            : Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeDefault,
                                      )),
                                )),
                                SizedBox(width: 10),
                              ]),
                            ),

                            SizedBox(height: 20),
                            Container(
                              child: Column(children: [
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_LARGE),
                                    child: Divider(height: 1)),
                                CustomTextField(
                                  hintText: 'Enter your email'.tr,
                                  controller: _emailController,
                                  focusNode: _passwordFocus,
                                  inputAction: TextInputAction.next,
                                  inputType: TextInputType.emailAddress,
                                  prefixIcon: 'email',
                                  isPassword: false,
                                  onSubmit: (text) => (GetPlatform.isWeb &&
                                          authController.acceptTerms)
                                      ? _login(authController, _countryDialCode)
                                      : null,
                                ),
                                SizedBox(height: 10),
                                if (_showPassword)
                                  CustomTextField(
                                    hintText: 'password'.tr,
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    inputAction: TextInputAction.done,
                                    inputType: TextInputType.visiblePassword,
                                    prefixIcon: 'lock',
                                    isPassword: true,
                                    onSubmit: (text) => (GetPlatform.isWeb &&
                                            authController.acceptTerms)
                                        ? _login(
                                            authController, _countryDialCode)
                                        : null,
                                  ),
                              ]),
                            ),
                            SizedBox(height: 10),
                            if (_showPassword)
                              Row(children: [
                                Expanded(
                                  child: Text(''.tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    /* if (_phoneController.text.isEmpty) {
                                showCustomSnackBar('enter_phone_number'.tr);
                              } else {*/
                                    Get.toNamed(RouteHelper.getForgotPassRoute(
                                        false, null, _emailController.text));
                                    /*}*/
                                  },
                                  child: Text(
                                    '${'forgot_password'.tr}?',
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context).hintColor),
                                  ),
                                ),
                              ]),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                            if (_showPassword)
                              /*!authController.isLoading ?*/ Row(children: [
                                /* Expanded(
                              child: CustomButton(
                            buttonText: 'sign_up'.tr,
                            transparent: true,
                            onPressed: () =>
                                Get.toNamed(RouteHelper.getSignUpRoute("")),
                          )),*/
                                Expanded(
                                    child: CustomButton(
                                  buttonText: 'sign_in'.tr,
                                  onPressed: authController.acceptTerms
                                      ? () => _login(
                                          authController, _countryDialCode)
                                      : null,
                                )),
                              ]) /*: Center(child: CircularProgressIndicator())*/,
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                            // SocialLoginWidget(),
                            Row(children: [
                              Expanded(
                                  child: Image.asset(Images.line,
                                      height: 5, fit: BoxFit.contain)),
                              SizedBox(
                                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Text(
                                'OR'.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                              ),
                              SizedBox(
                                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Expanded(
                                  child: Image.asset(Images.line,
                                      height: 5, fit: BoxFit.contain)),
                            ]),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: Dimensions.RADIUS_SMALL,
                                  right: Dimensions.RADIUS_SMALL),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).disabledColor),
                                color: Colors.transparent,
                              ),
                              child: Row(children: [
                                SizedBox(width: 10),
                                Image.asset(Images.google,
                                    height: 20, fit: BoxFit.contain),
                                Expanded(
                                    child: TextButton(
                                  onPressed: () => {
                                    authController.changeLogin(),
                                  },
                                  child: Text('Sign in with Google'.tr,
                                      textAlign: TextAlign.center,
                                      style: robotoBold.copyWith(
                                        color: !authController.forUser
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color
                                            : Theme.of(context).hintColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                )),
                              ]),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: Dimensions.RADIUS_SMALL,
                                  right: Dimensions.RADIUS_SMALL),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).disabledColor),
                                color: Colors.transparent,
                              ),
                              child: Row(children: [
                                SizedBox(width: 10),
                                Image.asset(Images.apple,
                                    height: 20, fit: BoxFit.contain),
                                Expanded(
                                    child: TextButton(
                                  onPressed: () => {
                                    authController.changeLogin(),
                                  },
                                  child: Text('Sign in with Apple'.tr,
                                      textAlign: TextAlign.center,
                                      style: robotoBold.copyWith(
                                        color: !authController.forUser
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color
                                            : Theme.of(context).hintColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                )),
                              ]),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: Dimensions.RADIUS_SMALL,
                                  right: Dimensions.RADIUS_SMALL),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35.0),
                                border: Border.all(
                                    width: 1,
                                    color: Theme.of(context).disabledColor),
                                color: Colors.transparent,
                              ),
                              child: Row(children: [
                                SizedBox(width: 10),
                                Image.asset(Images.facebook,
                                    height: 20, fit: BoxFit.contain),
                                Expanded(
                                    child: TextButton(
                                  onPressed: () => {
                                    authController.changeLogin(),
                                  },
                                  child: Text('Sign in with Facebook'.tr,
                                      textAlign: TextAlign.center,
                                      style: robotoBold.copyWith(
                                        color: !authController.forUser
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color
                                            : Theme.of(context).hintColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                )),
                              ]),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                            /* GuestButton(),*/
                          ])),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child:
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account? '.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).dividerColor,
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(RouteHelper.getSignUpRoute(""));
                                },
                                child: Text(
                                  ' Sign Up'.tr,
                                  textAlign: TextAlign.center,
                                  style: robotoBold.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                ),
                              ),
                            ]),
                      ),

                      /* ]),*/
                    ]);
                  }),
                ),
              ),
            ),
          ), /*)*/
        ),
      ),
    );
  }

  void _login(AuthController authController, String countryDialCode) async {
    String _phone = _emailController.text.trim();
    String _password = _passwordController.text.trim();
    String _numberWithCountryCode = countryDialCode + _phone;
    AppConstants.StoreID = AppConstants.ParantStoreID;

    bool _isValid = GetPlatform.isWeb ? true : false;
    /*if (!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber =
            await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode =
            '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }*/
    if (_phone.isEmpty) {
      showCustomSnackBar('Enter Email Address'.tr);
    }
    /*else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }*/
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else {
     /* authController
          .new_login(_numberWithCountryCode, _password)
          .then((status) async {
        if (status.statusCode == 200) {
          if (authController.isActiveRememberMe) {
            authController.saveUserNumberAndPassword(
                _phone, _password, countryDialCode);
          } else {
            authController.clearUserNumberAndPassword();
          }

          // String _token = status.message.substring(1, status.message.length);
          String _token = status.body['token'];

          if (Get.find<SplashController>().configModel.customerVerification &&
              status.body['is_phone_verified'] == 0) {
            List<int> _encoded = utf8.encode(_password);
            String _data = base64Encode(_encoded);

            Get.toNamed(RouteHelper.getVerificationRoute(
                _numberWithCountryCode, _token, RouteHelper.signUp, _data));
          } else {
            Get.find<BannerController>().getBranchList(true);

            Get.find<StoreController>()
                .getStoreDetails(Store(id: AppConstants.StoreID), true);

            Get.find<StoreController>()
                .getStoreItemList(AppConstants.StoreID, 1, 'all', false);
            Get.toNamed(RouteHelper.getAccessLocationRoute('sign-in'));
          }
        } else {
          // showCustomSnackBar(status.message);
          showCustomSnackBar(status.body["errors"] != null
              ? status.body["errors"][0]["message"].toString()
              : status.statusText);
        }
      });*/
      Get.offAllNamed(RouteHelper.getInitialRoute());
    }
  }
}
