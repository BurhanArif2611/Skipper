import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import '../../base/no_internet_screen.dart';

class SplashScreen extends StatefulWidget {
  final String orderID;

  SplashScreen({@required this.orderID});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  Position _currentPosition;

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        _deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {}
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- ' + _deviceToken);

      /// Get.find<SplashController>().saveToken(_deviceToken);
    }
    return _deviceToken;
  }

  @override
  void initState() {
    super.initState();
    _saveDeviceToken();
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
          //  _route();
        }
      }
      _firstTime = false;
    });

    //  Get.find<CartController>().getCartData();
    // Get.find<ThemeController>().toggleTheme();
    if (Platform.isAndroid) {
      _checkPermissions();
    } else {
      _route();
    }
    /*_*/
  }

  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  Future<void> _checkPermissions() async {

     final status = await Permission.location.request();
     if (status == PermissionStatus.granted) {
      _route();
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
          //  Get.offNamed(RouteHelper.getAccessLocationRoute('sign-in'));
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
            color: Theme.of(context).hintColor,
            child: Center(
              child: splashController.hasConnection
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(Images.logo, width: 300),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      ],
                    )
                  : NoInternetScreen(
                      child: SplashScreen(orderID: widget.orderID)),
            ));
      }),
    );
  }
}
