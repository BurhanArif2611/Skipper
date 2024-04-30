import 'dart:convert';

import 'package:country_code_picker/country_code.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import '../../../helper/date_converter.dart';
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
  DateTime selectedDate = DateTime.now();
  String selectDate = '';
  String selectedSex;
  final List<String> items = [
    'Male',
    'Female',
    'Other',
  ];

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectDate = DateConverter.is_oStringToLocalDateOnly(picked.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("number>>>" + widget.number.toString());
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? WebMenuBar()
          : CustomAppBar(
              title: 'Sign Up'.tr, onBackPressed: () => {Get.back()},showCart:false),
      /* endDrawer: MenuDrawer(),*/
      body: SafeArea(
          child: Container(
        color: Theme.of(context).backgroundColor,
        child:
            /*Scrollbar(
        child:*/
            SingleChildScrollView(
          padding: ResponsiveHelper.isDesktop(context)
              ? EdgeInsets.zero
              : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          physics: BouncingScrollPhysics(),
          child: Container(
            width: context.width,
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
                : BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
            child: GetBuilder<SplashController>(builder: (splashController) {
              return GetBuilder<AuthController>(builder: (authController) {
                return Container(
                    color: Theme.of(context).backgroundColor,
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      SizedBox(height: 10),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Create an Account",
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeOverLarge,
                                color: Theme.of(context).primaryColor),
                          )),
                      SizedBox(
                        height: 20,
                      ),
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
                            onSubmit: (text) => (GetPlatform.isWeb &&
                                    authController.acceptTerms)
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context)
                                      .cardColor
                                      .withOpacity(0.70)),
                            ),
                            padding: EdgeInsets.only(left: 15, right: 20),
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                                onTap: () {
                                  _selectDate(context);
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SvgPicture.asset(
                                      Images.calender,
                                      width: 20,
                                      height: 20,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      selectDate != ""
                                          ? selectDate
                                          : 'Select DOB'.tr,
                                      textAlign: TextAlign.start,
                                      style: robotoRegular.copyWith(
                                          fontSize: Dimensions.fontSizeLarge,
                                          color: selectDate != ""
                                              ? Theme.of(context).cardColor
                                              : Color(0xFFA1A8B0)),
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Text(
                                            'Select Gender',
                                            style: robotoRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                                color: Colors.white),
                                          )),
                                    ),
                                  ],
                                ),
                                items: items
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedSex,
                                onChanged: (String value) {
                                  setState(() {
                                    selectedSex = value;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.70),
                                        width: 1),
                                  ),
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor:
                                      Theme.of(context).primaryColor,
                                  iconDisabledColor: Colors.grey,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                  ),
                                  offset: Offset(-50, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: Radius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        ]),
                      ),
                      ConditionCheckBox(authController: authController),

                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                      /* !authController.isLoading ?*/
                      Row(children: [
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
                              ? () =>
                                  _register(authController, _countryDialCode)
                              : null,
                        )),
                      ]) /* : Center(child: CircularProgressIndicator())*/,
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? '.tr,
                              textAlign: TextAlign.center,
                              style: robotoBold.copyWith(
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.50),
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RouteHelper.getSignInRoute(
                                    RouteHelper.signUp));
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
        /* )*/
      )),
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
    }
    /* else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }*/
    else if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 8) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    } else if (_anonymous.isEmpty) {
      showCustomSnackBar('Enter valid anonymous'.tr);
    } else if (selectDate.isEmpty) {
      showCustomSnackBar('Enter valid DOB'.tr);
    } else if (selectedSex.isEmpty) {
      showCustomSnackBar('Enter valid Gender'.tr);
    } else {
      SignUpBody signUpBody = SignUpBody(
          name: _firstName,
          surname: _lastName,
          email: _email,
          phone: countryCode + _number,
          password: _password,
          username: _email,
          birthDate: selectDate,
          gender: selectedSex,
          enabled: true,
          note: "",
          roles: "user",
          creationDt: DateTime.now().toString(),
          updatedDt: DateTime.now().toString(),
          loginDt: "",
          secured: false,
          skype: "",
          facebook: "",
          linkedin: "",
          website: "",
          contactNote: "",
          address: "",
          address2: "",
          city: "",
          country: countryCode,
          zipCode: "");
      authController.registration(signUpBody).then((status) async {
        if (status.statusCode == 200) {
          if (status.body['metadata']['code'] == 200 ||
              status.body['metadata']['code'] == "200") {
            Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.signUp));
          } else {
            showCustomSnackBar(status.body['metadata']['message']);
          }
        } else {
          showCustomSnackBar(status.body["message"]);
        }
      });
    }
  }
}
