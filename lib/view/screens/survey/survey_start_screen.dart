import 'package:flutter_svg/svg.dart';

import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/home/widget/module_view.dart';
import 'package:sixam_mart/view/screens/home/widget/store_branch.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../data/model/response/survey_list_model.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/not_logged_in_screen.dart';

class SurveyStartScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  final PendingSurvey data;

  SurveyStartScreen({@required this.data});

  @override
  State<SurveyStartScreen> createState() => _SurveyStartScreenState();
}

class _SurveyStartScreenState extends State<SurveyStartScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print("data>>>>>>>>${widget.data.title}");
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return Scaffold(
        appBar: InnerCustomAppBar(
          title: 'Surveys'.tr,
          leadingIcon: Images.circle_arrow_back,
        ),
        endDrawer: MenuDrawer(),
        backgroundColor: ResponsiveHelper.isDesktop(context)
            ? Theme.of(context).cardColor
            : splashController.module == null
                ? Theme.of(context).backgroundColor
                : null,
        body: /*Scrollbar(
          child: */
            SingleChildScrollView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  alignment: Alignment.center,
                  /* color: Colors.red,*/
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.data.title,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                                height: Dimensions.PADDING_SIZE_LARGE),
                            Text(
                              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly.",
                              style: robotoRegular.copyWith(
                                  fontSize: Dimensions
                                      .fontSizeDefault ,
                                  color: Theme.of(context).hintColor),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                            SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                            CustomButton(
                              buttonText: 'Survey Started'.tr,
                              onPressed: () {
                                PendingSurvey pendingSurvey=widget.data;
                                Get.toNamed(RouteHelper.getSurveyQuestionScreen(pendingSurvey));

                              } /*_login(
                                  authController, _countryDialCode)*/
                              ,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )),
        /* ),*/
      );
    });
  }

  List<Widget> _pageIndicators(
      OnBoardingController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < 5; i++) {
      _indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
            borderRadius: i == onBoardingController.selectedIndex
                ? BorderRadius.circular(50)
                : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
