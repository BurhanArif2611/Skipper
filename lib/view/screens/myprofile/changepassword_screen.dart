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
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/logout_confirmation.dart';
import '../../base/paginated_list_view.dart';
import '../profile/widget/profile_bg_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FocusNode _currentPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();


  void _loadData() async {
    Get.find<NotificationController>().clearNotification();
    if (Get.find<SplashController>().configModel == null) {
      await Get.find<SplashController>().getConfigData();
    }
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<NotificationController>().getNotificationList(1, true);
    }
  }

  @override
  void initState() {
    super.initState();

    // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
          title: 'Change Password'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
          ),
      endDrawer: MenuDrawer(),
      body: Get.find<AuthController>().isLoggedIn()
           ?GetBuilder<UserController>(builder: (userController) {
    return !userController.isLoading &&
    userController.userDetailModel != null
    ?
              Scrollbar(
          child: SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                margin: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                child: Center(
                  child: Column(children: [
                    SizedBox(
                      height: Dimensions.RADIUS_LARGE,
                    ),

                    CustomTextField(
                      hintText: 'Enter old password'.tr,
                      controller: _currentPasswordController,
                      focusNode: _currentPasswordFocus,
                      nextFocus: _newPasswordFocus,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: 'lock',
                      isPassword: true,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      hintText: 'Enter new password'.tr,
                      controller: _newPasswordController,
                      focusNode: _newPasswordFocus,
                      nextFocus: _confirmPasswordFocus,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: 'lock',
                      isPassword: true,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      hintText: 'Confirm password'.tr,
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.visiblePassword,
                      prefixIcon: 'lock',
                      isPassword: true,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Spacer(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          buttonText: ' Save Changes'.tr,

                          onPressed: () {
                            _updateProfile(userController);
                          },
                        ),
                      ),
                    ),






                  ]),
                ),
              ))) : Center(child: CircularProgressIndicator())
        ;
        })
          : NotLoggedInScreen(),
    );
  }

  void _updateProfile(UserController userController) async {
    String _currentPassword = _currentPasswordController.text.toString();
    String _newPassword = _newPasswordController.text.toString();
    String _confirmPassword = _confirmPasswordController.text.toString();

     if (_currentPassword.isEmpty) {
      showCustomSnackBar('Enter current password'.tr);
    }else if (_newPassword.isEmpty) {
      showCustomSnackBar('Enter new password'.tr);
    }else if (_confirmPassword.isEmpty) {
      showCustomSnackBar('Enter confirm password'.tr);
    }else {
      ResponseModel _responseModel = await userController.changePassword(
          _currentPassword,_newPassword,_confirmPassword);
      if (_responseModel.isSuccess) {
        showCustomSnackBar('Password changed successfully'.tr, isError: false);
      } else {
        showCustomSnackBar(_responseModel.message);
      }
    }
  }
}
