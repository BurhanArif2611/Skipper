import 'package:country_code_picker/country_code.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/home_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/theme_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/body/signup_body.dart';
import '../../../data/model/response/user_detail_model.dart';
import '../../../helper/date_converter.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../auth/widget/code_picker_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

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

   /* if (_isLoggedIn *//*&& Get.find<UserController>().userInfoModel == null*//*) {
      Get.find<UserController>().getUserInfo();
    }*/


    if(Get.find<HomeController>().userDetailModel!=null){
      UserDetailModel _userDetailModel=Get.find<HomeController>().userDetailModel;

      _firstNameController.text=_userDetailModel.name.toString();
      _lastNameController.text=_userDetailModel.surname.toString();
      _emailController.text=_userDetailModel.username.toString();
      selectDate=_userDetailModel.birthDate.toString();
     // selectedSex=_userDetailModel.gender.toString();
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


    return Scaffold(
      appBar: CustomAppBar(
          title: 'Profile', onBackPressed: () => {Get.back()}),
     /* endDrawer: MenuDrawer(),*/
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child:
      GetBuilder<AuthController>(builder: (authController) {
        return /*(_isLoggedIn && userController.userInfoModel == null)*/
            Container(
              color: Theme.of(context).backgroundColor,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,

                children: [
                SizedBox(
                  height: 40,
                ),
                  Center(
                    child: CircleImageWithCameraIcon(
                      imageUrl: 'https://via.placeholder.com/150',
                      imageSize: 100.0,
                      cameraIconSize: 20.0,
                    ),
                  ),
                  SizedBox(
                  height: 40,
                ),
                Text(
                  "Beneficiary Name",
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).cardColor),
                ),
                SizedBox(
                  height: 5,
                ),
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

                CustomButton(
                  height: 50,
                  buttonText: 'Update'.tr,
                  onPressed:  () {
                    /*Get.back();*/
                    updateProfile(authController,_countryDialCode);
                    //Get.toNamed(RouteHelper.getKYCSuccessScreenRoute());
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],),);
      })),
    );
  }
  void updateProfile(AuthController authController, String countryCode) async {
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
          secured: "",
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
      authController.updateProfile(signUpBody).then((status) async {
        if (status.statusCode == 200) {
          if (status.body['metadata']['code'] == 200 ||
              status.body['metadata']['code'] == "200") {
            Get.back();
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

class CircleImageWithCameraIcon extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  final double cameraIconSize;

  CircleImageWithCameraIcon({
    @required this.imageUrl,
    @required this.imageSize,
    @required this.cameraIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                width: 1,
                color: Theme.of(context)
                    .cardColor
                    .withOpacity(0.50)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2.0),
            ),
            child: Icon(
              Icons.camera_alt,
              size: cameraIconSize,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}



