import 'dart:async';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/screens/create_team/widget/member_card.dart';
import 'package:sixam_mart/view/screens/create_team/widget/slider_team_card.dart';
import 'package:sixam_mart/view/screens/kyc/widget/steppage.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../data/model/body/team_create.dart';
import '../../../data/model/response/featured_matches.dart';
import '../../../data/model/response/league_list.dart';
import '../../../data/model/response/matchList/matches.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../home/widget/team_card.dart';

class CreateTeamScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}
  Matches matchID;

  CreateTeamScreen({@required this.matchID});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  int activeStep = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Get.find<HomeController>().clearData();
    await Get.find<HomeController>().getSquadlList(
        widget.matchID.tournament.key,
        widget.matchID.teams.a.key,
        widget.matchID.key,
        widget.matchID);
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
                          child: /*Stack(
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
                                  *//* onBoardingController.changeSelectIndex(index);*//*
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
                          )*/
                          Container(margin:EdgeInsetsDirectional.symmetric (horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child:
                          TeamCardItem(widget.matchID,false))
                      ),

                      Expanded(
                          flex: 10,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child:  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: Column(
                                      children: [
                                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL ,),
                                        GetBuilder<AuthController>(
                                            builder: (authController) {
                                          return GetBuilder<HomeController>(
                                              builder: (homeController) {
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
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              Dimensions.RADIUS_SMALL)),
                                                                )
                                                              : null,
                                                          padding: EdgeInsets
                                                              .all(Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          child: Text(
                                                            "WK (${homeController.keepMenPlayersList.length})",
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
                                                            textAlign: TextAlign
                                                                .center,
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
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              Dimensions.RADIUS_SMALL)),
                                                                )
                                                              : null,
                                                          padding: EdgeInsets
                                                              .all(Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          child: Text(
                                                            "BAT (${homeController.batsMenPlayersList.length})",
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
                                                            textAlign: TextAlign
                                                                .center,
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
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              Dimensions.RADIUS_SMALL)),
                                                                )
                                                              : null,
                                                          padding: EdgeInsets
                                                              .all(Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          child: Text(
                                                            "AR (${homeController.allRoundMenPlayersList.length})",
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
                                                            textAlign: TextAlign
                                                                .center,
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
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              Dimensions.RADIUS_SMALL)),
                                                                )
                                                              : null,
                                                          padding: EdgeInsets
                                                              .all(Dimensions
                                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                          child: Text(
                                                            "BOWL (${homeController.bowlMenPlayersList.length})",
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
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ))),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            );
                                          });
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
                                  Expanded( // Use Expanded if this is inside a Column or Row
                                    child:
                                        GetBuilder<AuthController>(
                                            builder: (authController) {
                                          if (authController
                                                  .selectedTeamMemberIndex ==
                                              0) {
                                            return keeperPlayerList();
                                          }else if (authController
                                                  .selectedTeamMemberIndex ==
                                              1) {
                                            return batsPlayerList();
                                          }else if (authController
                                                  .selectedTeamMemberIndex ==
                                              2) {
                                            return allRounderPlayerList();
                                          }else if (authController
                                                  .selectedTeamMemberIndex ==
                                              3) {
                                            return bowlerPlayerList();
                                          }
                                        })),
                                      ],
                                    )),
                              ))
                    ],
                  ),
                  Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
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
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 1,
                              child: GetBuilder<HomeController>(
                                  builder: (homeController) {
                                return InkWell(
                                    onTap: () {
                                      if (Get.find<HomeController>()
                                                  .selectedPlayersList !=
                                              null &&
                                          Get.find<HomeController>()
                                                  .selectedPlayersList
                                                  .length ==
                                              11) {
                                        Get.toNamed(RouteHelper
                                            .getChooseCaptainScreenRoute(
                                                widget.matchID));
                                      } else {
                                        showCustomSnackBar(
                                            "Please select 11 players only.",
                                            isError: true);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: homeController
                                                    .selectedPlayersList !=
                                                null
                                            ? (homeController
                                                        .selectedPlayersList
                                                        .length ==
                                                    11
                                                ? Color(0xFF1D6F00)
                                                : Colors.red)
                                            : Theme.of(context).disabledColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Dimensions.RADIUS_SMALL)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Next ${homeController.selectedPlayersList.length}/11",
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).cardColor,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),
                                    ));
                              })),
                        ],
                      ))
                ],
              ));
        }));
  }

  Widget keeperPlayerList() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return homeController.keepMenPlayersList != null &&
              homeController.keepMenPlayersList.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.keepMenPlayersList.length,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return MemberCard(homeController.keepMenPlayersList[index]);
              })
          : NoDataScreen(text: "Keepers Not Found!");
    });
  }

  Widget bowlerPlayerList() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return homeController.bowlMenPlayersList != null &&
              homeController.bowlMenPlayersList.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.bowlMenPlayersList.length,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return MemberCard(homeController.bowlMenPlayersList[index]);
              })
          : NoDataScreen(text: "Bowler Not Found!");
    });
  }

  Widget allRounderPlayerList() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return homeController.allRoundMenPlayersList != null &&
              homeController.allRoundMenPlayersList.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.allRoundMenPlayersList.length,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return MemberCard(homeController.allRoundMenPlayersList[index]);
              })
          : NoDataScreen(text: "All Rounder Not Found!");
    });
  }

  Widget batsPlayerList() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return homeController.batsMenPlayersList != null &&
              homeController.batsMenPlayersList.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.batsMenPlayersList.length,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return MemberCard(homeController.batsMenPlayersList[index]);
              })
          : NoDataScreen(text: "Bats Men Not Found!");
    });
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
