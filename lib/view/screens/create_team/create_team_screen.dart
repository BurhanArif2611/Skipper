import 'dart:async';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/screens/create_team/widget/member_card.dart';
import 'package:sixam_mart/view/screens/create_team/widget/slider_team_card.dart';
import 'package:sixam_mart/view/screens/kyc/widget/steppage.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../home/widget/team_card.dart';

class CreateTeamScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  int _index = 0;
  int activeStep = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
   // await Get.find<HomeController>().clearData();
    await Get.find<HomeController>().getSquadlList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: 'Create Team', onBackPressed: () => {Get.back()}),
        body: GetBuilder<OnBoardingController>(builder: (onBoardingController) {
          return Container(
              color: Theme.of(context).backgroundColor,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(5),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              PageView.builder(
                                itemCount: 10,
                                controller: _pageController,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: EdgeInsets.all(10),
                                      child: SliderTeamCard());
                                },
                                onPageChanged: (index) {
                                  /* onBoardingController.changeSelectIndex(index);*/
                                },
                              ),
                              Positioned(
                                  bottom: 20,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _pageIndicators(
                                        onBoardingController, context),
                                  )),
                            ],
                          )),
                      Expanded(
                          flex: 10,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Scrollbar(
                                  child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: Column(
                                      children: [
                                        GetBuilder<AuthController>(
                                            builder: (authController) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                      onTap: () {
                                                        authController
                                                            .changeTeamMemberSelectIndex(
                                                                0);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: authController
                                                                    .selectedTeamMemberIndex ==
                                                                0
                                                            ? BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFFF8CA0A),
                                                                    Color(
                                                                        0xFFFFE166),
                                                                    Color(
                                                                        0xFFDCB822),
                                                                    Color(
                                                                        0xFFFFE166),
                                                                  ],
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight,
                                                                ),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        Dimensions
                                                                            .RADIUS_SMALL)),
                                                              )
                                                            : null,
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        child: Text(
                                                          "WK (2)",
                                                          style: robotoBlack.copyWith(
                                                              color: authController
                                                                          .selectedTeamMemberIndex ==
                                                                      0
                                                                  ? Theme.of(
                                                                          context)
                                                                      .hintColor
                                                                  : Theme.of(
                                                                          context)
                                                                      .cardColor
                                                                      .withOpacity(
                                                                          0.5)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                      onTap: () {
                                                        authController
                                                            .changeTeamMemberSelectIndex(
                                                                1);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: authController
                                                                    .selectedTeamMemberIndex ==
                                                                1
                                                            ? BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFFF8CA0A),
                                                                    Color(
                                                                        0xFFFFE166),
                                                                    Color(
                                                                        0xFFDCB822),
                                                                    Color(
                                                                        0xFFFFE166),
                                                                  ],
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight,
                                                                ),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        Dimensions
                                                                            .RADIUS_SMALL)),
                                                              )
                                                            : null,
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        child: Text(
                                                          "BAT (0)",
                                                          style: robotoBold.copyWith(
                                                              color: authController
                                                                          .selectedTeamMemberIndex ==
                                                                      1
                                                                  ? Theme.of(
                                                                          context)
                                                                      .hintColor
                                                                  : Theme.of(
                                                                          context)
                                                                      .cardColor
                                                                      .withOpacity(
                                                                          0.5)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                      onTap: () {
                                                        authController
                                                            .changeTeamMemberSelectIndex(
                                                                2);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: authController
                                                                    .selectedTeamMemberIndex ==
                                                                2
                                                            ? BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFFF8CA0A),
                                                                    Color(
                                                                        0xFFFFE166),
                                                                    Color(
                                                                        0xFFDCB822),
                                                                    Color(
                                                                        0xFFFFE166),
                                                                  ],
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight,
                                                                ),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        Dimensions
                                                                            .RADIUS_SMALL)),
                                                              )
                                                            : null,
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        child: Text(
                                                          "AR (0)",
                                                          style: robotoBold.copyWith(
                                                              color: authController
                                                                          .selectedTeamMemberIndex ==
                                                                      2
                                                                  ? Theme.of(
                                                                          context)
                                                                      .hintColor
                                                                  : Theme.of(
                                                                          context)
                                                                      .cardColor
                                                                      .withOpacity(
                                                                          0.5)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                      onTap: () {
                                                        authController
                                                            .changeTeamMemberSelectIndex(
                                                                3);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: authController
                                                                    .selectedTeamMemberIndex ==
                                                                3
                                                            ? BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    Color(
                                                                        0xFFF8CA0A),
                                                                    Color(
                                                                        0xFFFFE166),
                                                                    Color(
                                                                        0xFFDCB822),
                                                                    Color(
                                                                        0xFFFFE166),
                                                                  ],
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight,
                                                                ),
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        Dimensions
                                                                            .RADIUS_SMALL)),
                                                              )
                                                            : null,
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .PADDING_SIZE_EXTRA_SMALL),
                                                        child: Text(
                                                          "BOWL (0)",
                                                          style: robotoBold.copyWith(
                                                              color: authController
                                                                          .selectedTeamMemberIndex ==
                                                                      3
                                                                  ? Theme.of(
                                                                          context)
                                                                      .hintColor
                                                                  : Theme.of(
                                                                          context)
                                                                      .cardColor
                                                                      .withOpacity(
                                                                          0.5)),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          );
                                        }),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "Select 1-8 Wicket Keepers",
                                                  style: robotoBold.copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize: Dimensions
                                                          .fontSizeLarge),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  SvgPicture.asset(
                                                      Images.filter),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: Text(
                                                  "Selected by",
                                                  style: robotoBold.copyWith(
                                                      color: Theme.of(context)
                                                          .cardColor
                                                          .withOpacity(0.5),
                                                      fontSize: Dimensions
                                                          .fontSizeSmall),
                                                )),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Points",
                                                style: robotoBold.copyWith(
                                                    color: Theme.of(context)
                                                        .cardColor
                                                        .withOpacity(0.5),
                                                    fontSize: Dimensions
                                                        .fontSizeSmall),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                "Credits",
                                                style: robotoBold.copyWith(
                                                    color: Theme.of(context)
                                                        .cardColor
                                                        .withOpacity(0.5),
                                                    fontSize: Dimensions
                                                        .fontSizeSmall),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GetBuilder<HomeController>(
                                            builder: (homeController) {
                                          return homeController.playersList!=null && homeController.playersList.length>0?
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: homeController.playersList.length,
                                              physics: ScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (context, index) {
                                                return MemberCard(homeController.playersList[index]);
                                              }):Center(child: CircularProgressIndicator(),);
                                        }),
                                      ],
                                    )),
                              ))))
                    ],
                  ),
                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFF8CA0A),
                                  Color(0xFFFFE166),
                                  Color(0xFFDCB822),
                                  Color(0xFFFFE166),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimensions.RADIUS_SMALL)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Preview",
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: () {
                               if( Get.find<HomeController>().selectedPlayersList!=null &&  Get.find<HomeController>().selectedPlayersList.length>=11){

                                Get.toNamed(
                                    RouteHelper.getChooseCaptainScreenRoute());}
                               else {
                                 showCustomSnackBar("Please select at list 11 players",isError: true);
                               }
                              },
                              child: Container(
                                width: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1D6F00),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.RADIUS_SMALL)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Next",
                                  style: robotoBold.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                              )),
                        ],
                      ))
                ],
              ));
        }));
  }

  void _moveToPage(int page) {
    setState(() {
      if (page == 3) {
        activeStep = page + 1;
      } else {
        activeStep = page;
      }
    });
    print("activeStep>>>${activeStep}");
  }

  List<Widget> _pageIndicators(
      OnBoardingController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < 10; i++) {
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
