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
import 'package:sixam_mart/view/base/common_dailog.dart';
import 'package:sixam_mart/view/screens/create_team/widget/captain_selection_card.dart';

import '../../../controller/onboarding_controller.dart';
import '../../../controller/splash_controller.dart';
import '../../../data/model/request_body/create_team.dart';
import '../../../data/model/response/matchList/matches.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_dialog.dart';
import '../../base/custom_snackbar.dart';

class ChooseCaptainTeamScreen extends StatefulWidget {



  Matches matchID;

  ChooseCaptainTeamScreen({ @required this.matchID});

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
              color: Theme
                  .of(context)
                  .backgroundColor,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              padding: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Choose your Captain and Vice Captain",
                            style: robotoBold.copyWith(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: Dimensions.fontSizeLarge),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "C Get 2X Points, VC Get 1.5X Points",
                            style: robotoMedium.copyWith(
                                color: Theme
                                    .of(context)
                                    .cardColor,
                                fontSize: Dimensions.fontSizeSmall),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,right: Dimensions.PADDING_SIZE_SMALL),
                          child:
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Type",
                                    style: robotoBold.copyWith(
                                        color: Theme
                                            .of(context)
                                            .cardColor
                                            .withOpacity(0.5),
                                        fontSize: Dimensions.fontSizeSmall),
                                  )),
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Points",
                                    style: robotoBold.copyWith(
                                        color: Theme
                                            .of(context)
                                            .cardColor
                                            .withOpacity(0.5),
                                        fontSize: Dimensions.fontSizeSmall),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "%C By",
                                  style: robotoBold.copyWith(
                                      color: Theme
                                          .of(context)
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
                                      color: Theme
                                          .of(context)
                                          .cardColor
                                          .withOpacity(0.5),
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                              )
                            ],
                          )),

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
                                    RouteHelper.getFinalTeamScreenRoute(widget.matchID));
                              },
                              child: Container(
                                width: 200,
                                height: 50,
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
                                      color: Theme
                                          .of(context)
                                          .hintColor,
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
                                Get.find<SplashController>().showLoader();
                                Get.find<SplashController>().determinePosition(context).then((value) async {
                                  if (value != null)
                                    Get.find<SplashController>().getBlackGeoList(
                                        value.latitude, value.longitude).then((value) async{
                                      if(!value){
                                        homeController
                                            .finalPlayerList()
                                            .then((value) async {
                                          print("member list>>>>${value.length.toString()}");

                                          if (value != null &&
                                              value.length == 11) {
                                            createTeam(homeController, value);
                                          } else {
                                            showCustomSnackBar(
                                                "Please select 11 team members only.",
                                                isError: true);
                                          }
                                        });
                                      }
                                      else {
                                        CommonDialog.info(context, "Sorry Our Service is not enable in your location");
                                      }
                                    });
                                });


                              }
                                  : null,
                              child: GetBuilder<SplashController>(builder: (splashController) {
                               return
                              Container(
                                width: 80,
                                height: 50,
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
                                child:splashController.isLoading?Padding(padding:EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL),child:
                                Center(child: SizedBox(
                                  height: 20.0, // Set the desired height
                                  width: 20.0,  // Set the desired width
                                  child: CircularProgressIndicator(),
                                ),)): Text(
                                  "Save",
                                  style: robotoBold.copyWith(
                                      color: Theme
                                          .of(context)
                                          .cardColor,
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                              );})
                          ),
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

  List<Widget> _pageIndicators(OnBoardingController onBoardingController,
      BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < 10; i++) {
      _indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex
                ? Theme
                .of(context)
                .primaryColor
                : Theme
                .of(context)
                .disabledColor,
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
        userId:homeController.userDetailModel!=null && homeController.userDetailModel.id!=null? homeController.userDetailModel.id.toString():"",
        emailId: homeController.userDetailModel.contactDTO != null
            ? homeController.userDetailModel.contactDTO.email
            : "");
    List<MainTeams> teams = [];

    for (int i = 0; i < value.length; i++) {
      MainTeams teams_ = MainTeams(playerId: value[i].key,
          name: value[i].name,
          point: 10.5,
          positionId: i == 0 ? "capton" : i == 1 ? "wise_capton" : "any");
      teams.add(teams_);
    }

    Request request = Request(
      teamName:homeController.userDetailModel!=null? homeController.userDetailModel.name+" "+homeController.userDetailModel.surname:"",
      tournamentId: widget.matchID.tournament.key,
      matchId: widget.matchID.key,
      venueId:widget.matchID.venue.key,
        teams: teams
    );

    CreateTeamRequest createTeamRequest = CreateTeamRequest(
        userDetails: userDetails, request:request);

   // print("request>>>>${createTeamRequest.toJson()}");

    homeController.createTeam(createTeamRequest).then((status) async {
      if (status.statusCode == 200) {
        if (status.body['metadata']['code'] == 200 ||
            status.body['metadata']['code'] == "200") {
          showingAudioFile();
          /* Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.signUp));*/
        } else {
          showCustomSnackBar(status.body['metadata']['message']);
        }
      } else {
        showCustomSnackBar(status.body["message"]);
      }
    });
  }

  void showingAudioFile() {
    showAnimatedDialog(
        context,
        Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius:
                BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
            child: GetBuilder<HomeController>(builder: (controller) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(Images.circle_correct_tick, width: 100, height: 100,color: Colors.green,),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Text(
                  'Team Create successfully.'
                      .tr,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).textTheme.bodyText1.color,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                CustomButton(
                  buttonText:  'ok'.tr
                  ,
                  onPressed: () {
                   /* Get.toNamed(RouteHelper.getDashboardRoute());*/
                    Get.offAllNamed(RouteHelper.getCreateLeagueRoute(widget.matchID));
                   // Get.offAllNamed(RouteHelper.getInitialRoute());
                  },
                )
              ]);
            }),
          ),
        ),
        dismissible: false);
  }
}
