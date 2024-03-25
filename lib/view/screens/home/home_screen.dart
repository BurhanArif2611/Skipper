import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/home_controller.dart';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/home/widget/team_card.dart';

import 'package:timeago/timeago.dart' as timeago;

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

  @override
  void initState() {
    super.initState();
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
        body: Container(
        color: Theme.of(context).backgroundColor,
        child:
        Scrollbar(
            child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(Images.logo_white))),
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SvgPicture.asset(
                          Images.notification,
                          color: Theme.of(context).primaryColor,
                        ))),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Featured Matches",
              style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeExtraSingleLarge,
                  color: Theme.of(context).primaryColor),
            ),

            TeamCardItem(),
            SizedBox(
              height: 20,
            ),
            Text(
              "Upcoming Matches",
              style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeExtraSingleLarge,
                  color: Theme.of(context).primaryColor),
            ),
            ListView.builder(
              shrinkWrap: true,
                controller: _scrollController,
                itemCount: 10,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index_option) {
                  return TeamCardItem();
                }),
          ],
        ),
      ),
    )))
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
