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
import '../../../data/model/response/order_model.dart';
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

class SOSContactScreen extends StatefulWidget {
  @override
  State<SOSContactScreen> createState() => _SOSContactScreenState();
}

class _SOSContactScreenState extends State<SOSContactScreen> {
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
        title: 'SOS Contacts'.tr,
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
      endDrawer: MenuDrawer(),
      body: !Get.find<AuthController>().isLoggedIn()
          ? /*Scrollbar(
          child:*/
          /* SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: */
          Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
              margin: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
              child: Center(
                child: Column(children: [
                  SizedBox(
                    height: Dimensions.RADIUS_LARGE,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Add 3 Mobile Numbers",
                        textAlign: TextAlign.left,
                        style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Spacer(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.button_bg),
                          ),
                        ),
                        child: InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getAddContactRoute());
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(Images.plus),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Add Number",
                                      textAlign: TextAlign.center,
                                      style: robotoMedium.copyWith(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ],
                                ))), // Your other content here, if any
                      ),
                    ),
                  ),
                ]),
              ),
            ) /*)*/ /*)*/
          : NotLoggedInScreen(),
    );
  }
}
