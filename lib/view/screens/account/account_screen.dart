import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../home/widget/team_card.dart';

class AccountScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
        appBar:
            CustomAppBar(title: 'Account', onBackPressed: () => {Get.back()}),
        body: Container(
            color: Theme.of(context).backgroundColor,
            child: Scrollbar(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Images.team_logo,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Akash Dutt",
                                    style: robotoBold.copyWith(
                                        color: Theme.of(context).cardColor,
                                        fontSize: Dimensions.fontSizeLarge),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "hello@example.com",
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.50),
                                        fontSize: Dimensions.fontSizeDefault),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.getProfileRoute());

                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          Icon(Icons.supervisor_account,
                                              color:
                                                  Theme.of(context).cardColor),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "Account Info",
                                            style: robotoMedium.copyWith(
                                                color: Theme.of(context)
                                                    .cardColor),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Theme.of(context).cardColor,
                                            size: 20,
                                          ),
                                        ],
                                      )),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 0.8,
                            color:
                                Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getLeaderBoardScreenRoute());
                    },
                    child:
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Icon(Icons.leaderboard,
                                          color: Theme.of(context).cardColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Leaderboard",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).cardColor,
                                        size: 20,
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 0.5,
                            color:
                                Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getKYCScreenRoute());
                    },
                    child:
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(Images.kyc,
                                          color: Theme.of(context).cardColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Document KYC",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).cardColor,
                                        size: 20,
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 0.8,
                            color:
                                Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(Images.refer_earn,
                                          color: Theme.of(context).cardColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Refer & Earn",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).cardColor,
                                        size: 20,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 0.5,
                            color:
                                Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(Images.how_play,
                                          color: Theme.of(context).cardColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "How to Play",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).cardColor,
                                        size: 20,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 0.5,
                            color:
                                Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          Images.change_password_new,
                                          color: Theme.of(context).cardColor),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Change Password",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).cardColor,
                                        size: 20,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 0.5,
                            color:
                                Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        Images.support_,
                                        color: Theme.of(context).cardColor,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Support",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).cardColor,
                                        size: 20,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 0.5,
                            color:
                                Theme.of(context).cardColor.withOpacity(0.50),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        Images.privacy_policy,
                                        color: Theme.of(context).cardColor,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Privacy Policy",
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).cardColor),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Theme.of(context).cardColor,
                                        size: 20,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )))));
  }
}
