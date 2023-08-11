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

class EmailAddressScreen extends StatefulWidget {
  @override
  State<EmailAddressScreen> createState() => _EmailAddressScreenState();
}

class _EmailAddressScreenState extends State<EmailAddressScreen> {

  final TextEditingController _currentEmailController = TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final FocusNode _currentEmailFocus = FocusNode();
  final FocusNode _newEmailFocus = FocusNode();
  void _loadData() async {
    try {
      if (Get.find<UserController>().userDetailModel != null) {
        _currentEmailController.text =
            Get.find<UserController>().userDetailModel.email?? '';

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
        title: 'Email Address'.tr,
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
      endDrawer: MenuDrawer(),
      body: Get.find<AuthController>().isLoggedIn()
          ? GetBuilder<UserController>(builder: (userController) {
              return !userController.isLoading &&
                   userController.userDetailModel != null
                      ? Scrollbar(
                          child: SingleChildScrollView(
                              controller: scrollController,
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                padding:
                                    EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                                margin:
                                    EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                                child: Center(
                                  child: Column(children: [
                                    SizedBox(
                                      height: Dimensions.RADIUS_LARGE,
                                    ),
                                    CustomTextField(
                                      hintText: 'Enter Current email'.tr,
                                       controller: _currentEmailController,
                      focusNode: _currentEmailFocus,
                      nextFocus: _newEmailFocus,
                                      inputType: TextInputType.emailAddress,
                                      capitalization: TextCapitalization.words,
                                      prefixIcon: Images.mail,
                                      divider: false,
                                    ),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE),
                                    CustomTextField(
                                      hintText: 'Enter New email'.tr,
                                       controller: _newEmailController,
                                       focusNode: _newEmailFocus,

                                      inputType: TextInputType.emailAddress,
                                      capitalization: TextCapitalization.words,
                                      prefixIcon: Images.mail,
                                      divider: false,
                                    ),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE),
                                    Spacer(),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CustomButton(
                                          buttonText: ' Save Changes'.tr,
                                          onPressed: ()   {
                                            _updateProfile(userController);
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              )))
                      : Center(child: CircularProgressIndicator())
              ;
            })
          : NotLoggedInScreen(),
    );
  }
  void _updateProfile(UserController userController) async {
    String _email = _currentEmailController.text.toString();
    String _newEmail = _newEmailController.text.toString();
    print("_newEmail>>>"+_newEmail);
    if (userController.userDetailModel.email== _email &&
        userController.userDetailModel.email == _newEmail ) {
      showCustomSnackBar('change_something_to_update'.tr);
    } else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    }else if (_newEmail.isEmpty) {
      showCustomSnackBar('Enter your new email address'.tr);
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    }else if (!GetUtils.isEmail(_newEmail)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    }else {
      ResponseModel _responseModel = await userController.updateUserInfo(
          userController.userDetailModel.name.first,
          userController.userDetailModel.name.last,
          userController.userDetailModel.mobileNumber,
          userController.userDetailModel.anonymous,
          _newEmail,
          Get.find<AuthController>().getUserToken());
      if (_responseModel.isSuccess) {
        showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
      } else {
        showCustomSnackBar(_responseModel.message);
      }
    }
  }
}
