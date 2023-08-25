import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
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
import '../../../controller/dashboard_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../util/images.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/paginated_list_view.dart';

class NewsDetailScreen extends StatefulWidget {
  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
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

    //_loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final PageController _pageController = PageController();
    final ScrollController _scrollController = ScrollController();
    return GetBuilder<SplashController>(builder: (splashController) {
      return Scaffold(
        appBar: InnerCustomAppBar(
          title: 'Top News'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
        ),
       /* endDrawer: MenuDrawer(),*/
        body: Get.find<AuthController>().isLoggedIn()
            ?
        SingleChildScrollView(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              /* color: Colors.red,*/
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Container(
                  margin: EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_SMALL),

                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Instagram working on ‘Exclusive Stories’ for subscribers",
                        style: robotoBold.copyWith(
                            fontSize: Dimensions
                                .fontSizeExtraLarge ,color: Theme.of(context).hintColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                        height: Dimensions
                            .PADDING_SIZE_EXTRA_SMALL),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child:
                        Row(children: [
                          Text("By :",
                              style: robotoMedium
                                  .copyWith(
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                  fontSize: Dimensions
                                      .fontSizeDefault)),
                          Text("Abiodun Sansi",
                              style: robotoBold.copyWith(
                                  color: Theme
                                      .of(context)
                                      .hintColor,
                                  fontSize: Dimensions
                                      .fontSizeDefault))
                        ])),
                        Expanded(
                          flex: 1,
                          child:Row(children: [
                            SvgPicture.asset(Images.calendar),
                            SizedBox(
                                width: Dimensions
                                    .PADDING_SIZE_EXTRA_SMALL),
                            Text("21 Dec 2021 ",
                                style: robotoMedium.copyWith(
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                    fontSize:
                                    Dimensions.fontSizeSmall)),
                            SizedBox(
                                width: Dimensions
                                    .PADDING_SIZE_EXTRA_SMALL),
                            SvgPicture.asset(Images.clock),
                            SizedBox(
                                width: Dimensions
                                    .PADDING_SIZE_EXTRA_SMALL),
                            Text(
                                "3:51 am",
                                textAlign: TextAlign.right,
                                style: robotoMedium.copyWith(
                                    color: Theme
                                        .of(context)
                                        .hintColor,
                                    fontSize:
                                    Dimensions.fontSizeSmall)
                            ),
                          ],)
                        ),

                      ],
                    ),
                    SizedBox(
                        height: Dimensions.PADDING_SIZE_SMALL),
                    Image.asset(
                      Images.homepagetopslider,
                      height: 150 /*context.height * 0.3*/,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      fit: BoxFit.fill,
                    ),

                    SizedBox(
                        height: Dimensions.PADDING_SIZE_SMALL),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
                        style: robotoRegular.copyWith(
                            fontSize: Dimensions
                                .fontSizeDefault ,color: Theme.of(context).hintColor),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ]),
                ),


                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                ],
              ),
            ))
            : NotLoggedInScreen(),
      );
    });
  }



}
