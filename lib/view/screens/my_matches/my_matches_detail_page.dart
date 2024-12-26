import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/my_matches/widget/leaderboard_list.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../../controller/home_controller.dart';
import '../../../data/model/response/matchList/matches.dart';
import '../../base/custom_app_bar.dart';
import '../../base/no_data_screen.dart';
import '../home/widget/dummy_team_card.dart';
import '../home/widget/team_card.dart';

class MyMatchesDetailScreen extends StatefulWidget {
  String leagueid;
  Matches matches;
  MyMatchesDetailScreen({this.leagueid,this.matches});

  @override
  State<MyMatchesDetailScreen> createState() => _MyMatchesDetailScreenState();
}

class _MyMatchesDetailScreenState extends State<MyMatchesDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time
  Timer _timer;
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await Get.find<HomeController>().getLeaderBoardList(widget.leagueid);
    await Get.find<AuthController>().changeTeamMemberSelectIndex(1);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());

    return  Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(
            title: '${widget.matches.teams.a.code} vs ${widget.matches.teams.b.code}', onBackPressed: () => {Get.back()}),
        body: RefreshIndicator(
            onRefresh: () async {
              _loadData();
            },
            child: Container(
                color: Theme.of(context).backgroundColor,
                child: Scrollbar(
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          alignment: Alignment.center,
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          margin: EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_SMALL),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${widget.matches.teams.a.name}',
                                            style: robotoMedium.copyWith(
                                                color: Theme.of(context)
                                                    .cardColor),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                          .PADDING_SIZE_EXTRA_LARGE),
                                                  // Set your desired radius
                                                  child: Image.asset(
                                                    Images.defult_user_png,
                                                    fit: BoxFit.fitWidth,
                                                    height: 40,
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "000/00",
                                                style: robotoBold.copyWith(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    fontSize: Dimensions
                                                        .fontSizeExtraLarge),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "(00)",
                                                style: robotoRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .cardColor
                                                        .withOpacity(0.5),
                                                    fontSize: Dimensions
                                                        .fontSizeSmall),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${widget.matches.teams.b.name}',
                                            style: robotoMedium.copyWith(
                                                color: Theme.of(context)
                                                    .cardColor),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "(00)",
                                                style: robotoRegular.copyWith(
                                                    color: Theme.of(context)
                                                        .cardColor
                                                        .withOpacity(0.5),
                                                    fontSize: Dimensions
                                                        .fontSizeSmall),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "000/00",
                                                style: robotoBold.copyWith(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    fontSize: Dimensions
                                                        .fontSizeExtraLarge),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .circular(Dimensions
                                                          .PADDING_SIZE_EXTRA_LARGE),
                                                  // Set your desired radius
                                                  child: Image.asset(
                                                    Images.defult_user_png,
                                                    fit: BoxFit.fitWidth,
                                                    height: 40,
                                                  )),
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${widget.matches.play_status == "scheduled" ? "Scheduled" : widget.matches.play_status == "started" || widget.matches.play_status == "in_play" ? "Live" : widget.matches.play_status}",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).errorColor),
                              ),
                              Text(
                                "${widget.matches.venue.name}\n${widget.matches.venue.city}",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context)
                                        .cardColor
                                        .withOpacity(0.5),
                                    fontSize: Dimensions.fontSizeSmall),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 40,
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
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
                                              "NA",
                                              style: robotoMedium.copyWith(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
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
                                              "NA",
                                              style: robotoMedium.copyWith(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                            )
                                          ],
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SvgPicture.asset(
                                                Images.circle_correct_tick),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Guaranteed",
                                              style: robotoMedium.copyWith(
                                                  color: Theme.of(context)
                                                      .cardColor,
                                                  fontSize:
                                                      Dimensions.fontSizeSmall),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GetBuilder<AuthController>(
                                  builder: (authController) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
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
                                                        "Winnings",
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
                                                        "Leaderboard",
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
                                                        "Scorecard",
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
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        if (authController
                                                .selectedTeamMemberIndex ==
                                            1)
                                          leaderBoardList(),
                                      ],
                                    ));
                              })
                            ],
                          ),
                        ))))));
  }

  Widget leaderBoardList() {
    return GetBuilder<HomeController>(builder: (homeController) {
      return homeController.leaderBoardData != null
          ? homeController.leaderBoardData.data.leaderBoardDetails != null &&
                  homeController
                          .leaderBoardData.data.leaderBoardDetails.length >
                      0
              ? Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: homeController
                          .leaderBoardData.data.leaderBoardDetails.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index_option) {
                        return LeaderBoardUserList(homeController
                            .leaderBoardData
                            .data
                            .leaderBoardDetails[index_option]);
                      }))
              : Expanded(child: NoDataScreen(text: 'No Data Found'))
          : SizedBox.shrink();
    });
  }
}
