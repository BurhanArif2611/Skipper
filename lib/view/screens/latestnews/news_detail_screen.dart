import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/home_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/news_list_model.dart';
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
  final NewsDetail detail;

  NewsDetailScreen({@required this.detail});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final PageController _pageController = PageController();
    final ScrollController _scrollController = ScrollController();
    return GetBuilder<HomeController>(builder: (splashController) {
      return Scaffold(
        appBar: InnerCustomAppBar(
          title: 'Top News'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
        ),
        /* endDrawer: MenuDrawer(),*/
        body: Get.find<AuthController>().isLoggedIn()
            ? SingleChildScrollView(
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
                        margin:
                            EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                        child: Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.detail.title,
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                  color: Theme.of(context).hintColor),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(children: [
                                    Text("By :",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).hintColor,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                    Text("Abiodun Sansi",
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor,
                                            fontSize:
                                                Dimensions.fontSizeDefault))
                                  ])),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.calendar),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text("21 Dec 2021 ",
                                          style: robotoMedium.copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize:
                                                  Dimensions.fontSizeSmall)),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      SvgPicture.asset(Images.clock),
                                      SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text("3:51 am",
                                          textAlign: TextAlign.right,
                                          style: robotoMedium.copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize:
                                                  Dimensions.fontSizeSmall)),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          /*Image.asset(
                      Images.homepagetopslider,
                      height: 150 */ /*context.height * 0.3*/ /*,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      fit: BoxFit.fill,
                    ),*/
                          Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: CustomImage(
                                fit: BoxFit.cover,
                                image: widget.detail.image,
                              )),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.detail.description,
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: Theme.of(context).hintColor),
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
