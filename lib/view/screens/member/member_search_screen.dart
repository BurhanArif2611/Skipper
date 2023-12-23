import 'dart:async';


import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:timeago/timeago.dart' as timeago;

class MemberSearchScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<MemberSearchScreen> createState() => _MemberSearchScreenState();
}

class _MemberSearchScreenState extends State<MemberSearchScreen> {
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
        body: Scrollbar(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                    children: [

                      Text("members_of_the_national".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeExtraLarge),),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).disabledColor),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions
                                  .PADDING_SIZE_SMALL), // Set the radius here
                              child: Image.asset(
                                Images.president,
                                // Replace with your image URL or asset path
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width of the image
                                height: 400, // Set the height of the image
                                fit: BoxFit
                                    .cover, // Set the image fit (you can choose BoxFit.fill, BoxFit.fitWidth, etc.)
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "NASOUR_IBRAHIM".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "national_president".tr,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5),
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).disabledColor),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions
                                  .PADDING_SIZE_SMALL), // Set the radius here
                              child: Image.asset(Images.vice_president,
                                // Replace with your image URL or asset path
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width of the image
                                height: 400, // Set the height of the image
                                fit: BoxFit
                                    .cover, // Set the image fit (you can choose BoxFit.fill, BoxFit.fitWidth, etc.)
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "DÉSIRE_MICHAEL".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "vice_president".tr,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5),
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).disabledColor),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions
                                  .PADDING_SIZE_SMALL), // Set the radius here
                              child: Image.asset(
                                Images.mahamat_third,
                                // Replace with your image URL or asset path
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width of the image
                                height: 400, // Set the height of the image
                                fit: BoxFit
                                    .cover, // Set the image fit (you can choose BoxFit.fill, BoxFit.fitWidth, etc.)
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "MAHAMAT_SALEH".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "General_Secretary_of_the_Party".tr,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5),
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).disabledColor),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions
                                  .PADDING_SIZE_SMALL), // Set the radius here
                              child: Image.asset(
                                Images.fourth,
                                // Replace with your image URL or asset path
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width of the image
                                height: 400, // Set the height of the image
                                fit: BoxFit
                                    .cover, // Set the image fit (you can choose BoxFit.fill, BoxFit.fitWidth, etc.)
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "AHMAT_HAROUN".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "Spokesperson".tr,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.5),
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ],
                  ),
                ))));
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
