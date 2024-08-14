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
  String _countryDialCode="+1";
  @override
  void initState() {
    super.initState();
    _numberController.text=widget.number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.fromSocialLogin ? 'phone'.tr : 'forgot_password'.tr),
      endDrawer: MenuDrawer(),
      body: SafeArea(child:Container(color: Theme.of(context).backgroundColor,
          child:Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Theme.of(context).backgroundColor,
    child:
      Center(child: Scrollbar(child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FooterView(child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT) : null,
          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: context.width > 700 ? BoxDecoration(
            color: Theme.of(context).hintColor, borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], blurRadius: 5, spreadRadius: 1)],
          ) :  BoxDecoration(
              color: Theme.of(context).backgroundColor,),
          child: Column(children: [

            Image.asset(Images.forgot, height: 220),

            Padding(
              padding: EdgeInsets.all(30),
              child: Text('please_enter_mobile'.tr, style: robotoRegular.copyWith(color: Theme.of(context).cardColor), textAlign: TextAlign.center,),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                border: Border.all(
                    width: 1,
                    color: Theme.of(context)
                        .cardColor
                        .withOpacity(0.50)),
                color: Colors.transparent/*Theme.of(context).cardColor*/,
              ),
              child: Row(children: [
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
                    fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).cardColor,
                  ),
                ),
                Expanded(child: CustomTextField(
                  controller: _numberController,
                  inputType: TextInputType.phone,
                  inputAction: TextInputAction.done,
                  hintText: 'phone'.tr,
                  maxLength: 10,
                 // isEnabled: (widget.number!=null && widget.number.toString()=="")?true:true,
                  onSubmit: (text) => GetPlatform.isWeb ? _forgetPass(_countryDialCode) : null,
                )),
              ]),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            GetBuilder<AuthController>(builder: (authController) {
              return !authController.isLoading ? CustomButton(
                buttonText: 'next'.tr,
                onPressed: () => _forgetPass(_countryDialCode),
              ) : Center(child: CircularProgressIndicator());
            }),

          ]),
        )),
      )))))



      ),
    );
  }

  void _forgetPass(String countryCode) async {



    String _phone = _numberController.text.trim();
   // String _phone ="3748374873";

    String _numberWithCountryCode = countryCode+_phone;

    /*Get.toNamed(RouteHelper.getVerificationRoute(
        _numberWithCountryCode, '', RouteHelper.forgotPassword, ''));*/

    bool _isValid = GetPlatform.isWeb ? true : false;
    if(!GetPlatform.isWeb) {
      try {
        PhoneNumber phoneNumber = await PhoneNumberUtil().parse(_numberWithCountryCode);
        _numberWithCountryCode = '+' + phoneNumber.countryCode + phoneNumber.nationalNumber;
        _isValid = true;
      } catch (e) {}
    }

    if (_phone.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    }else if (!_isValid) {
      showCustomSnackBar('invalid_phone_number'.tr);
    }
    else {
      if(widget.fromSocialLogin) {
        widget.socialLogInBody.phone = _numberWithCountryCode;
        Get.find<AuthController>().registerWithSocialMedia(widget.socialLogInBody);
      }
      else {
        Get.find<AuthController>().forgetPassword(_numberWithCountryCode).then((status) async {
          if (status.statusCode == 200) {
            if (status.body['metadata']['code']== "200") {
              showCustomSnackBar(status.body['metadata']['message'].toString(),isError:false);

              Get.toNamed(RouteHelper.getVerificationRoute(
                  _numberWithCountryCode, status.body['data']['opt_id'], RouteHelper.forgotPassword, ''));
            }
            else {
              showCustomSnackBar(status.body['metadata']['message'].toString(),isError:true);
            }
          }else {
            try{
            showCustomSnackBar(status.body['errors'][0]['message'].toString());}
                catch (e){}
          }
        });
      }
    }
  }
}
