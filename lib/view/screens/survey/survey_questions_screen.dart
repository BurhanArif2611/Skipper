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
import '../../base/custom_image.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/not_logged_in_screen.dart';

class SurveyQuestionsScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  final PendingSurvey data;

  SurveyQuestionsScreen({@required this.data});

  @override
  State<SurveyQuestionsScreen> createState() => _SurveyQuestionsScreenState();
}

class _SurveyQuestionsScreenState extends State<SurveyQuestionsScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();

  void _loadData() async {
    await Get.find<HomeController>().getSurveysDetail(widget.data.sId);
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
    return GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        appBar: InnerCustomAppBar(
          title: widget.data.title.toString(),
          leadingIcon: Images.circle_arrow_back,
        ),
        endDrawer: MenuDrawer(),
        body: /*Scrollbar(
          child: */
            !homeController.isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    /**/
                    /* color: Colors.red,*/
                    child: GetBuilder<HomeController>(
                      builder: (onBoardingController) => Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: onBoardingController.surveyDetailModel != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: _pageIndicators(
                                              onBoardingController, context),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: Dimensions
                                            .PADDING_SIZE_EXTRA_LARGE),
                                    (onBoardingController.surveyDetailModel !=
                                                null &&
                                            onBoardingController
                                                    .surveyDetailModel.data !=
                                                null &&
                                            onBoardingController
                                                    .surveyDetailModel
                                                    .data
                                                    .surveyQuestions
                                                    .length >
                                                0
                                        ? Expanded(
                                            flex: 15,
                                            child: PageView.builder(
                                              itemCount: onBoardingController
                                                  .surveyDetailModel
                                                  .data
                                                  .surveyQuestions
                                                  .length,
                                              controller: _pageController,
                                              physics: BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.all(Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: Dimensions
                                                                  .PADDING_SIZE_DEFAULT,
                                                            ),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  "Q.${index + 1}  " +
                                                                      onBoardingController
                                                                          .surveyDetailModel
                                                                          .data
                                                                          .surveyQuestions[
                                                                              index]
                                                                          .question,
                                                                  style: robotoBold.copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .hintColor,
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeLarge),
                                                                ))
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height: Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        Container(
                                                          /* color: Colors.red,*/
                                                          height: 500,
                                                          child:
                                                              ListView.builder(
                                                            controller:
                                                                _scrollController,
                                                            itemCount: onBoardingController
                                                                .surveyDetailModel
                                                                .data
                                                                .surveyQuestions[
                                                                    index]
                                                                .options
                                                                .length,
                                                            physics:
                                                                ScrollPhysics(),
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemBuilder: (context,
                                                                index_option) {
                                                              String
                                                                  optionPosition =
                                                                  "";
                                                              if (index_option ==
                                                                  0) {
                                                                optionPosition =
                                                                    "A";
                                                              } else if (index_option ==
                                                                  1) {
                                                                optionPosition =
                                                                    "B";
                                                              }
                                                              if (index_option ==
                                                                  2) {
                                                                optionPosition =
                                                                    "C";
                                                              }
                                                              if (index_option ==
                                                                  3) {
                                                                optionPosition =
                                                                    "D";
                                                              }
                                                              return InkWell(
                                                                  onTap: () {
                                                                    homeController
                                                                        .changeOptionSelectIndex(
                                                                            index_option);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.all(
                                                                        Dimensions
                                                                            .PADDING_SIZE_SMALL),
                                                                    child: Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                40,
                                                                            padding:
                                                                                EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(50.0),
                                                                              border: Border.all(width: 0.4, color: Theme.of(context).hintColor),
                                                                              color: homeController.selectedOptionIndex == index_option ? Theme.of(context).primaryColor : Colors.transparent,
                                                                            ),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                /* Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: */
                                                                                Text(
                                                                              "$optionPosition ",
                                                                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: homeController.selectedOptionIndex == index_option ? Colors.white : Theme.of(context).primaryColor),
                                                                              textAlign: TextAlign.center,
                                                                            ), /* )*/
                                                                          ),
                                                                          SizedBox(
                                                                              width: Dimensions.PADDING_SIZE_LARGE),
                                                                          Text(
                                                                            onBoardingController.surveyDetailModel.data.surveyQuestions[index].options[index_option].option,
                                                                            style:
                                                                                robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: homeController.selectedOptionIndex == index_option ? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                          ),
                                                                        ]),
                                                                  ));
                                                            },
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 1,
                                                                child: SvgPicture
                                                                    .asset(Images
                                                                        .left_previous)),
                                                            SizedBox(
                                                                width: Dimensions.PADDING_SIZE_DEFAULT),
                                                            Expanded(
                                                                flex: 4,
                                                                child:
                                                                    Container(
                                                                        padding:
                                                                            EdgeInsets.all(Dimensions
                                                                                .PADDING_SIZE_SMALL),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(35.0),
                                                                          border: Border.all(
                                                                              width: 0.4,
                                                                              color: Theme.of(context).primaryColor),
                                                                          color:
                                                                              Colors.transparent,
                                                                        ),
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        child:
                                                                            Text(
                                                                          "Next",
                                                                          style: robotoMedium.copyWith(
                                                                              color: Theme.of(context).primaryColor,
                                                                              fontSize: Dimensions.fontSizeExtraLarge),
                                                                        ))),
                                                            SizedBox(
                                                                width: Dimensions.PADDING_SIZE_DEFAULT),
                                                            Expanded(
                                                                flex: 1,
                                                                child: SvgPicture
                                                                    .asset(Images
                                                                        .right_previous)),
                                                          ],
                                                        )
                                                      ]),
                                                );
                                              },
                                              onPageChanged: (index) {
                                                onBoardingController
                                                    .changeSelectIndex(index);
                                              },
                                            ))
                                        : SizedBox()),
                                  ])
                            : SizedBox(),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  )),
        /* ),*/
      );
    });
  }

  List<Widget> _pageIndicators(
      HomeController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0;
        i < onBoardingController.surveyDetailModel.data.surveyQuestions.length;
        i++) {
      _indicators.add(
        Container(
          width: 50,
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
