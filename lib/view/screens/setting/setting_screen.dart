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

class SettingScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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


        body: Text("Setting")

    );
  }

  List<Widget> _pageIndicators(
      HomeController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0;
    i <
        (onBoardingController.incidenceListModel.docs.length > 5
            ? 5
            : onBoardingController.incidenceListModel.docs.length);
    i++) {
      _indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
            borderRadius: i == onBoardingController.selectedIndex
                ? BorderRadius.circular(50)
                : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
          print("seconds>>>${seconds}");
          Get.find<HomeController>().updateTimerCount(seconds);
        } else {
          _timer.cancel();
          Get.back();

          Get.find<HomeController>()
              .sendSOSAlert(latitude, longitude)
              .then((value) async {
            if (value.statusCode == 200) {
              showCustomSnackBar(
                  value.body["message"] != null
                      ? value.body["message"].toString()
                      : "",
                  isError: false);
            }
          });
          // Stop the timer when it reaches 0
        }
      });
    });
  }

  void showingTimerPopup() {
    showAnimatedDialog(
        context,
        GetBuilder<HomeController>(
            builder: (homecontroller) => Center(
              child: Container(
                width: 300,
                padding:
                EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(
                        Dimensions.RADIUS_EXTRA_LARGE)),
                child: GetBuilder<HomeController>(builder: (controller) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Text(
                      "${homecontroller.timerCount}",
                      style: robotoBold.copyWith(
                        fontSize: 50,
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomButton(
                      buttonText: 'Cancel'.tr,
                      onPressed: () {
                        Get.back();
                        Get.find<HomeController>()
                            .sendSOSAlert(latitude, longitude)
                            .then((value) async {
                          if (value.statusCode == 200) {
                            showCustomSnackBar(
                                value.body["message"] != null
                                    ? value.body["message"].toString()
                                    : "",
                                isError: false);
                          }
                        });
                      },
                    )
                    /*  Container(
                         height: 50,
                         child:  InkWell(
                             onTap: () {
                               Get.back();
                               Get.find<HomeController>()
                                   .sendSOSAlert(latitude, longitude)
                                   .then((value) async {
                                 if (value.statusCode == 200) {
                                   showCustomSnackBar(
                                       value.body["message"] != null
                                           ? value.body["message"].toString()
                                           : "",
                                       isError: false);
                                 }
                               });
                             },

                             child: Column(
                               children: [
                                 SvgPicture.asset(
                                   Images.circle_cancel,
                                   height: 50,
                                   width: 50,
                                 )
                               ],
                             )),
                       )*/
                    ,
                  ]);
                }),
              ),
            )),
        dismissible: false);
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
