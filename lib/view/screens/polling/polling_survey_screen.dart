import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/home_controller.dart';


import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:sixam_mart/view/base/menu_drawer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../base/custom_snackbar.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/no_data_screen.dart';
import '../../base/not_logged_in_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class PollingSurveyScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<PollingSurveyScreen> createState() => _PollingSurveyScreenState();
}

class _PollingSurveyScreenState extends State<PollingSurveyScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time
  Timer _timer;
  int PaginationIndex=0;
  String alphabet = 'abcdefghijklmnopqrstuvwxyz';
  String LANGUAGE_CODE="";

  void _loadData() async {
    await Get.find<AuthController>().getPollingSurveyToken();
   // print("<><LANGUAGE_CODE()><>"+ Get.find<AuthController>().getLANGUAGE_CODE());
    setState(() {
      LANGUAGE_CODE= Get.find<AuthController>().getLANGUAGE_CODE();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();

    _pageController.addListener(() {
      setState(() {
        //   print("<><><>"+_pageController.page.toString());
        PaginationIndex = _pageController.page.toInt();
        print("<><><>"+PaginationIndex.toString());
      });
    });
  }
  _scrollNext(){
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  _scrollPrevious(){
    _pageController.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());
    return GetBuilder<AuthController>(builder: (homeController) {
      return Scaffold(
        body: !homeController.isLoading
            ? 
        Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                /**/
                /* color: Colors.red,*/
                child: GetBuilder<AuthController>(
                  builder: (onBoardingController) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child:
                        onBoardingController.surveyListModel != null &&
                                onBoardingController.surveyListModel.data.length > 0
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
                                    (onBoardingController.surveyListModel !=
                                                null &&
                                            onBoardingController
                                                    .surveyListModel.data !=
                                                null &&
                                            onBoardingController
                                                    .surveyListModel
                                                    .data
                                                    .length >
                                                0
                                        ? Expanded(
                                            flex: 15,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                    flex: 16,
                                                    child: PageView.builder(
                                                      itemCount:
                                                          onBoardingController
                                                              .surveyListModel
                                                              .data
                                                              .length,
                                                      controller:
                                                          _pageController,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        String optionID = "";
                                                        if (onBoardingController
                                                                    .selectedOptionIdList !=
                                                                null &&
                                                            onBoardingController
                                                                    .selectedOptionIdList
                                                                    .length >
                                                                0) {
                                                          for (int i = 0;
                                                              i <
                                                                  onBoardingController
                                                                      .selectedOptionIdList
                                                                      .length;
                                                              i++) {
                                                            if (onBoardingController
                                                                    .selectedOptionIdList[
                                                                        i]
                                                                    .question ==
                                                                onBoardingController
                                                                    .surveyListModel
                                                                    .data
                                                                    [
                                                                        index]
                                                                    .toString()) {
                                                              optionID =
                                                                  onBoardingController
                                                                      .selectedOptionIdList[
                                                                          i]
                                                                      .options;
                                                              break;
                                                            }
                                                          }
                                                        }
                                                        return Scrollbar(
                                                            child:
                                                                SingleChildScrollView(
                                                                    physics:
                                                                        BouncingScrollPhysics(),
                                                                    child:
                                                                        Container(
                                                                      /*color: Colors.yellow,*/
                                                                      margin: EdgeInsets.all(
                                                                          Dimensions
                                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                                      child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .start,
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                /*SizedBox(
                                                                  width: Dimensions
                                                                      .PADDING_SIZE_DEFAULT,
                                                                ),*/

                                                                                Align(alignment: Alignment.centerLeft, child: SizedBox(width: MediaQuery.of(context).size.width - 50, child: Text("Q.${index + 1}  " + onBoardingController.surveyListModel.data[index].question, style: robotoBold.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge), overflow: TextOverflow.ellipsis, maxLines: 10, textAlign: TextAlign.start)))
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                                                            Container(
                                                                              /* color: Colors.red,*/
                                                                              height: 600,
                                                                              child: ListView.builder(
                                                                                controller: _scrollController,
                                                                                itemCount: onBoardingController.surveyListModel.data[index].options.length,
                                                                                physics: ScrollPhysics(),
                                                                                scrollDirection: Axis.vertical,
                                                                                itemBuilder: (context, index_option) {
                                                                                  String optionPosition = "";
                                                                                  if (index_option >= 0 && index_option < alphabet.length) {
                                                                                    optionPosition = alphabet[index_option].toUpperCase();

                                                                                  }

                                                                                  return InkWell(
                                                                                      onTap: () {
                                                                                        homeController.changeOptionSelectIndex(onBoardingController.surveyListModel.data[index].toString(), onBoardingController.surveyListModel.data[index].options[index_option].toString(), index_option);
                                                                                      },
                                                                                      child: Container(
                                                                                        width: MediaQuery.of(context).size.width,
                                                                                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                                                                        child: Row(mainAxisSize: MainAxisSize.max, children: [
                                                                                          Container(
                                                                                            height: 40,
                                                                                            width: 40,
                                                                                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(50.0),
                                                                                              border: Border.all(width: 0.4, color: Theme.of(context).hintColor),
                                                                                              color: optionID == onBoardingController.surveyListModel.data[index].options[index_option].toString() ? Theme.of(context).primaryColor : Colors.transparent,
                                                                                            ),
                                                                                            alignment: Alignment.center,
                                                                                            child:
                                                                                                /* Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: */
                                                                                                Text(
                                                                                              "$optionPosition ",
                                                                                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: optionID == onBoardingController.surveyListModel.data[index].options[index_option].toString() ? Colors.white : Theme.of(context).primaryColor),
                                                                                              textAlign: TextAlign.center,
                                                                                            ), /* )*/
                                                                                          ),
                                                                                          SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                                                                                          SizedBox(
                                                                                              width: MediaQuery.of(context).size.width - 180,
                                                                                              child: Text(
                                                                                                onBoardingController.surveyListModel.data[index].options[index_option].toString(),
                                                                                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: optionID == onBoardingController.surveyListModel.data[index].options[index_option].toString() ? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                                                                                                textAlign: TextAlign.start,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                maxLines: 5,
                                                                                              )),
                                                                                        ]),
                                                                                      ));
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    )));
                                                      },
                                                      onPageChanged: (index) {
                                                        onBoardingController
                                                            .changeQuestionTabSelectIndex(
                                                                index);
                                                      },
                                                    )),
                                                (onBoardingController
                                                                .surveyListModel !=
                                                            null &&
                                                        onBoardingController
                                                                .surveyListModel
                                                                .data !=
                                                            null &&
                                                        onBoardingController
                                                                .surveyListModel
                                                                .data
                                                                .length >
                                                            0
                                                    ?
                                                Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 1,
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      _scrollPrevious();
                                                                    },
                                                                    child: PaginationIndex !=
                                                                            0
                                                                        ? SvgPicture.asset(
                                                                            Images.left_previous)
                                                                        : SizedBox())),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .PADDING_SIZE_DEFAULT),
                                                            Expanded(
                                                                flex: 4,
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      print(
                                                                          "first >>${onBoardingController.surveyListModel.data.length}");
                                                                      print(
                                                                          "second >>${PaginationIndex}");

                                                                     /* if (onBoardingController.surveyListModel.data.length -
                                                                              1 ==
                                                                          (PaginationIndex)) {*/
                                                                        homeController
                                                                            .pollingSurveyResultStore(onBoardingController.surveyListModel.data[PaginationIndex].id.toString(),onBoardingController.selectedOptionIdList[0].options,PaginationIndex)
                                                                            .then((value) async {
                                                                          if (value.statusCode ==
                                                                              200) {
                                                                            showCustomSnackBar(
                                                                                /* value.body["message"]*/
                                                                                'Thank you for taking the survey',
                                                                                isError: false);
                                                                           /* Get.back();
                                                                            Navigator.pop(context);*/
                                                                          } else {
                                                                            showCustomSnackBar(value.body["message"],
                                                                                isError: true);
                                                                          }
                                                                        });
                                                                      /*} else {
                                                                        //_scrollNext();
                                                                      }*/
                                                                    },
                                                                    child: Container(
                                                                        height: 50,
                                                                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                                                        decoration: BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(35.0),
                                                                          border: Border.all(
                                                                              width: 0.4,
                                                                              color: Theme.of(context).primaryColor),
                                                                          color:
                                                                              Colors.transparent,
                                                                        ),
                                                                        alignment: Alignment.center,
                                                                        child: Text(
                                                                         /* onBoardingController.surveyListModel.data.length - 1 == (PaginationIndex)
                                                                              ?*/ "submit".tr
                                                                              /*: "Next"*/,
                                                                          style: robotoMedium.copyWith(
                                                                              color: Theme.of(context).primaryColor,
                                                                              fontSize: Dimensions.fontSizeExtraLarge),
                                                                        )))),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .PADDING_SIZE_DEFAULT),
                                                            Expanded(
                                                                flex: 1,
                                                                child: InkWell(
                                                                    onTap: () {
                                                                      _scrollNext();
                                                                    },
                                                                    child: SvgPicture
                                                                        .asset(Images
                                                                            .right_previous))),
                                                          ],
                                                        ))
                                                    : SizedBox()),
                                              ],
                                            ))
                                        : SizedBox()),
                                  ])
                            : NoDataScreen(
                                text: 'No Survey Found !',
                                showFooter: false),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )),
      );
    });
  }

  List<Widget> _pageIndicators(
      AuthController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0;
        i < onBoardingController.surveyListModel.data.length;
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

 /* void startTimer() {
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
              .sendSOSAlert(latitude, longitude)
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
  }*/

 /* void showingTimerPopup() {
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
                            fontSize: 50,
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        CustomButton(
                          buttonText: 'Cancel'.tr,
                          onPressed: () {
                            Get.back();
                            Get.find<HomeController>()
                                .sendSOSAlert(latitude, longitude)
                                .then((value) async {
                              if (value.statusCode == 200) {
                                showCustomSnackBar(
                                    value.body["message"] != null
                                        ? value.body["message"].toString()
                                        : "",
                                    isError: false);
                              }
                            });
                          },
                        )
                        *//*  Container(
                         height: 50,
                         child:  InkWell(
                             onTap: () {
                               Get.back();
                               Get.find<HomeController>()
                                   .sendSOSAlert(latitude, longitude)
                                   .then((value) async {
                                 if (value.statusCode == 200) {
                                   showCustomSnackBar(
                                       value.body["message"] != null
                                           ? value.body["message"].toString()
                                           : "",
                                       isError: false);
                                 }
                               });
                             },

                             child: Column(
                               children: [
                                 SvgPicture.asset(
                                   Images.circle_cancel,
                                   height: 50,
                                   width: 50,
                                 )
                               ],
                             )),
                       )*//*
                        ,
                      ]);
                    }),
                  ),
                )),
        dismissible: false);
  }*/
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
