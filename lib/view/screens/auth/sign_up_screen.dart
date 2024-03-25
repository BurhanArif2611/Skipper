import 'dart:convert';

import 'package:country_code_picker/country_code.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/body/signup_body.dart';
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
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';

import '../../../controller/home_controller.dart';
import '../../base/custom_app_bar.dart';

class SignUpScreen extends StatefulWidget {
  final String number;

  SignUpScreen({@required this.number});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _referCodeFocus = FocusNode();
  final FocusNode _annoymousNameFocus = FocusNode();
  final FocusNode _securityIdFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _anonymousController = TextEditingController();
  final TextEditingController _securityIDController = TextEditingController();
  String _countryDialCode;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.number.toString();
    if (Get.find<SplashController>().configModel != null &&
        Get.find<SplashController>().configModel.country != null) {
      _countryDialCode = CountryCode.fromCountryCode(
              Get.find<SplashController>().configModel.country)
          .dialCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("number>>>" + widget.number.toString());
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? WebMenuBar()
          : CustomAppBar(
              title: 'Sign Up'.tr, onBackPressed: () => {Get.back()}),
     /* endDrawer: MenuDrawer(),*/
      body: SafeArea(
          child:Container(color: Theme.of(context).backgroundColor,
          child:
          Scrollbar(
        child: SingleChildScrollView(
          padding: ResponsiveHelper.isDesktop(context)
              ? EdgeInsets.zero
              : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          physics: BouncingScrollPhysics(),
          child:
            Container(
              width:  context.width,
              height:  context.height-50,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              decoration: context.width > 700
                  ? BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[Get.isDarkMode ? 700 : 300],
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                    )
                  :  BoxDecoration(
                  color: Theme.of(context).backgroundColor,),
              child: GetBuilder<SplashController>(builder: (splashController) {
                return GetBuilder<AuthController>(builder: (authController) {
                  return
                    Container(
                        color: Theme.of(context).backgroundColor,
                        child:
                    Column(children: [
                    SizedBox(height: 10),
                      Align(alignment: Alignment.topLeft,
                          child:

                          Text("Create an Account",style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge,color: Theme.of(context).primaryColor),)),
                      SizedBox(height: 20,),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      /*decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        color: Theme.of(context).cardColor,
                        boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
                      ),*/
                      child: Column(children: [
                        CustomTextField(
                          hintText: 'first_name'.tr,
                          controller: _firstNameController,
                          focusNode: _firstNameFocus,
                          nextFocus: _lastNameFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          prefixIcon: Images.user,
                          divider: false,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        CustomTextField(
                          hintText: 'last_name'.tr,
                          controller: _lastNameController,
                          focusNode: _lastNameFocus,
                          nextFocus: _emailFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          prefixIcon: Images.user,
                          divider: false,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        CustomTextField(
                          hintText: 'email'.tr,
                          controller: _emailController,
                          focusNode: _emailFocus,
                          nextFocus: _phoneFocus,
                          inputType: TextInputType.emailAddress,
                          prefixIcon: Images.mail,
                          divider: false,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  child: CodePickerWidget(
                                    onChanged: (CountryCode countryCode) {
                                      _countryDialCode = countryCode.dialCode;
                                    },
                                    /*initialSelection: CountryCode.fromCountryCode(
                                          Get.find<SplashController>()
                                              .configModel
                                              .country).code,*/
                                    initialSelection: "+234",
                                    /*favorite: [
                                    CountryCode.fromCountryCode(
                                            Get.find<SplashController>()
                                                .configModel
                                                .country)
                                        .code
                                  ],*/
                                    showDropDownButton: true,
                                    padding: EdgeInsets.zero,
                                    showFlagMain: true,
                                    dialogBackgroundColor:
                                        Theme.of(context).cardColor,
                                    textStyle: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                    ),
                                  )),
                              SizedBox(width: Dimensions.RADIUS_SMALL),
                              Expanded(
                                  child: CustomTextField(
                                hintText: 'phone'.tr,
                                controller: _phoneController,
                                focusNode: _phoneFocus,
                                nextFocus: _passwordFocus,
                                inputType: TextInputType.phone,
                                divider: false,
                                prefixIcon: Images.call,
                                maxLength: 11,
                              )),
                            ]),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
/*
                        Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE), child: Divider(height: 1)),
*/

                        CustomTextField(
                          hintText: 'password'.tr,
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          nextFocus: _confirmPasswordFocus,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: 'lock',
                          isPassword: true,
                          divider: false,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        CustomTextField(
                          hintText: 'confirm_password'.tr,
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocus,
                          nextFocus: _annoymousNameFocus,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.visiblePassword,
                          prefixIcon: 'lock',
                          isPassword: true,
                          onSubmit: (text) =>
                              (GetPlatform.isWeb && authController.acceptTerms)
                                  ? _register(authController, _countryDialCode)
                                  : null,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                        CustomTextField(
                          hintText: 'Anonymous Name'.tr,
                          controller: _anonymousController,
                          focusNode: _annoymousNameFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          prefixIcon: Images.user,
                          inputAction: TextInputAction.done,
                          divider: false,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        (authController.forUser?
                        Column(children: [


                        CustomTextField(
                          hintText: 'Security id number'.tr,
                          controller: _securityIDController,
                          focusNode: _securityIdFocus,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          prefixIcon: Images.latests_news,
                          inputAction: TextInputAction.done,
                          divider: false,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Upload ID Card",
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor.withOpacity(0.5),fontSize: Dimensions.fontSizeDefault),
                            )),
                        InkWell(
                            onTap: () {
                              openSelectImage(authController);
                            },
                            child: Container(
                              height: 200,
                              child: authController.rawFile != null
                                  ? Image.memory(
                                authController.rawFile,
                                fit: BoxFit.fitWidth,
                              )

                                  :
                              Image.asset(
                                Images.upload_photo_document,
                                fit: BoxFit.fill,
                                width:
                                MediaQuery.of(context).size.width,
                              ),
                            )),

                        ],):SizedBox()),
                      ]),
                    ),
                      ConditionCheckBox(authController: authController),

                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    /* !authController.isLoading ?*/ Row(children: [
                      /* Expanded(
                        child: CustomButton(
                      buttonText: 'sign_in'.tr,
                      transparent: true,
                      onPressed: () => Get.toNamed(
                          RouteHelper.getSignInRoute(RouteHelper.signUp)),
                    )),*/
                      Expanded(
                          child: CustomButton(
                        buttonText: 'sign_up'.tr,
                        onPressed: authController.acceptTerms
                            ? () => _register(authController, _countryDialCode)
                            : null,
                      )),
                    ]) /* : Center(child: CircularProgressIndicator())*/,
                    SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        'Already have an account? '.tr,
                        textAlign: TextAlign.center,
                        style: robotoBold.copyWith(
                          color: Theme.of(context).cardColor.withOpacity(0.50),
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(
                              RouteHelper.getSignInRoute(RouteHelper.signUp));
                        },
                        child: Text(
                          ' Sign In'.tr,
                          textAlign: TextAlign.center,
                          style: robotoBold.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 20),
                    // SocialLoginWidget(),

                    /* GuestButton(),*/
                  ]));
                });
              }),
            ),
            /* ),*/

        ),
      ))),
    );
  }

  void _register(AuthController authController, String countryCode) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _email = _emailController.text.trim();
    String _number = _phoneController.text.trim();
    String _password = _passwordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    String _anonymous = _anonymousController.text.trim();
    String _securityID = _securityIDController.text.trim();
    print("authController.forUser>>>>>> ${authController.forUser}");

    if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    } else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    } else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    } else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    } else if (_number.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    }else if (authController.forUser && _securityID.isEmpty) {
      showCustomSnackBar('enter security id number'.tr);
    }
    /*else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }*/
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    } else if (_anonymous.isEmpty) {
      showCustomSnackBar('Enter valid anonymous'.tr);
    }
    else if (authController.forUser && authController.uploadedURL.isEmpty &&  authController.uploadedURL=="") {
      showCustomSnackBar('select security id photo'.tr);
    }
    else {
      SignUpBody signUpBody = SignUpBody(
          fName: _firstName,
          lName: _lastName,
          email: _email,
          phone: _number,
          password: _password,
          refCode: _anonymous,
          scope: authController.forUser ? "6" : null,
          role: authController.forUser ? "6" : null,
      security_card_id:_securityID ,
      security_card_image: authController.uploadedURL);
      authController.registration(signUpBody).then((status) async {
        if (status.statusCode == 200) {
          Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.signUp));
        } else {
          showCustomSnackBar(status.body["message"]);
        }
      });
    }
  }


  void openSelectImage(AuthController homeController) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 260,
              padding: EdgeInsets.all(
                Dimensions.RADIUS_SMALL,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  border:
                  Border.all(width: 1, color: Theme.of(context).cardColor),
                  color: Theme.of(context).cardColor),
              // Set the desired height of the bottom sheet
              child: Column(
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Center(
                    child: SvgPicture.asset(Images.bottom_sheet_line,color: Theme.of(context).primaryColor,),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Choose For Attach File '.tr,
                        textAlign: TextAlign.center,
                        style: robotoBold.copyWith(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeExtraLarge,
                        )),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    margin: EdgeInsets.all(
                      Dimensions.RADIUS_SMALL,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1, color: Theme.of(context).disabledColor),
                      color: Colors.transparent,
                    ),
                    child: InkWell(
                        onTap: () {
                          homeController.pickImage();
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.gallery_image,color: Theme.of(context).primaryColor),
                          Expanded(
                            child: Text('Choose picture of gallery'.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Image.asset(Images.arrow_right_normal,
                              height: 10, fit: BoxFit.contain),
                          SizedBox(width: 10),
                        ])),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    margin: EdgeInsets.all(
                      Dimensions.RADIUS_SMALL,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1, color: Theme.of(context).disabledColor),
                      color: Colors.transparent,
                    ),
                    child: InkWell(
                        onTap: () {
                          homeController.pickCameraImage();
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.take_photo,color: Theme.of(context).primaryColor),
                          Expanded(
                            child: Text('Take a photo'.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Image.asset(Images.arrow_right_normal,
                              height: 10, fit: BoxFit.contain),
                          SizedBox(width: 10),
                        ])),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                ],
              ));
        },
        backgroundColor: Colors.transparent);
  }
}
