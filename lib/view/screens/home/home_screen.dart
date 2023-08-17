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
import '../../../helper/date_converter.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_image.dart';
import '../../base/inner_custom_app_bar.dart';
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

      return
        Scaffold(
        appBar: InnerCustomAppBar(
            title: 'Home'.tr,
            leadingIcon: Images.circle_arrow_back,
            backButton: ResponsiveHelper.isDesktop(context),
            onBackPressed: () {
              Get.find<DashboardController>().changeIndex(0);
            }),
        endDrawer: MenuDrawer(),

        body: /*Scrollbar(
          child: */
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
                              )),
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
                                                .incidenceListModel.docs.length,
                                            controller: _pageController,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
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
                                                      color: Theme.of(context)
                                                          .disabledColor),
                                                ),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                      (onBoardingController
                                                          .incidenceListModel
                                                          .docs[index]
                                                          .images!=null&& onBoardingController
                                                          .incidenceListModel
                                                          .docs[index]
                                                          .images.length>0?
                                                      CustomImage(
                                                        fit: BoxFit.cover,
                                                        height: 150,
                                                        image: onBoardingController
                                                            .incidenceListModel
                                                            .docs[index]
                                                            .images[0],
                                                      ): Image.asset(
                                                         Images.no_data_found,
                                                        width: MediaQuery.of(context).size.height*0.15, height: 150,
                                                      )),
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
                                                                  .docs[index]
                                                                  .incidentType
                                                                  .name
                                                              : "",
                                                          style: robotoBold.copyWith(
                                                              fontSize: Dimensions
                                                                  .fontSizeDefault /*context.height*0.022*/),
                                                          textAlign:
                                                              TextAlign.start,
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
                                                                fontSize: Dimensions
                                                                    .fontSizeDefault /*context.height*0.015*/,
                                                                color: Theme.of(
                                                                        context)
                                                                    .hintColor),
                                                            textAlign:
                                                                TextAlign.start,
                                                          )),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 2,
                                                            child: Row(
                                                                children: [
                                                                  Text("By :",
                                                                      style: robotoMedium.copyWith(
                                                                          color: Theme.of(context)
                                                                              .hintColor,
                                                                          fontSize:
                                                                              Dimensions.fontSizeDefault)),
                                                                  Text(
                                                                      onBoardingController
                                                                          .incidenceListModel
                                                                          .docs[
                                                                              index]
                                                                          .user
                                                                          .name
                                                                          .first,
                                                                      style: robotoBold.copyWith(
                                                                          color: Theme.of(context)
                                                                              .hintColor,
                                                                          fontSize:
                                                                              Dimensions.fontSizeDefault))
                                                                ]),
                                                          ),
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
                                              );
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
                                                    color: index == onBoardingController.selectedCategoryIndex
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.white,
                                                  ),
                                                  child: InkWell(
                                                      onTap: () {
                                                        onBoardingController.changeCategorySelectIndex(index);
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
                          builder: (onBoardingController) =>
                              onBoardingController.newsListModel != null
                                  ? Container(
                                      height: 1000,
                                      child: ListView.builder(
                                        /*controller: _scrollController,*/
                                        itemCount: onBoardingController
                                            .newsListModel.data.docs.length,
                                        padding: EdgeInsets.all(Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                top: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .disabledColor),
                                              color: Colors.white,
                                            ),
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                        padding: EdgeInsets.all(
                                                            Dimensions
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
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  onBoardingController
                                                                      .newsListModel
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                      .title,
                                                                  style: robotoBold
                                                                      .copyWith(
                                                                          fontSize:
                                                                              Dimensions.fontSizeDefault /*context.height*0.022*/),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    onBoardingController
                                                                        .newsListModel
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .description,
                                                                    style: robotoRegular.copyWith(
                                                                        fontSize:
                                                                            Dimensions
                                                                                .fontSizeDefault /*context.height*0.015*/,
                                                                        color: Theme.of(context)
                                                                            .hintColor),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                  )),
                                                              SizedBox(
                                                                  height: Dimensions
                                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                              Row(children: [
                                                                Text("By :",
                                                                    style: robotoMedium.copyWith(
                                                                        color: Theme.of(context)
                                                                            .hintColor,
                                                                        fontSize:
                                                                            Dimensions.fontSizeDefault)),
                                                                Text(
                                                                    onBoardingController
                                                                        .newsListModel
                                                                        .data
                                                                        .docs[
                                                                            index]
                                                                        .category
                                                                        .name,
                                                                    style: robotoBold.copyWith(
                                                                        color: Theme.of(context)
                                                                            .hintColor,
                                                                        fontSize:
                                                                            Dimensions.fontSizeDefault))
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
                                                      image:
                                                          onBoardingController
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
                                                  padding: EdgeInsets.all(
                                                      Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          Images.calendar),
                                                      SizedBox(
                                                          width: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      Text("21 Dec 2021 ",
                                                          style: robotoMedium.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor,
                                                              fontSize: Dimensions
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
                                                            TextAlign.right,
                                                      ),
                                                    ],
                                                  )),
                                            ]),
                                          );
                                        },
                                      ))
                                  : SizedBox()),
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
                builder: (onBoardingController) =>onBoardingController.surveyListModel!=null && onBoardingController.surveyListModel.data.docs.pendingSurvey.length>0 ?
                      Container(
                          height: 500,
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: onBoardingController.surveyListModel.data.docs.pendingSurvey.length,
                            padding: EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL),
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    top: Dimensions.PADDING_SIZE_SMALL),
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
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
                                          fontSize: Dimensions.fontSizeDefault),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Text(
                                    "In publishing and graphic design, Lorem ipsum is a placeholder text commonly.",
                                    style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context).hintColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ]),
                              );
                            },
                          )):SizedBox()),
                    ],
                  ),
                )),
        /* ),*/
        floatingActionButton: Container(
            width: 75, // Set the desired width here
            height: 75, // Set the desired height here
            child: FloatingActionButton(
              onPressed: () {
                // Add the action you want to perform when the FAB is pressed
                // For example, navigate to another page or show a dialog.
                print('Floating Action Button Pressed');
                Get.toNamed(RouteHelper.getSOSCOntactRoute());
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
        i < onBoardingController.incidenceListModel.docs.length;
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
