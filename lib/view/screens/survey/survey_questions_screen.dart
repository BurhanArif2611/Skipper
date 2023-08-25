import 'dart:ffi';

import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';


import '../../../controller/dashboard_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../data/model/response/survey_list_model.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_image.dart';
import '../../base/custom_snackbar.dart';
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
  int PaginationIndex;

  void _loadData() async {
    await Get.find<HomeController>().getSurveysDetail(widget.data.sId);
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
                        child:
                            onBoardingController.surveyDetailModel != null &&
                                    onBoardingController.surveyDetailModel.data
                                            .surveyQuestions.length >
                                        0
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
                                                  onBoardingController,
                                                  context),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_EXTRA_LARGE),
                                        (onBoardingController
                                                        .surveyDetailModel !=
                                                    null &&
                                                onBoardingController
                                                        .surveyDetailModel
                                                        .data !=
                                                    null &&
                                                onBoardingController
                                                        .surveyDetailModel
                                                        .data
                                                        .surveyQuestions
                                                        .length >
                                                    0
                                            ? Expanded(
                                                flex: 15,
                                                child: Column(mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                  Expanded(
                                                  flex: 16,
                                                  child:
                                                PageView.builder(
                                                  itemCount:
                                                      onBoardingController
                                                          .surveyDetailModel
                                                          .data
                                                          .surveyQuestions
                                                          .length,
                                                  controller: _pageController,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                        String optionID = "";
                                                    if(onBoardingController.selectedOptionIdList!=null && onBoardingController.selectedOptionIdList.length>0){
                                                      for (int i = 0; i < onBoardingController.selectedOptionIdList.length; i++) {
                                                        if (onBoardingController.selectedOptionIdList[i].question == onBoardingController.surveyDetailModel.data.surveyQuestions[index].sId) {
                                                            optionID=onBoardingController.selectedOptionIdList[i].options;
                                                            break;
                                                          }
                                                        }
                                                    }



                                                    return Container(
                                                      margin: EdgeInsets.all(
                                                          Dimensions
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
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      "Q.${index + 1}  " +
                                                                          onBoardingController
                                                                              .surveyDetailModel
                                                                              .data
                                                                              .surveyQuestions[index]
                                                                              .question,
                                                                      style: robotoBold.copyWith(
                                                                          color: Theme.of(context)
                                                                              .hintColor,
                                                                          fontSize:
                                                                              Dimensions.fontSizeLarge),
                                                                    ))
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: Dimensions
                                                                    .PADDING_SIZE_EXTRA_SMALL),

                                                            Container(
                                                              /* color: Colors.red,*/
                                                              height: 500,
                                                              child: ListView
                                                                  .builder(
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
                                                                itemBuilder:
                                                                    (context,
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
                                                                      onTap:
                                                                          () {
                                                                        homeController.changeOptionSelectIndex(onBoardingController.surveyDetailModel.data.surveyQuestions[index].sId, onBoardingController.surveyDetailModel.data.surveyQuestions[index].options[index_option].sId,index_option);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                                                        child: Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Container(
                                                                                height: 40,
                                                                                width: 40,
                                                                                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(50.0),
                                                                                  border: Border.all(width: 0.4, color: Theme.of(context).hintColor),
                                                                                  color: optionID == onBoardingController.surveyDetailModel.data.surveyQuestions[index].options[index_option].sId ? Theme.of(context).primaryColor : Colors.transparent,
                                                                                ),
                                                                                alignment: Alignment.center,
                                                                                child:
                                                                                    /* Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: */
                                                                                    Text(
                                                                                  "$optionPosition ",
                                                                                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault, color: optionID == onBoardingController.surveyDetailModel.data.surveyQuestions[index].options[index_option].sId ? Colors.white : Theme.of(context).primaryColor),
                                                                                  textAlign: TextAlign.center,
                                                                                ), /* )*/
                                                                              ),
                                                                              SizedBox(width: Dimensions.PADDING_SIZE_LARGE),
                                                                              Text(
                                                                                onBoardingController.surveyDetailModel.data.surveyQuestions[index].options[index_option].option,
                                                                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: optionID == onBoardingController.surveyDetailModel.data.surveyQuestions[index].options[index_option].sId ? Theme.of(context).primaryColor : Theme.of(context).hintColor),
                                                                                textAlign: TextAlign.start,
                                                                              ),
                                                                            ]),
                                                                      ));
                                                                },
                                                              ),
                                                            ),

                                                          ]),
                                                    );
                                                  },
                                                  onPageChanged: (index) {
                                                    onBoardingController
                                                        .changeSelectIndex(
                                                            index);
                                                  },
                                                )),
                                                    ( onBoardingController
                                                        .surveyDetailModel
                                                        !=null && onBoardingController
                                                        .surveyDetailModel
                                                        .data !=null &&  onBoardingController
                                                        .surveyDetailModel
                                                        .data.surveyQuestions.length>0 ?
                                            Expanded(
                                              flex: 2,
                                              child:
                                            Row(
                                              children: [
                                                Expanded(
                                                    flex: 1,
                                                    child: InkWell(
                                                        onTap:
                                                            () {_scrollPrevious();},
                                                        child: SvgPicture.asset(
                                                            Images.left_previous))),
                                                SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_DEFAULT),
                                                Expanded(
                                                    flex: 4,
                                                    child:
                                                    InkWell(
                                                        onTap :() {

                                                          print("first >>${onBoardingController
                                                              .surveyDetailModel
                                                              .data
                                                              .surveyQuestions
                                                              .length}");
                                                          print("second >>${PaginationIndex}");

                                                       if( onBoardingController
                                                           .surveyDetailModel
                                                           .data
                                                           .surveyQuestions
                                                           .length-1==(PaginationIndex)){
                                                         homeController.submitSurveyResult(onBoardingController
                                                             .surveyDetailModel
                                                             .data.survey.sId).then((value)  async{
                                                               if(value.statusCode==200){
                                                                 showCustomSnackBar(
                                                                     value.body["message"],
                                                                     isError: false);
                                                                 Get.back();
                                                               }else {
                                                                 showCustomSnackBar(
                                                                     value.body["message"],
                                                                     isError: true);
                                                               }
                                                         });
                                                       }
                                                          },
                                                        child:
                                                        Container(
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
                                                          onBoardingController
                                                              .surveyDetailModel
                                                              .data
                                                              .surveyQuestions
                                                              .length-1==(PaginationIndex)?"Submit":"Next",
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
                                                        onTap:
                                                            () {
                                                          _scrollNext();
                                                        },
                                                        child: SvgPicture.asset(
                                                            Images.right_previous))),
                                              ],
                                            )):SizedBox()),
                                                  ],)
                                        )
                                            : SizedBox()),
                                      ])
                                : NoDataScreen(
                                    text: 'No Questions Found !',
                                    showFooter: false),
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
