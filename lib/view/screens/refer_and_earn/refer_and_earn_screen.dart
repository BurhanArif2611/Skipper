import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({Key key}) : super(key: key);

  @override
  State<ReferAndEarnScreen> createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    /*_isLoggedIn = Get.find<AuthController>().isLoggedIn();

    if (_isLoggedIn */ /*&& Get.find<UserController>().userInfoModel == null*/ /*) {
      Get.find<UserController>().getUserInfo();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'refer_and_earn'.tr),
      body: SingleChildScrollView(
        child: Container(
            color: Theme.of(context).backgroundColor,
            alignment: Alignment.center,
            child: Column(
              children: [
                Image.asset(
                  Images.refer_earn_full,
                ),
                SizedBox(
                  height: 100,
                ),

              ],
            )),
      ),
        floatingActionButton:InkWell(onTap: (){
          Share.share("userController.userInfoModel.refCode");
        },
        child:
        Padding(
          padding:  EdgeInsets.only(bottom: 0, right: 0), // Adjust padding here
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Theme.of(context).hintColor,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Invite",
                    style: robotoBold.copyWith(
                        color: Colors.white,
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                ],
              ),
            ),
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Adjusts FAB to center


        /*Center(
        child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH,
          child: _isLoggedIn ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
            child: GetBuilder<UserController>(builder: (userController) {
                return Column( children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  Text('earn_money_on_every_referral'.tr, style: robotoRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  Text(
                      'one_referral'.tr + '= ' + PriceConverter.convertPrice(Get.find<SplashController>().configModel != null
                          ? Get.find<SplashController>().configModel.refEarningExchangeRate.toDouble() : 0.0),
                      style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                  ),
                  SizedBox(height: 40),

                  Center(
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Column(children: [

                        Image.asset(Images.refer_image, width: ResponsiveHelper.isDesktop(context) ? 200 : 100,
                            height: ResponsiveHelper.isDesktop(context) ? 250 : 150, fit: BoxFit.contain),
                        SizedBox(width: 120,
                            child: Text('refer_your_code_to_your_friend'.tr , style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center),
                        ),
                      ]),
                      SizedBox(width: ResponsiveHelper.isDesktop(context) ? 150 : 50),

                      Column(children: [
                        Image.asset(Images.earn_money, width: ResponsiveHelper.isDesktop(context) ? 200 : 100,
                            height: ResponsiveHelper.isDesktop(context) ? 250 : 150, fit: BoxFit.contain),
                        SizedBox(width: 120, child: Text(
                            'get'.tr + ' ${PriceConverter.convertPrice(Get.find<SplashController>().configModel != null ? Get.find<SplashController>().configModel.refEarningExchangeRate.toDouble() : 0.0)} ' +
                                'on_joining'.tr , style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall), textAlign: TextAlign.center),
                        ),
                      ]),
                    ]),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    Text('your_referral_code'.tr, style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeDefault)),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    DottedBorder(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 1,
                      strokeCap: StrokeCap.butt,
                      dashPattern: [8, 5],
                      padding: EdgeInsets.all(0),
                      borderType: BorderType.RRect,
                      radius: Radius.circular(Dimensions.RADIUS_SMALL),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                        height: 50, decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
                        child: (userController.userInfoModel != null) ? Row(children: [
                          Expanded(
                            child: Text(
                              '${userController.userInfoModel != null ? userController.userInfoModel.refCode ?? '' : ''}',
                              style: robotoBlack.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if(userController.userInfoModel.refCode.isNotEmpty){
                                Clipboard.setData(ClipboardData(text: '${userController.userInfoModel != null ? userController.userInfoModel.refCode : ''}'));
                                showCustomSnackBar('referral_code_copied'.tr, isError: false);
                              }
                            },
                            child: Text('tap_to_copy'.tr, style: robotoMedium),
                          ),
                        ]) : CircularProgressIndicator(),
                      ),
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  CustomButton(buttonText: 'share'.tr,icon: Icons.share, onPressed: () => Share.share(userController.userInfoModel.refCode)),

                ]);
              }
            ),
          ) : NotLoggedInScreen(),
        ),
      )*/

    );
  }
}
