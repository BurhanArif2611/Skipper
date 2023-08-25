import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/dashboard_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/screens/notification/widget/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../data/model/response/response_model.dart';
import '../../../data/model/response/userinfo_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/logout_confirmation.dart';
import '../../base/paginated_list_view.dart';
import '../profile/widget/profile_bg_widget.dart';

class PersonalProfileScreen extends StatefulWidget {
  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _anonymousController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _anonymousFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();


  void _loadData() async {
    try {
      if (Get.find<UserController>().userDetailModel != null) {
        _firstNameController.text =
            Get.find<UserController>().userDetailModel.name.first ?? '';
        _lastNameController.text =
            Get.find<UserController>().userDetailModel.name.last ?? '';
        _phoneController.text =
            Get.find<UserController>().userDetailModel.mobileNumber ?? '';
        _anonymousController.text =
            Get.find<UserController>().userDetailModel.anonymous ?? '';
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: InnerCustomAppBar(
        title: 'Personal Profile'.tr,
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
     /* endDrawer: MenuDrawer(),*/
      body: Get.find<AuthController>().isLoggedIn()
          ? GetBuilder<UserController>(builder: (userController) {
              return !userController.isLoading
                  &&
              userController.userDetailModel != null
                      ? SizedBox(
                          height: MediaQuery.of(context)
                              .size
                              .height, // Set the desired height here
                          child: Scrollbar(
                              child: SingleChildScrollView(
                                  controller: scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.all(
                                        Dimensions.RADIUS_DEFAULT),
                                    margin: EdgeInsets.all(
                                        Dimensions.RADIUS_DEFAULT),
                                    child: Center(
                                      child: Column(children: [
                                        SizedBox(
                                          height: Dimensions.RADIUS_LARGE,
                                        ),
                                        CustomTextField(
                                          hintText: 'Enter First Name'.tr,
                                          controller: _firstNameController,
                                          focusNode: _firstNameFocus,
                                          nextFocus: _lastNameFocus,
                                          inputType: TextInputType.name,
                                          capitalization:
                                              TextCapitalization.words,
                                          prefixIcon: Images.user,
                                          divider: false,
                                        ),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE),
                                        CustomTextField(
                                          hintText: 'Enter Last Name'.tr,
                                          controller: _lastNameController,
                                          focusNode: _lastNameFocus,
                                          nextFocus: _phoneFocus,
                                          inputType: TextInputType.name,
                                          capitalization:
                                              TextCapitalization.words,
                                          prefixIcon: Images.user,
                                          divider: false,
                                        ),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE),
                                        CustomTextField(
                                          hintText: '+234 12345 78945'.tr,
                                          controller: _phoneController,
                                          focusNode: _phoneFocus,
                                          nextFocus: _anonymousFocus,
                                          inputType: TextInputType.name,
                                          capitalization:
                                              TextCapitalization.words,
                                          prefixIcon: Images.call,
                                          divider: false,
                                        ),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE),
                                        CustomTextField(
                                          hintText: 'Anonymous Name'.tr,
                                          controller: _anonymousController,
                                          focusNode: _anonymousFocus,
                                          inputType: TextInputType.name,
                                          capitalization:
                                              TextCapitalization.words,
                                          prefixIcon: Images.user,
                                          divider: false,
                                        ),
                                        SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_EXTRA_LARGE),
                                        Spacer(),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: CustomButton(
                                              buttonText: ' Save Changes'.tr,
                                              onPressed: () {
                                                print("dfjdfj");
                                                _updateProfile(userController);
                                              },
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ))))
                      :Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
                  ;
            })
          : NotLoggedInScreen(),
    );
  }

  void _updateProfile(UserController userController) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _anonymous = _anonymousController.text.toString();
    String _phoneNumber = _phoneController.text.trim();
    if (userController.userDetailModel.name.first == _firstName &&
        userController.userDetailModel.name.last == _lastName &&
        userController.userDetailModel.mobileNumber == _phoneNumber &&
        userController.userDetailModel.anonymous == _anonymousController.text) {
      showCustomSnackBar('change_something_to_update'.tr);
    } else if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    } else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    } else if (_phoneNumber.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    } else if (_phoneNumber.length < 6) {
      showCustomSnackBar('enter_a_valid_phone_number'.tr);
    } else {
      ResponseModel _responseModel = await userController.updateUserInfo(
          _firstName,
          _lastName,
          _phoneNumber,
          _anonymous,
          userController.userDetailModel.email,
          Get.find<AuthController>().getUserToken());
      if (_responseModel.isSuccess) {
        showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
      } else {
        showCustomSnackBar(_responseModel.message);
      }
    }
  }
}
