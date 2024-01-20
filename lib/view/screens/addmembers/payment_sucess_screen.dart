import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/splash_controller.dart';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/view/base/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/styles.dart';
import '../../../controller/auth_controller.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_button.dart';
import '../../base/footer_view.dart';
import '../../base/web_menu_bar.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final String orderID;

  PaymentSuccessScreen({@required this.orderID});

  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  bool success = true;




  @override
  void initState() {
    super.initState();
    String url = Uri.base.toString();
    Uri uri = Uri.parse(url);
    String sessionId = uri.queryParameters['session_id'];
    print('Session ID: $sessionId');

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>().initSharedData();

    return Scaffold(
      key: _globalKey,
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() :null,
      body: GetBuilder<SplashController>(builder: (splashController) {
        print("_ErrorPageScreenState>>>>>");
        return
          SingleChildScrollView(
            child:
            FooterView(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

              Image.asset(success ? Images.checked : Images.warning,color: Theme.of(context).primaryColor, width: 100, height: 100),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              Text(
                success ? 'Thank you'.tr
                    : 'you_placed_the_order_successfully'.tr ,
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_SMALL),
                child: Text('payment_sub_title'.tr ,
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),



              Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: CustomButton(buttonText: 'back_to_home'.tr,onPressed: () => Get.offAllNamed(RouteHelper.getInitialRoute())),
              ),
            ]))),
          );
      }),
    );
  }
}
