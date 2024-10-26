import 'dart:async';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../../controller/dashboard_controller.dart';
import '../../../controller/home_controller.dart';
import '../../base/custom_app_bar.dart';
import '../../base/no_data_screen.dart';
import '../home/widget/dummy_team_card.dart';

class MyMatchesScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<MyMatchesScreen> createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time
  Timer _timer;
  double latitude;
  double longitude;

  void _loadData() async {
    await Get.find<HomeController>().getMyMatchesList("");

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

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());

    return Scaffold(
        appBar: CustomAppBar(
            title: 'My Matches', onBackPressed: () => {
        Get.find<DashboardController>().changeIndex(0)

            }),
        body: Container(
                      color: Theme.of(context).backgroundColor,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child:
                      GetBuilder<AuthController>(
                          builder: (authController) {
                            return
                          Column(mainAxisSize: MainAxisSize.max,
                              children: [
                             Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                          onTap: () {
                                            authController
                                                .changeTeamMemberSelectIndex(0);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: authController
                                                        .selectedTeamMemberIndex ==
                                                    0
                                                ? BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFF8CA0A),
                                                        Color(0xFFFFE166),
                                                        Color(0xFFDCB822),
                                                        Color(0xFFFFE166),
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            Dimensions
                                                                .RADIUS_SMALL)),
                                                  )
                                                : null,
                                            padding: EdgeInsets.all(Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                            child: Text(
                                              "Live",
                                              style: robotoBlack.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault,
                                                  color: authController
                                                              .selectedTeamMemberIndex ==
                                                          0
                                                      ? Theme.of(context)
                                                          .hintColor
                                                      : Theme.of(context)
                                                          .cardColor
                                                          .withOpacity(0.5)),
                                              textAlign: TextAlign.center,
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
                                                .changeTeamMemberSelectIndex(1);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: authController
                                                        .selectedTeamMemberIndex ==
                                                    1
                                                ? BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFF8CA0A),
                                                        Color(0xFFFFE166),
                                                        Color(0xFFDCB822),
                                                        Color(0xFFFFE166),
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            Dimensions
                                                                .RADIUS_SMALL)),
                                                  )
                                                : null,
                                            padding: EdgeInsets.all(Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                            child: Text(
                                              "UpComing",
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault,
                                                  color: authController
                                                              .selectedTeamMemberIndex ==
                                                          1
                                                      ? Theme.of(context)
                                                          .hintColor
                                                      : Theme.of(context)
                                                          .cardColor
                                                          .withOpacity(0.5)),
                                              textAlign: TextAlign.center,
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
                                                .changeTeamMemberSelectIndex(2);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: authController
                                                        .selectedTeamMemberIndex ==
                                                    2
                                                ? BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFF8CA0A),
                                                        Color(0xFFFFE166),
                                                        Color(0xFFDCB822),
                                                        Color(0xFFFFE166),
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            Dimensions
                                                                .RADIUS_SMALL)),
                                                  )
                                                : null,
                                            padding: EdgeInsets.all(Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL),
                                            child: Text(
                                              "Completed",
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault,
                                                  color: authController
                                                              .selectedTeamMemberIndex ==
                                                          2
                                                      ? Theme.of(context)
                                                          .hintColor
                                                      : Theme.of(context)
                                                          .cardColor
                                                          .withOpacity(0.5)),
                                              textAlign: TextAlign.center,
                                            ),
                                          ))),
                                  SizedBox(
                                    width: 10,
                                  ),


                                ],
                              ),

                            SizedBox(height: 20,),
                            if(authController.selectedTeamMemberIndex == 0)
                              liveMatches(),
                            if(authController.selectedTeamMemberIndex == 1)
                              upComingMatches(),
                            if(authController.selectedTeamMemberIndex == 2)
                              completedMatches(),
                          ]);
                    }),


                    )
    );
  }

  Widget liveMatches(){
    return  GetBuilder<HomeController>(builder: (homeController) {
      return homeController.liveList != null ?
          homeController.liveList.length > 0
          ? Expanded(
          child:
          ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: homeController.liveList.length,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index_option) {
          return DummyTeamCardItem(homeController.liveList[index_option].match,true);
        })):NoDataScreen(text:'No Data Found'):
      SizedBox.shrink();
    });
  }

  Widget upComingMatches(){
    return  GetBuilder<HomeController>(builder: (homeController) {
      return homeController.pendingList != null ?
          homeController.pendingList.length > 0
          ? Expanded(
          child:

      ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: homeController.pendingList.length,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index_option) {
          return DummyTeamCardItem(homeController.pendingList[index_option].match,false);
        })):NoDataScreen(text:'No Data Found'):SizedBox.shrink();
    });
  }

  Widget completedMatches(){
    return  GetBuilder<HomeController>(builder: (homeController) {
      return homeController.completedList != null ?
          homeController.completedList.length > 0
          ? Expanded(
          child:

      ListView.builder(
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: homeController.completedList.length,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index_option) {
          return DummyTeamCardItem(homeController.completedList[index_option].match,false);
        })):NoDataScreen(text:'No Data Found'):SizedBox.shrink();
    });
  }
}
