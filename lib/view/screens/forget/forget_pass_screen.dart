import 'package:country_code_picker/country_code.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/body/social_log_in_body.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/custom_text_field.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/screens/auth/widget/code_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_number/phone_number.dart';

class ForgetPassScreen extends StatefulWidget {
  final bool fromSocialLogin;
  final SocialLogInBody socialLogInBody;
  final String number;
  ForgetPassScreen({@required this.fromSocialLogin, @required this.socialLogInBody, @required this.number});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final TextEditingController _numberController = TextEditingController();
  //String _countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.country).dialCode;

  @override
  void initState() {
    super.initState();
   // _numberController.text=widget.number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.fromSocialLogin ? 'phone'.tr : 'forgot_password'.tr),
     /* endDrawer: MenuDrawer(),*/
      body: SafeArea(child: Center(child: Scrollbar(child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FooterView(child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], blurRadius: 5, spreadRadius: 1)],
          ) : null,
          child: Column(children: [

            Image.asset(Images.forgot, height: 220),

            Padding(
              padding: EdgeInsets.all(30),
              child: Text('please_enter_mobile'.tr, style: robotoRegular, textAlign: TextAlign.center),
            ),

            Container(
             /* decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                color: Theme.of(context).cardColor,
              ),*/
              child: Row(children: [
             /* Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  25.0),
              color: Theme.of(context).cardColor,
            ),
            child:
            CodePickerWidget(
                  onChanged: (CountryCode countryCode) {
                    _countryDialCode = countryCode.dialCode;
                  },
                  initialSelection: _countryDialCode,
                  favorite: [_countryDialCode],
                  showDropDownButton: true,
                  padding: EdgeInsets.zero,
                  showFlagMain: true,
                  dialogBackgroundColor: Theme.of(context).cardColor,
                  textStyle: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                )),
                SizedBox(width: Dimensions.RADIUS_SMALL),*/
                Expanded(child: CustomTextField(
                  controller: _numberController,
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.done,
                  hintText: 'email'.tr,
                  prefixIcon: Images.mail,

                 // isEnabled: (widget.number!=null && widget.number.toString()=="")?true:true,
                 /* onSubmit: (text) => GetPlatform.isWeb ? _forgetPass(_countryDialCode) : null,*/
                )),
              ]),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            GetBuilder<AuthController>(builder: (authController) {
              return !authController.isLoading ? CustomButton(
                buttonText: 'next'.tr,
                onPressed: () => _forgetPass(),
              ) : Center(child: CircularProgressIndicator());
            }),

          ]),
        )),
      )))),
    );
  }

  void _forgetPass() async {
    String _email = _numberController.text.trim();


     if (_email.isEmpty) {
    showCustomSnackBar('enter_email_address'.tr);
    } else if (!GetUtils.isEmail(_email)) {
    showCustomSnackBar('enter_a_valid_email_address'.tr);
    }

   else {

       /* Get.toNamed(RouteHelper.getVerificationRoute(
            _numberWithCountryCode, '', RouteHelper.forgotPassword, ''));*/
        Get.find<AuthController>().forgetPassword(_email).then((status) async {
          showCustomSnackBar("check your email for your new password");
          if (status.statusCode == 200) {
            Navigator.of(context).pushNamed(RouteHelper.getResetPasswordRoute(
                "", "", 'reset-password')).then((value) {
              Get.back();
            });

          }else {
            try{
            showCustomSnackBar(status.body['errors'][0]['message'].toString());

            }
                catch (e){}
          }
        });
      }

  }
}
