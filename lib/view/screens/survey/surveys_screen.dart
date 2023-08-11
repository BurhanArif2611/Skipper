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
import '../../base/inner_custom_app_bar.dart';
import '../../base/not_logged_in_screen.dart';

class SurveyScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
            child:
            Container(
              margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              /* color: Colors.red,*/
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [

                  GetBuilder<HomeController>(
              builder: (onBoardingController) =>onBoardingController.surveyListModel!=null && onBoardingController.surveyListModel.data.docs.pendingSurvey.length>0 ?

                Container(
                      height: MediaQuery.of(context).size.height,
                      child:
                      ListView.builder(
                        controller: _scrollController,
                        itemCount: onBoardingController.surveyListModel.data.docs.pendingSurvey.length,
                        padding:
                        EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL),
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                PendingSurvey pendingSurvey=onBoardingController.surveyListModel.data.docs.pendingSurvey[index];
                                Get.toNamed(RouteHelper.getSurveyStartScreen(pendingSurvey));
                          },
                          child:
                            Container(
                            margin: EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_SMALL),
                            padding:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  width: 1,
                                  color: Theme.of(context).disabledColor),
                              color: Colors.white,
                            ),
                            child: Column(children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  onBoardingController.surveyListModel.data.docs.pendingSurvey[index].title,
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions
                                          .fontSizeDefault ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                  height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Text(
                                "In publishing and graphic design, Lorem ipsum is a placeholder text commonly.",
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions
                                        .fontSizeDefault ,
                                    color: Theme.of(context).hintColor),
                                textAlign: TextAlign.start,
                              ),
                            ]),
                          ));
                        },
                      )):SizedBox()),
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
