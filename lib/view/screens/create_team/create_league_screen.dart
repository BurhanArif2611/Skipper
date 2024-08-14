import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/screens/create_team/widget/league_card.dart';
import 'package:sixam_mart/view/screens/create_team/widget/member_card.dart';
import 'package:sixam_mart/view/screens/create_team/widget/slider_team_card.dart';
import 'package:sixam_mart/view/screens/kyc/widget/steppage.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../data/model/body/team_create.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../home/widget/team_card.dart';

class CreateLeagueScreen extends StatefulWidget {
  final String matchID;

  CreateLeagueScreen({@required this.matchID});

  @override
  State<CreateLeagueScreen> createState() => _CreateLeagueScreenState();
}

class _CreateLeagueScreenState extends State<CreateLeagueScreen> {
  int _index = 0;
  int activeStep = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _loadData();
    debugPrint("league<><><><>${widget.matchID}");
  }

  void _loadData() async {
    await Get.find<HomeController>().clearData();
    await Get.find<HomeController>().getLeagueList();
    await Get.find<AuthController>().changeTeamMemberSelectIndex(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            CustomAppBar(title: 'League', onBackPressed: () => {Get.back()}),
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
                      GetBuilder<AuthController>(builder: (authController) {
                        return Expanded(
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

                                              Row(
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
                                                            "Contests",
                                                            style: robotoBlack.copyWith(fontSize: Dimensions.fontSizeDefault,
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
                                                            "My Contests (1)",
                                                            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault,
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
                                                            "My Team (2)",
                                                            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault,
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
                                              ],
                                            ),

                                          SizedBox(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          authController
                                                      .selectedTeamMemberIndex ==
                                                  0
                                              ? contests()
                                              : authController
                                                          .selectedTeamMemberIndex ==
                                                      1
                                                  ? myContests()
                                                  : myTeam()
                                        ],
                                      )),
                                ))));
                      })
                    ],
                  ),
                ],
              ));
        }));
  }

  Widget contests() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return


        homeController.leagueList != null &&
              homeController.leagueList.data.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: homeController.leagueList.data.length,
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return LeagueCard(
                    homeController.leagueList.data[index], widget.matchID);
              })
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }

  Widget myContests() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Container();
    });
  }

  Widget myTeam() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return Container(height: 450,
        child: Stack(children: [
          Container(width: MediaQuery.of(context).size.width,
          height: 100,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
        borderRadius:
        BorderRadius.all(
            Radius.circular(
                Dimensions.RADIUS_SMALL)),
      ),
          alignment: Alignment.center,
          child:
          Row(crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(flex:1,child:
            Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("5",style: robotoBold.copyWith(color:Theme.of(context).cardColor ),),
              SizedBox(height: 10,),
              Text("IND",style: robotoMedium.copyWith(color:Theme.of(context).cardColor ),),
            ],)),

            Expanded(flex:1,child:
            Column(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("5",style: robotoBold.copyWith(color:Theme.of(context).cardColor ),),
              SizedBox(height: 10,),
              Text("PAK",style: robotoMedium.copyWith(color:Theme.of(context).cardColor ),),
            ],)),

            Expanded(flex:1,child:
            Container(
                margin:
                EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions
                                .PADDING_SIZE_EXTRA_LARGE), // Set your desired radius
                            child: Image.asset(
                             Images.defult_user_png,
                              fit: BoxFit.fitWidth,
                              height: 100,
                            ))),
                    Positioned(
                        top: 0,
                        left: 0,
                        child:  Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).cardColor),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "C",
                            style: robotoBold.copyWith(
                                color:Theme.of(context).hintColor),
                          ),
                        ),
                        )
                  ],
                ),
              )),


            Expanded(flex:1,child:
            Container(
                margin:
                EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions
                                .PADDING_SIZE_EXTRA_LARGE), // Set your desired radius
                            child: Image.asset(
                              Images.defult_user_png,
                              fit: BoxFit.fitWidth,
                              height: 100,
                            ))),
                    Positioned(
                      top: 0,
                      left: 0,
                      child:  Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color:Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1,
                              color: Theme.of(context).cardColor),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "VC",
                          style: robotoBold.copyWith(
                              color:Theme.of(context).hintColor),
                        ),
                      ),
                    )
                  ],
                ),
              )),


          ],),


          ),

        Positioned(bottom: 10,left: 0,right: 0,
            child: CustomButton(
              height: 50,
              buttonText: 'Create Team'.tr,
              onPressed: () {
                Get.toNamed(RouteHelper.getCreateTeamScreenRoute(widget.matchID,null));
              },
            ),)
      ],),

      );
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
