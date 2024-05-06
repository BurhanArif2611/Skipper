import 'dart:async';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/controller/home_controller.dart';
import 'package:sixam_mart/data/model/response/player.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/create_team/widget/captain_selection_card.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../data/model/body/team_create.dart';
import '../../../data/model/response/league_list.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_snackbar.dart';

class ChooseCaptainTeamScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}


  Data league;
  String matchID;

  ChooseCaptainTeamScreen(
      {@required this.league,@required this.matchID});
  @override
  State<ChooseCaptainTeamScreen> createState() =>
      ChooseCaptainTeamScreenState();
}

class ChooseCaptainTeamScreenState extends State<ChooseCaptainTeamScreen> {
  int _index = 0;
  int activeStep = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // _loadData();
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
        body: GetBuilder<HomeController>(builder: (homeController) {
          return Container(
              color: Theme.of(context).backgroundColor,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Choose your Captain and Vice Captain",
                            style: robotoBold.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "C Get 2X Points, VC Get 1.5X Points",
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).cardColor,
                                fontSize: Dimensions.fontSizeSmall),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Type",
                                    style: robotoBold.copyWith(
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.5),
                                        fontSize: Dimensions.fontSizeSmall),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Points",
                                    style: robotoBold.copyWith(
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.5),
                                        fontSize: Dimensions.fontSizeSmall),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "%C By",
                                  style: robotoBold.copyWith(
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.5),
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "%VC By",
                                  style: robotoBold.copyWith(
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.5),
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          homeController.selectedPlayersList != null &&
                                  homeController.selectedPlayersList.length > 0
                              ? Expanded(
                                  flex: 1,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      /* controller: _scrollController,*/
                                      itemCount: homeController
                                          .selectedPlayersList.length,
                                      /*physics: ScrollPhysics(),*/
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return CaptainSelectionCard(
                                            homeController
                                                .selectedPlayersList[index],
                                            homeController);
                                      }))
                              : SizedBox(),
                        ],
                      )),
                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.toNamed(
                                    RouteHelper.getFinalTeamScreenRoute());
                              },
                              child: Container(
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
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                              onTap: homeController.captainId != null &&
                                      homeController.captainId != "" &&
                                      homeController.vCaptainId != null &&
                                      homeController.vCaptainId != ""
                                  ? () {
                                      homeController
                                          .finalPlayerList()
                                          .then((value) async {
                                        if (value != null &&
                                            value.length >= 11) {
                                          createTeam(homeController, value);
                                        }else {
                                          showCustomSnackBar("Please Select Proper team members",isError: false);
                                        }
                                      });
                                    }
                                  : null,
                              child: Container(
                                width: 80,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: homeController.captainId != null &&
                                          homeController.captainId != "" &&
                                          homeController.vCaptainId != null &&
                                          homeController.vCaptainId != ""
                                      ? Color(0xFF1D6F00)
                                      : Color(0xFF9EC98E),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.RADIUS_SMALL)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Save",
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

  void createTeam(HomeController homeController, List<Player> value) async {
    UserDetails userDetails = UserDetails(
        userName: homeController.userDetailModel.id.toString(),
        emailId: homeController.userDetailModel.contactDTO != null
            ? homeController.userDetailModel.contactDTO.email
            : "");

    Request request = Request(
      teamName: "VKROCKS",
      leagueId: widget.league.leagueId,
      tournamentId: widget.matchID,
      matchId: widget.league.matchId,
      venueId: widget.league.venueid,
      capton: value[0].name,
      captonId: "sdsaad",
      captonpoint: "10.2",
      team1: value[1].name,
      team1Id: "asdasd",
      team1point: "20.3",
      team2: value[2].name,
      team2Id: "sadasdas",
      team2point: "30.3",
      team3: value[3].name,
      team3Id: "asdasdasd",
      team3point: "34.4",
      team4: value[4].name,
      team4Id: "asdasdasd",
      team4point: "45.6",
      team5: value[5].name,
      team5Id: "asdasd",
      team5point: "4.5",
      team6: value[6].name,
      team6Id: "asdasd",
      team6point: "6.0",
      team7: value[7].name,
      team7Id: "sadasd",
      team7point: "8.0",
      team8: value[8].name,
      team8Id: "asdasd",
      team8point: "32.4",
      team9: value[9].name,
      team9Id: "asdasda",
      team9point: "45.6",
      team10: value[10].name,
      team10Id: "asdasd",
      team10point: "30.3",
      playeridCapton: value[0].key,
      playerid1: value[1].key,
      playerid2: value[2].key,
      playerid3: value[3].key,
      playerid4: value[4].key,
      playerid5: value[5].key,
      playerid6: value[6].key,
      playerid7: value[7].key,
      playerid8: value[8].key,
      playerid9: value[9].key,
      playerid10: value[10].key,
    );


    TeamCreate teamCreate =
        TeamCreate(userDetails: userDetails, request: request);
    homeController.createTeam(teamCreate).then((status) async {
      if (status.statusCode == 200) {
        if (status.body['metadata']['code'] == 200 ||
            status.body['metadata']['code'] == "200") {
          /* Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.signUp));*/
        } else {
          showCustomSnackBar(status.body['metadata']['message']);
        }
      } else {
        showCustomSnackBar(status.body["message"]);
      }
    });
  }
}
