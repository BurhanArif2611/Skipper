import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';

import 'package:sixam_mart/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../util/app_constants.dart';
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
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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

  Future<void> _initializeNotificationPlugin() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _loadData() async {
    Get.find<SplashController>().getVersionInfo().then((value) async {
      if (value != null) {
        String _minimumVersion;
        if (GetPlatform.isAndroid) {
          _minimumVersion = value.data.versionAndriod;
        } else if (GetPlatform.isIOS) {
          _minimumVersion = value.data.versionIOS;
        }
        if (GetPlatform.isAndroid &&
            AppConstants.ANDROID_APP_VERSION != _minimumVersion) {
          Get.offNamed(RouteHelper.getUpdateRoute(true));
        } else if (GetPlatform.isIOS &&
            AppConstants.IOS_APP_VERSION != _minimumVersion) {
          Get.offNamed(RouteHelper.getUpdateRoute(true));
        } else {
          if (value != null) {
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
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _initializeNotificationPlugin();
    } else {
      requestNotificationPermission();
    }
    _loadData();
    _saveDeviceToken();

    /*_*/
  }

  Future<void> requestNotificationPermission() async {
    final bool result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    if (result == true) {
      print("Notification permissions granted.");
    } else {
      print("Notification permissions denied.");
    }
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
    Timer(Duration(seconds: 4), () async {
      print("_route>>>>>");
      if (Get.find<AuthController>().isLoggedIn()) {
        // Get.offNamed(RouteHelper.getInitialRoute());
       // Get.offNamed(RouteHelper.getAccessLocationRoute('sign-in'));
        Get.offNamed(RouteHelper
            .getInitialRoute());

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
                  ? /*Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(Images.logo, width: 300),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      ],
                    )*/
                  Image.asset(
                      Images.splash,
                      fit: BoxFit.cover,
                    )
                  : NoInternetScreen(
                      child: SplashScreen(orderID: widget.orderID)),
            ));
      }),
    );
  }
}
