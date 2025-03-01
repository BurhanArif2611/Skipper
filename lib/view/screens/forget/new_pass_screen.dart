import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/data/model/response/userinfo_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';

import '../../../controller/home_controller.dart';

class NewPassScreen extends StatefulWidget {
  final String resetToken;
  final String number;
  final bool fromPasswordChange;

  NewPassScreen(
      {@required this.resetToken,
      @required this.number,
      @required this.fromPasswordChange});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    print("fromPasswordChange>>>${widget.fromPasswordChange}");
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.offAllNamed(RouteHelper.getInitialRoute()),
      child: Scaffold(
        appBar: CustomAppBar(
            title: widget.fromPasswordChange
                ? 'change_password'.tr
                : 'reset_password'.tr),
        endDrawer: MenuDrawer(),
        body: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).backgroundColor,
                child: Scrollbar(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: FooterView(
                      child: Container(
                    width: context.width > 700 ? 700 : context.width,
                    padding: context.width > 700
                        ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                        : null,
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Column(children: [
                      Text('enter_new_password'.tr,
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).cardColor),
                          textAlign: TextAlign.center),
                      SizedBox(height: 50),
                      Container(
                        padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),

                          /* boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],*/
                        ),
                        child: Column(children: [
                          CustomTextField(
                            hintText: 'new_password'.tr,
                            controller: _newPasswordController,
                            focusNode: _newPasswordFocus,
                            nextFocus: _confirmPasswordFocus,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Images.lock,
                            isPassword: true,
                            divider: true,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'confirm_password'.tr,
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Images.lock,
                            isPassword: true,
                            onSubmit: (text) =>
                                GetPlatform.isWeb ? _resetPassword() : null,
                          ),
                        ]),
                      ),
                      SizedBox(height: 30),
                      GetBuilder<UserController>(builder: (userController) {
                        return GetBuilder<AuthController>(
                            builder: (authBuilder) {
                          return /* (!authBuilder.isLoading && !userController.isLoading) ?*/ CustomButton(
                            buttonText: widget.fromPasswordChange
                                ?'Update Password':'done'.tr,
                            onPressed: () => _resetPassword(),
                          ) /*: Center(child: CircularProgressIndicator())*/;
                        });
                      }),
                    ]),
                  )),
                )))),
      ),
    );
  }

  void _resetPassword() {
    String _password = _newPasswordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 6) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    } else {

      if(widget.fromPasswordChange){
        Get.find<AuthController>()
            .updatePassword( _password,
            _confirmPassword,Get.find<HomeController>().userDetailModel!=null && Get.find<HomeController>().userDetailModel.contactDTO!=null ?Get.find<HomeController>().userDetailModel.contactDTO.email:"")
            .then((value) {
          if (value.statusCode == 200) {
            if (value.body['metadata']['code'] == 200 ||
                value.body['metadata']['code'] == "200") {
              showCustomSnackBar(value.body['metadata']['message'].toString());
              Get.offNamed(RouteHelper.getSignInRoute(
                  RouteHelper.onBoarding));
            } else {
              showCustomSnackBar(value.body['metadata']['message'].toString());
            }
          } else {
            showCustomSnackBar("Invalid Details");
          }
        });
      }
      else {
        Get.find<AuthController>()
            .resetPassword(widget.number, '+' + widget.number.trim(), _password,
            _confirmPassword)
            .then((value) {
          if (value.statusCode == 200) {
            if (value.body['metadata']['code'] == 200 ||
                value.body['metadata']['code'] == "200") {
              showCustomSnackBar(value.body['metadata']['message'].toString());
              Get.offNamed(RouteHelper.getSignInRoute(
                  RouteHelper.onBoarding));
            } else {
              showCustomSnackBar(value.body['metadata']['message'].toString());
            }
          } else {
            showCustomSnackBar("Invalid Details");
          }
        });
      }
    }
  }
}
