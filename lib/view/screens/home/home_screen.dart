import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/home_controller.dart';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/home/widget/featured_match_card.dart';
import 'package:sixam_mart/view/screens/home/widget/team_card.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../../helper/route_helper.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time

  double latitude;
  double longitude;

  void _loadData() async {
    await Get.find<HomeController>().getUserData();

    await Get.find<HomeController>().getMatchesList();
   // await Get.find<HomeController>().getFeaturedMatchesList();

    /*  if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<NotificationController>().getNotificationList(1, true);
    }*/
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: GetBuilder<HomeController>(builder: (homeController) {
        return homeController != null && !homeController.isLoading
               /* homeController.matchlist != null &&
                homeController.matchlist.data != null*/
            ? Container(
                color: Theme.of(context).backgroundColor,
                child: /*Scrollbar(
                    child:*/
                    SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child:
                                        SvgPicture.asset(Images.logo_white))),
                            Expanded(
                                flex: 1,
                                child: InkWell(onTap: (){
                                  Get.toNamed(RouteHelper.getNotificationRoute());

                                },
                                child:
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: SvgPicture.asset(
                                      Images.notification,
                                      color: Theme.of(context).primaryColor,
                                    )))
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        if (homeController.featuredMatchesList != null &&
                            homeController.featuredMatchesList.data != null &&
                            homeController
                                    .featuredMatchesList.data.matches !=
                                null &&
                            homeController.featuredMatchesList.data.matches
                                    .length >
                                0)
                          Text(
                            "Featured Matches",
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeExtraSingleLarge,
                                color: Theme.of(context).primaryColor),
                          ),
                        if (homeController.featuredMatchesList != null &&
                            homeController.featuredMatchesList.data != null &&
                            homeController
                                    .featuredMatchesList.data !=
                                null && homeController
                                    .featuredMatchesList.data.matches !=
                                null &&
                            homeController.featuredMatchesList.data.matches
                                    .length >
                                0)
                          Container(
                              height: 190,
                              child:
                              ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: homeController
                                        .featuredMatchesList
                                        .data.matches
                                        .length
                                     ,
                                  padding:EdgeInsets.only(top:Dimensions.PADDING_SIZE_SMALL,bottom:Dimensions.PADDING_SIZE_SMALL,left:Dimensions.PADDING_SIZE_EXTRA_SMALL,right:Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return
                                    FeaturedMatchCardItem(homeController
                                        .featuredMatchesList
                                        .data
                                        .matches[index],index);
                                  })
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        if (homeController.matchlist != null &&
                            homeController.matchlist.data != null)
                          Text(
                            "Upcoming Matches",
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeExtraSingleLarge,
                                color: Theme.of(context).primaryColor),
                          ),
                        if (homeController.matchlist != null &&
                            homeController.matchlist.data != null)
                          ListView.builder(
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemCount:
                                  homeController.matchlist.data.length,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return TeamCardItem(homeController
                                    .matchlist.data[index],true);
                              }),
                      ],
                    ),
                  ),
                )
               /* )*/
        )
            : Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
