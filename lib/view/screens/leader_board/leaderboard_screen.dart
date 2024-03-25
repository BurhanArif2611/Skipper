import 'dart:async';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/leader_board/widget/member_list.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../base/custom_app_bar.dart';
import '../home/widget/team_card.dart';

class LeaderBoardScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
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
        appBar: CustomAppBar(
            title: 'Leaderboard', onBackPressed: () => {Get.back()}),
        body: Container(
            color: Theme.of(context).backgroundColor,
            child: Scrollbar(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      margin:
                          EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            decoration:BoxDecoration(
                                color: Color(0xFF0F0C13),
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL)) ,
                            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Text(
                                "Price Pool",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context)
                                        .cardColor
                                        ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "\$500",
                                style: robotoBold.copyWith(
                                    color: Theme.of(context)
                                        .cardColor,fontSize: Dimensions.fontSizeLarge
                                        ),
                              ),
                              SizedBox(height: 10,),
                              Container(width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:Color(0xFF1D6F00) ,
                                  borderRadius: BorderRadius.all( Radius.circular(Dimensions.RADIUS_SMALL)),
                                ),
                                alignment: Alignment.center,
                                child: Text("Join \$500",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeLarge),),
                              )
                            ],),
                          ),

                          Text(
                            "All Teams (7)",
                            style: robotoMedium.copyWith(
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.5)),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemCount: 10,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index_option) {
                                return MemberListItem();
                              }),
                        ],
                      ),
                    )))));
  }
}
