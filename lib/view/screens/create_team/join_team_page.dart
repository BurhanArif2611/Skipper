import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/data/model/response/league_list.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/common_dailog.dart';
import 'package:sixam_mart/view/screens/create_team/widget/crated_team_card.dart';
import 'package:sixam_mart/view/screens/leader_board/widget/member_list.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/home_controller.dart';
import '../../../data/model/response/featured_matches.dart';
import '../../../data/model/response/matchList/matches.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../home/widget/team_card.dart';

class JoinTeamScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  Matches matchID;
  Data leagueData;

  JoinTeamScreen({@required this.matchID, @required this.leagueData});

  @override
  State<JoinTeamScreen> createState() => _JoinTeamScreenState();
}

class _JoinTeamScreenState extends State<JoinTeamScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time
  Timer _timer;
  double latitude;
  double longitude;

  void _loadData() async {
    await Get.find<HomeController>().selectTeam("");
   
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

  void _JoinTeamData() async {
    await Get.find<HomeController>()
        .joinTeam(widget.matchID.key, widget.leagueData.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar:
            CustomAppBar(title: 'Contest', onBackPressed: () => {Get.back()}),
        body: Container(
            color: Theme.of(context).backgroundColor,
            child: /*Scrollbar(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child:*/
                Container(
              margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Color(0xFF0F0C13),
                        border: Border.all(color: Colors.transparent),
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Price Pool",
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$500",
                          style: robotoBold.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GetBuilder<HomeController>(builder: (homeController) {
                          return InkWell(
                              onTap: () {
                               if( homeController.selectedTeamIDForJoinContest!="")
                                CommonDialog.confirm(context,
                                    "Are you sure? you want to join this contest.",
                                    onPress: () {
                                      _JoinTeamData();
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:homeController.selectedTeamIDForJoinContest!=""? Color(0xFF1D6F00):Color(0xFF1D6F00).withOpacity(0.3),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dimensions.RADIUS_SMALL)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "Join \$500",
                                  style: robotoBold.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                              ));
                        })
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).hintColor,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                SvgPicture.asset(Images.first_st),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "\$5,000",
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeSmall),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                SvgPicture.asset(Images.match),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "\$5,000",
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeSmall),
                                )
                              ],
                            )),
                        Expanded(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(Images.circle_correct_tick),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Guaranteed",
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeSmall),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Text(
                        "Choose a Team",
                        style: robotoBold.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )),
                  myTeam(),
                ],
              ),
            ) /*))*/));
  }

  Widget myTeam() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return homeController.matchTeamList != null ? homeController.matchTeamList.data!=null &&
              homeController.matchTeamList.data.length > 0
          ? Expanded(
              child: Container(
                  margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeController.matchTeamList.data.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return  InkWell(
                            onTap: () {
                              homeController.selectTeam(homeController.matchTeamList.data[index].teamId);
                        },
                        child:

                          CreatedCard(
                            homeController.matchTeamList.data[index],
                            widget.matchID.key,
                            index));
                      }))):
     Center(child:  Text("No Data Found!",style: robotoMedium.copyWith(color: Theme.of(context).cardColor),))
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }
}
