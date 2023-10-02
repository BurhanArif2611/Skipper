import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sixam_mart/controller/home_controller.dart';

import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/dashboard_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../data/model/response/survey_list_model.dart';
import '../../../helper/date_converter.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_dialog.dart';
import '../../base/custom_image.dart';
import '../../base/custom_snackbar.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/no_data_screen.dart';
import '../../base/not_logged_in_screen.dart';
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

  void _loadData() async {
    await Get.find<HomeController>().getIncidenceList();
    await Get.find<HomeController>().getNewsList();
    await Get.find<HomeController>().getCategoryList();
    await Get.find<HomeController>().getSurveyList();
    await Get.find<HomeController>().clearAllData();
  }

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
                              child: Image.network(
                                'https://partilespatriotes.org/wp-content/uploads/2015/12/2-7.jpg',
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
                              "Dr. NASOUR IBRAHIM KOURSAMI".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "Président National".tr,
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
                              child: Image.network(
                                'https://partilespatriotes.org/wp-content/uploads/2015/12/2-5.jpg',
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
                              "DR. DÉSIRE MICHAEL ALLADOUM".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "Vice-president".tr,
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
                              child: Image.network(
                                'https://partilespatriotes.org/wp-content/uploads/2015/12/2-1-1.jpg',
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
                              "MR. MAHAMAT SALEH SEID".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "Secrétaire général du Parti".tr,
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
                              child: Image.network(
                                'https://partilespatriotes.org/wp-content/uploads/2015/12/2-1.jpg',
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
                              "MR. AHMAT HAROUN".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "Port-parole".tr,
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
