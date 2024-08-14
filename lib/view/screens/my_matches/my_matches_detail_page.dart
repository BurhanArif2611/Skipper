import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../base/custom_app_bar.dart';
import '../home/widget/dummy_team_card.dart';
import '../home/widget/team_card.dart';

class MyMatchesDetailScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

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

    // _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: CustomAppBar(
            title: 'AUS vs IND', onBackPressed: () => {Get.back()}),
        body: Container(
            color: Theme.of(context).backgroundColor,
            child: Scrollbar(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      margin:
                          EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
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
                                        "Australia",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
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
                                            "210/7",
                                            style: robotoBold.copyWith(
                                                color:
                                                    Theme.of(context).cardColor,
                                                fontSize: Dimensions
                                                    .fontSizeExtraLarge),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "(20)",
                                            style: robotoRegular.copyWith(
                                                color: Theme.of(context)
                                                    .cardColor
                                                    .withOpacity(0.5),
                                                fontSize:
                                                    Dimensions.fontSizeSmall),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "India",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
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
                                            "(20)",
                                            style: robotoRegular.copyWith(
                                                color: Theme.of(context)
                                                    .cardColor
                                                    .withOpacity(0.5),
                                                fontSize:
                                                    Dimensions.fontSizeSmall),
                                          ),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "210/7",
                                            style: robotoBold.copyWith(
                                                color:
                                                    Theme.of(context).cardColor,
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
                            "Live",
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).cardColor),
                          ),
                          Text(
                            "Australia won the toss and elected to field \nSydney Cricket Ground, Sydney",
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
                                              color:
                                                  Theme.of(context).cardColor,
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
                                          "\$5,000",
                                          style: robotoMedium.copyWith(
                                              color:
                                                  Theme.of(context).cardColor,
                                              fontSize:
                                                  Dimensions.fontSizeSmall),
                                        )
                                      ],
                                    )),
                                Expanded(
                                    flex:2,
                                    child: Row(crossAxisAlignment: CrossAxisAlignment.end,
                                       mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(Images.circle_correct_tick),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Guaranteed",
                                          style: robotoMedium.copyWith(
                                              color:
                                                  Theme.of(context).cardColor,
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
                          GetBuilder<AuthController>(builder: (authController) {
                            return
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Scrollbar(
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              padding: EdgeInsets.all(
                                                  Dimensions.PADDING_SIZE_SMALL),
                                              child:
                                              Column(
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
                                                                  textAlign: TextAlign
                                                                      .center,
                                                                ),
                                                              ))),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  ),


                                                ],
                                              )),
                                        )));
                          })
                        ],
                      ),
                    )))));
  }
}
