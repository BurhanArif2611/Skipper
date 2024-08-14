import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';

import 'package:sixam_mart/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../util/app_constants.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import '../../base/custom_button.dart';
import '../../base/no_internet_screen.dart';

class LocationScreen extends StatefulWidget {
  final String orderID;

  LocationScreen({@required this.orderID});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  Position _currentPosition;

  @override
  void initState() {
    super.initState();

    /*  _checkPermissions();*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    final status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      _route();
      _getCurrentLocation();
    } else if (status == PermissionStatus.denied) {
      // Handle denied status
      Get.offNamed(RouteHelper.getAccessLocationRoute('sign-in'));
      print("Location permission denied");
    } else if (status == PermissionStatus.permanentlyDenied) {
      // Handle permanently denied status
      openAppSettings();
    }
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  void _route() {
    Timer(Duration(seconds: 1), () async {
      print("_route>>>>>");
      if (Get.find<AuthController>().isLoggedIn()) {
        Get.offNamed(RouteHelper.getInitialRoute());
      } else {
        if (Get.find<SplashController>().showIntro()) {
          Get.offNamed(RouteHelper.getOnBoardingRoute());
        } else {
          Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>().initSharedData();

    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            child: Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        flex: 1,
                        child: Image.asset(
                          Images.logo,
                          width: 100,
                        )),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                        flex: 2,
                        child: Center(
                            child: Image.asset(Images.location_map_icon_png))),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Enable Your Location",
                              style: robotoBlack.copyWith(
                                  color: Theme.of(context).cardColor,
                                  fontSize: Dimensions.fontSizeOverLarge),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            Text(
                              "Allow maps to access your location while you use the app?",
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).cardColor,
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            InkWell(
                                onTap: () {
                                  Get.offNamed(RouteHelper.getInitialRoute());
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFF8CA0A),
                                          Color(0xFFFFE166),
                                          Color(0xFFDCB822),
                                          Color(0xFFFFE166),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              Dimensions.RADIUS_SMALL)),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(Images.Location_small_Icon),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Allow Device Location",
                                          style: robotoBlack.copyWith(
                                              color:
                                                  Theme.of(context).hintColor,
                                              fontSize:
                                                  Dimensions.fontSizeLarge),
                                        ),
                                      ],
                                    )))
                          ],
                        )),
                  ],
                )));
      }),
    );
  }
}
