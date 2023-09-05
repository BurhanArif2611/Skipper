import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/home_controller.dart';

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

import '../../../controller/dashboard_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../data/model/response/survey_list_model.dart';
import '../../../helper/date_converter.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_dialog.dart';
import '../../base/custom_image.dart';
import '../../base/custom_snackbar.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/no_data_screen.dart';
import '../../base/not_logged_in_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time
  Timer _timer;

  void _loadData() async {
    await Get.find<HomeController>().getIncidenceList();
    await Get.find<HomeController>().getNewsList();
    await Get.find<HomeController>().getCategoryList();
    await Get.find<HomeController>().getSurveyList();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());

    return Scaffold(
      appBar: InnerCustomAppBar(
          title: 'Home'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: ResponsiveHelper.isDesktop(context),
          onBackPressed: () {
            Get.find<DashboardController>().changeIndex(0);
          }),
      /* endDrawer: MenuDrawer(),*/

      body: /*Scrollbar(
          child: */
          RefreshIndicator(
        onRefresh: () async {
          _loadData();
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return;
            },
            child: SingleChildScrollView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  /* color: Colors.red,*/
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text("Todays Top Incidences",
                                  style: robotoBold.copyWith(
                                      color: Theme.of(context).hintColor,
                                      fontSize: Dimensions.fontSizeLarge))),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    Get.find<DashboardController>()
                                        .changeIndex(1);
                                  },
                                  child: Text(
                                    "See More",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.grey,
                                      // Optional: Set the color of the underline
                                      decorationThickness: 2.0,
                                      /*decorationPadding: EdgeInsets.only(bottom: 5.0),*/
                                      // Optional: Set the thickness of the underline
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      GetBuilder<HomeController>(
                        builder: (onBoardingController) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          /* color: Colors.yellow,*/

                          child: onBoardingController.incidenceListModel != null
                              ? Column(children: [
                                  (onBoardingController.incidenceListModel !=
                                              null &&
                                          onBoardingController
                                                  .incidenceListModel.docs !=
                                              null &&
                                          onBoardingController
                                                  .incidenceListModel
                                                  .docs
                                                  .length >
                                              0
                                      ? Expanded(
                                          flex: 15,
                                          child: PageView.builder(
                                            itemCount: onBoardingController
                                                        .incidenceListModel
                                                        .docs
                                                        .length >
                                                    5
                                                ? 5
                                                : onBoardingController
                                                    .incidenceListModel
                                                    .docs
                                                    .length,
                                            controller: _pageController,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                  onTap: () {
                                                    Get.toNamed(RouteHelper
                                                        .getIncidenceDetailScreen(
                                                            onBoardingController
                                                                .incidenceListModel
                                                                .docs[index]
                                                                .sId));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        Dimensions
                                                            .PADDING_SIZE_DEFAULT),
                                                    margin: EdgeInsets.only(
                                                        right: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor),
                                                    ),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          /*Image.asset(
                                            Images.homepagetopslider,
                                            height:
                                                150 */ /*context.height * 0.3*/ /*,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.fill,
                                          ),*/
                                                          Container(
                                                              height: 160,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child: (onBoardingController
                                                                              .incidenceListModel
                                                                              .docs[
                                                                                  index]
                                                                              .images !=
                                                                          null &&
                                                                      onBoardingController
                                                                              .incidenceListModel
                                                                              .docs[index]
                                                                              .images
                                                                              .length >
                                                                          0
                                                                  ? CustomImage(
                                                                      fit: BoxFit
                                                                          .fitWidth,
                                                                      image: onBoardingController
                                                                          .incidenceListModel
                                                                          .docs[
                                                                              index]
                                                                          .images[0],
                                                                    )
                                                                  : Image.asset(
                                                                      Images
                                                                          .no_data_found,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.15,
                                                                      height:
                                                                          160,
                                                                    ))),
                                                          SizedBox(
                                                              height: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              onBoardingController
                                                                          .incidenceListModel
                                                                          .docs[
                                                                              index]
                                                                          .incidentType !=
                                                                      null
                                                                  ? onBoardingController
                                                                      .incidenceListModel
                                                                      .docs[
                                                                          index]
                                                                      .incidentType
                                                                      .name
                                                                  : "",
                                                              style: robotoBold
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault /*context.height*0.022*/),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                onBoardingController
                                                                    .incidenceListModel
                                                                    .docs[index]
                                                                    .shortDescription,
                                                                style: robotoRegular.copyWith(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeDefault /*context.height*0.015*/,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .hintColor),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              )),
                                                          SizedBox(
                                                              height: Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              onBoardingController
                                                                          .incidenceListModel
                                                                          .docs[
                                                                              index]
                                                                          .user !=
                                                                      null
                                                                  ? Expanded(
                                                                      flex: 2,
                                                                      child: Container(
                                                                          child: Row(children: [
                                                                        Expanded(
                                                                            flex:
                                                                                1,
                                                                            child: Text("By :",
                                                                                softWrap: true,
                                                                                maxLines: 2,
                                                                                style: robotoMedium.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault))),
                                                                        Expanded(
                                                                            flex:
                                                                                6,
                                                                            child:
                                                                                Container(width: double.infinity, child: Text(onBoardingController.incidenceListModel.docs[index].user.name.first + " " + onBoardingController.incidenceListModel.docs[index].user.name.last, softWrap: true, maxLines: 2, textAlign: TextAlign.left, style: robotoBold.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault))))
                                                                      ])),
                                                                    )
                                                                  : SizedBox(),
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    timeago.format(
                                                                        DateTime.parse(onBoardingController
                                                                            .incidenceListModel
                                                                            .docs[
                                                                                index]
                                                                            .createdAt),
                                                                        locale:
                                                                            'en'),
                                                                    /*"06 days ago"*/
                                                                    textAlign:
                                                                        TextAlign
                                                                            .right,
                                                                  )),
                                                            ],
                                                          ),
                                                        ]),
                                                  ));
                                            },
                                            onPageChanged: (index) {
                                              onBoardingController
                                                  .changeSelectIndex(index);
                                            },
                                          ))
                                      : SizedBox()),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: _pageIndicators(
                                            onBoardingController, context),
                                      ),
                                    ),
                                  ),
                                ])
                              : SizedBox(),
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text("Todays Top News",
                                  style: robotoBold.copyWith(
                                      color: Theme.of(context).hintColor,
                                      fontSize: Dimensions.fontSizeLarge))),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getTopNewsScreen());
                                  },
                                  child: Text(
                                    "See More",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.grey,
                                      // Optional: Set the color of the underline
                                      decorationThickness: 2.0,
                                      /*decorationPadding: EdgeInsets.only(bottom: 5.0),*/
                                      // Optional: Set the thickness of the underline
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      GetBuilder<HomeController>(
                          builder: (onBoardingController) =>
                              onBoardingController.newsCategoryListModel !=
                                          null &&
                                      onBoardingController.newsCategoryListModel
                                              .data.length >
                                          0
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 30,
                                            child:
                                                /*   categoryController.categoryList != null ?*/
                                                ListView.builder(
                                              controller: _scrollController,
                                              itemCount: onBoardingController
                                                  .newsCategoryListModel
                                                  .data
                                                  .length,
                                              padding: EdgeInsets.only(
                                                  left: Dimensions
                                                      .PADDING_SIZE_SMALL),
                                              /* physics: BouncingScrollPhysics(),*/
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      right: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35.0),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Theme.of(context)
                                                            .disabledColor),
                                                    color: index ==
                                                            onBoardingController
                                                                .selectedCategoryIndex
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.white,
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        onBoardingController
                                                            .changeCategorySelectIndex(
                                                                index,
                                                                onBoardingController
                                                                    .newsCategoryListModel
                                                                    .data[index]
                                                                    .sId);
                                                      },
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(
                                                              left: Dimensions
                                                                  .PADDING_SIZE_DEFAULT,
                                                              right: Dimensions
                                                                  .PADDING_SIZE_DEFAULT),
                                                          child: Text(
                                                            onBoardingController
                                                                .newsCategoryListModel
                                                                .data[index]
                                                                .name,
                                                            style: robotoMedium
                                                                .copyWith(
                                                                    fontSize:
                                                                        11),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      )),
                                                );
                                              },
                                            ) /*: CategoryShimmer(categoryController: categoryController)*/,
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox()),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      GetBuilder<HomeController>(
                          builder:
                              (onBoardingController) =>
                                  onBoardingController.newsListModel != null &&
                                          onBoardingController.newsListModel
                                                  .data.docs.length >
                                              0
                                      ? Container(
                                          height: 1000,
                                          child: ListView.builder(
                                            /*controller: _scrollController,*/
                                            itemCount: onBoardingController
                                                .newsListModel.data.docs.length,
                                            padding: EdgeInsets.all(Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                  onTap: () {
                                                    Get.toNamed(RouteHelper
                                                        .getNewsDetailScreen(
                                                            onBoardingController
                                                                .newsListModel
                                                                .data
                                                                .docs[index]));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Container(
                                                                padding: EdgeInsets
                                                                    .all(Dimensions
                                                                        .PADDING_SIZE_SMALL),
                                                                child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        child:
                                                                            Text(
                                                                          onBoardingController
                                                                              .newsListModel
                                                                              .data
                                                                              .docs[index]
                                                                              .title,
                                                                          style:
                                                                              robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault /*context.height*0.022*/),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                      Align(
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child:
                                                                              Text(
                                                                            onBoardingController.newsListModel.data.docs[index].description,
                                                                            style:
                                                                                robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault /*context.height*0.015*/, color: Theme.of(context).hintColor),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                          )),
                                                                      SizedBox(
                                                                          height:
                                                                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                      Row(
                                                                          children: [
                                                                            Text("By :",
                                                                                style: robotoMedium.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault)),
                                                                            (onBoardingController.newsListModel.data.docs[index].category != null && onBoardingController.newsListModel.data.docs[index].category.name != null
                                                                                ? Text(onBoardingController.newsListModel.data.docs[index].category.name, style: robotoBold.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeDefault))
                                                                                : SizedBox())
                                                                          ]),
                                                                    ])),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: /*Image.asset(
                                    Images.homepagetopslider,
                                    height: 150 */ /*context.height * 0.3*/ /*,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),*/
                                                                CustomImage(
                                                              fit: BoxFit.cover,
                                                              height: 150,
                                                              image: onBoardingController
                                                                  .newsListModel
                                                                  .data
                                                                  .docs[index]
                                                                  .image,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      Container(
                                                          padding: EdgeInsets
                                                              .all(Dimensions
                                                                  .PADDING_SIZE_SMALL),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  Images
                                                                      .calendar),
                                                              SizedBox(
                                                                  width: Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              Text(
                                                                  "21 Dec 2021 ",
                                                                  style: robotoMedium.copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .hintColor,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeDefault)),
                                                              SizedBox(
                                                                  width: Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              SvgPicture.asset(
                                                                  Images.clock),
                                                              SizedBox(
                                                                  width: Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              Text(
                                                                "3:51 am",
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                              ),
                                                            ],
                                                          )),
                                                    ]),
                                                  ));
                                            },
                                          ))
                                      : NoDataScreen(text: "News Not Found")),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Text("Todays Survey",
                                  style: robotoBold.copyWith(
                                      color: Theme.of(context).hintColor,
                                      fontSize: Dimensions.fontSizeLarge))),
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    Get.toNamed(RouteHelper.getSurveyScreen());
                                  },
                                  child: Text(
                                    "See More",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.grey,
                                      // Optional: Set the color of the underline
                                      decorationThickness: 2.0,
                                      /*decorationPadding: EdgeInsets.only(bottom: 5.0),*/
                                      // Optional: Set the thickness of the underline
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      GetBuilder<HomeController>(
                          builder: (onBoardingController) =>
                              onBoardingController.surveyListModel != null &&
                                      onBoardingController.surveyListModel.data
                                              .docs.pendingSurvey.length >
                                          0
                                  ? Container(
                                      height: 500,
                                      child: ListView.builder(
                                        controller: _scrollController,
                                        itemCount: onBoardingController
                                            .surveyListModel
                                            .data
                                            .docs
                                            .pendingSurvey
                                            .length,
                                        padding: EdgeInsets.all(Dimensions
                                            .PADDING_SIZE_EXTRA_LARGE_SMALL),
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                PendingSurvey pendingSurvey =
                                                    onBoardingController
                                                        .surveyListModel
                                                        .data
                                                        .docs
                                                        .pendingSurvey[index];
                                                Get.toNamed(RouteHelper
                                                    .getSurveyStartScreen(
                                                        pendingSurvey));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                padding: EdgeInsets.all(
                                                    Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .disabledColor),
                                                  color: Colors.white,
                                                ),
                                                child: Column(children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      onBoardingController
                                                          .surveyListModel
                                                          .data
                                                          .docs
                                                          .pendingSurvey[index]
                                                          .title,
                                                      style: robotoBold.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeDefault),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                  Text(
                                                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly.",
                                                    style:
                                                        robotoRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeDefault,
                                                            color: Theme.of(
                                                                    context)
                                                                .hintColor),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ]),
                                              ));
                                        },
                                      ))
                                  : SizedBox()),
                    ],
                  ),
                ))),
      ),
      /* ),*/
      floatingActionButton: Container(
          width: 75, // Set the desired width here
          height: 75, // Set the desired height here
          child: FloatingActionButton(
            onPressed: () {
              // Add the action you want to perform when the FAB is pressed
              // For example, navigate to another page or show a dialog.
              print('Floating Action Button Pressed');
              // Get.toNamed(RouteHelper.getSOSCOntactRoute());
              Get.find<HomeController>()
                  .getSOSContactList()
                  .then((value) async {
                if (value.statusCode == 200) {
                  if (value.body['data'] != null &&
                      value.body['data'].length > 0) {
                    seconds = 5;
                    showingTimerPopup();
                    startTimer();
                  } else {
                    Get.toNamed(RouteHelper.getSOSCOntactRoute());
                  }
                } else {
                  Get.toNamed(RouteHelper.getSOSCOntactRoute());
                }
              });
            },
            child: Text(
              "SOS",
              style: robotoMedium.copyWith(color: Colors.white),
            ) /*Icon(Icons.add)*/,
            backgroundColor: Color(0xFFFF5454),
            // Set the FAB's background color
          )),
    );
  }

  List<Widget> _pageIndicators(
      HomeController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0;
        i <
            (onBoardingController.incidenceListModel.docs.length > 5
                ? 5
                : onBoardingController.incidenceListModel.docs.length);
        i++) {
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

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
          print("seconds>>>${seconds}");
          Get.find<HomeController>().updateTimerCount(seconds);
        } else {
          _timer.cancel();
          Get.back();

          Get.find<HomeController>()
              .sendSOSAlert("Lat", "Longi")
              .then((value) async {
            if (value.statusCode == 200) {
              showCustomSnackBar(
                  value.body["message"] != null
                      ? value.body["message"].toString()
                      : "",
                  isError: false);
            }
          });
          // Stop the timer when it reaches 0
        }
      });
    });
  }

  void showingTimerPopup() {
    showAnimatedDialog(
        context,
        GetBuilder<HomeController>(
            builder: (homecontroller) => Center(
                  child: Container(
                    width: 300,
                    padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                            Dimensions.RADIUS_EXTRA_LARGE)),
                    child: GetBuilder<HomeController>(builder: (controller) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        Text(
                          "${homecontroller.timerCount}",
                          style: robotoBold.copyWith(
                            fontSize: 30,
                            color: Theme.of(context).textTheme.bodyText1.color,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      ]);
                    }),
                  ),
                )),
        dismissible: false);
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
