import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/wishlist_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/view/base/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/category_controller.dart';
import '../../../controller/localization_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../controller/theme_controller.dart';
import '../../../data/model/response/module_model.dart';
import '../../../data/model/response/store_model.dart';
import '../../../util/styles.dart';

class SplashScreen extends StatefulWidget {
  final String orderID;

  SplashScreen({@required this.orderID});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<CartController>().getCartData();
    // Get.find<ThemeController>().toggleTheme();
    _route();
  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
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

      // Get.offNamed(RouteHelper.getStoreRoute(0,  'store'));
     /* if (GetPlatform.isAndroid) {
        if (AppConstants.ANDROID_APP_VERSION < _minimumVersion ||
            Get.find<SplashController>().configModel.maintenanceMode) {
          Get.offNamed(RouteHelper.getUpdateRoute(
              AppConstants.ANDROID_APP_VERSION < _minimumVersion));
        } else {
          if (widget.orderID != null) {
            Get.offNamed(
                RouteHelper.getOrderDetailsRoute(int.parse(widget.orderID)));
          } else {
            if (Get.find<AuthController>().isLoggedIn()) {
              Get.find<AuthController>().updateToken();
              // await Get.find<WishListController>().getWishList();
              try {
                await Firebase.initializeApp();
                FlutterError.onError =
                    FirebaseCrashlytics.instance.recordFlutterFatalError;
              } catch (e) {}
              if (Get.find<AuthController>().isLoggedIn()) {
                if (Get.find<LocationController>().getUserAddress() != null) {
                  Get.offNamed(RouteHelper.getInitialRoute());
                } else {
                  Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
                }
              }
            } else {
              if (Get.find<SplashController>().showIntro()) {
                *//*if (AppConstants.languages.length > 1) {
                      //  Get.offNamed(RouteHelper.getLanguageRoute('splash'));
                      Get.find<LocalizationController>().setLanguage(Locale(
                        AppConstants.languages[0].languageCode,
                        AppConstants.languages[0].countryCode,
                      ));
                      Get.find<LocalizationController>().setSelectIndex(0);
                       Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                    } else {*//*
                Get.offNamed(RouteHelper.getOnBoardingRoute());
                *//*  }*//*
              } else {
                Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
              }
            }
          }
        }
      }
      else if (GetPlatform.isIOS) {
        if (AppConstants.IOS_APP_VERSION < _minimumVersion ||
            Get.find<SplashController>().configModel.maintenanceMode) {
          Get.offNamed(RouteHelper.getUpdateRoute(
              AppConstants.IOS_APP_VERSION < _minimumVersion));
        } else {
          if (widget.orderID != null) {
            Get.offNamed(
                RouteHelper.getOrderDetailsRoute(int.parse(widget.orderID)));
          } else {
            if (Get.find<AuthController>().isLoggedIn()) {
              Get.find<AuthController>().updateToken();
              //  await Get.find<WishListController>().getWishList();
              try {
                await Firebase.initializeApp();
                FlutterError.onError =
                    FirebaseCrashlytics.instance.recordFlutterFatalError;
              } catch (e) {}
              if (Get.find<AuthController>().isLoggedIn()) {
                if (Get.find<LocationController>().getUserAddress() != null) {
                  Get.offNamed(RouteHelper.getInitialRoute());
                } else {
                  Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
                }
              }
            } else {
              if (Get.find<SplashController>().showIntro()) {
                if (AppConstants.languages.length > 1) {
                  //  Get.offNamed(RouteHelper.getLanguageRoute('splash'));
                  Get.find<LocalizationController>().setLanguage(Locale(
                    AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode,
                  ));
                  Get.find<LocalizationController>().setSelectIndex(0);
                  Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                } else {
                  Get.offNamed(RouteHelper.getOnBoardingRoute());
                }
              } else {
                Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
              }
            }
          }
        }
      }*/
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
            color: Theme.of(context).primaryColor,
            child: Center(
              child: splashController.hasConnection
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppConstants.APP_NAME,
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeOverLarge,
                                color: Theme.of(context).cardColor)),
                        /* Image.asset(Images.logo, width: 300),*/
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        // Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25)),
                      ],
                    )
                  : NoInternetScreen(
                      child: SplashScreen(orderID: widget.orderID)),
            ));
      }),
    );
  }
}
