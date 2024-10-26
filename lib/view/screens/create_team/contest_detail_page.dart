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
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../home/widget/team_card.dart';

class ContestDetailPage extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}



  ContestDetailPage();

  @override
  State<ContestDetailPage> createState() => _ContestDetailPageState();
}

class _ContestDetailPageState extends State<ContestDetailPage> {
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
  /*  await Get.find<HomeController>()
        .joinTeam(widget.matchID.key, widget.leagueData.leagueId);*/
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
                  GetBuilder<HomeController>(builder: (homeController) {
                    return
                     Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                     child:
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                  onTap: () {
                                    homeController
                                        .changeTeamMemberSelectIndex(
                                        0);
                                  },
                                  child: Container(
                                    alignment:
                                    Alignment.center,
                                    decoration: homeController
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
                                      "Contests",
                                      style: robotoBlack.copyWith(
                                          fontSize: Dimensions
                                              .fontSizeDefault,
                                          color: homeController
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
                                    homeController
                                        .changeTeamMemberSelectIndex(
                                        1);
                                  },
                                  child: Container(
                                    alignment:
                                    Alignment.center,
                                    decoration: homeController
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
                                      "My Contests ${ homeController.myContestList != null && homeController.myContestList.data!=null &&
                                          homeController.myContestList.data.length > 0?"("+homeController.myContestList.data.length.toString()+")":""}",
                                      style: robotoBold.copyWith(
                                          fontSize: Dimensions
                                              .fontSizeDefault,
                                          color: homeController
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
                                    homeController
                                        .changeTeamMemberSelectIndex(
                                        2);
                                  },
                                  child: Container(
                                    alignment:
                                    Alignment.center,
                                    decoration: homeController
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
                                      "My Team ${ homeController.matchTeamList != null && homeController.matchTeamList.data!=null &&
                                          homeController.matchTeamList.data.length > 0?"("+homeController.matchTeamList.data.length.toString()+")":""}",
                                      style: robotoBold.copyWith(
                                          fontSize: Dimensions
                                              .fontSizeDefault,
                                          color: homeController
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
                        ],
                      ));

                  }),

                ],
              ),
            ) /*))*/));
  }

}
