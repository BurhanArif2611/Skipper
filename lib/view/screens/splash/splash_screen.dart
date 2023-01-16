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

    if (Get.find<SplashController>().module == null){
    Get.find<SplashController>().getModules();}
    Get.find<BannerController>().getBranchList(true);

    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<CartController>().getCartData();
    //Get.find<ThemeController>().toggleTheme();
    _route();

  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        Timer(Duration(seconds: 1), () async {
          int _minimumVersion = 0;
          if(GetPlatform.isAndroid) {
            _minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionAndroid;
          }else if(GetPlatform.isIOS) {
            _minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionIos;
          }

         // Get.offNamed(RouteHelper.getStoreRoute(0,  'store'));
          if(GetPlatform.isAndroid) {
            if (AppConstants.ANDROID_APP_VERSION < _minimumVersion || Get
                .find<SplashController>()
                .configModel
                .maintenanceMode) {
              Get.offNamed(RouteHelper.getUpdateRoute(
                  AppConstants.ANDROID_APP_VERSION < _minimumVersion));
            }
            else {
              if (widget.orderID != null) {
                Get.offNamed(RouteHelper.getOrderDetailsRoute(
                    int.parse(widget.orderID)));
              }
              else {
                if (Get.find<AuthController>().isLoggedIn()) {
                  Get.find<AuthController>().updateToken();
                  await Get.find<WishListController>().getWishList();
                  try {
                    await Firebase.initializeApp();
                    FlutterError.onError =
                        FirebaseCrashlytics.instance.recordFlutterFatalError;
                  } catch (e) {}
                  if (Get.find<LocationController>().getUserAddress() != null) {
                    //Get.offNamed(RouteHelper.getInitialRoute());
                    getBranchList();
                  } else {
                    Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
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
                      Get.offNamed(
                          RouteHelper.getSignInRoute(RouteHelper.splash));
                    } else {
                      Get.offNamed(RouteHelper.getOnBoardingRoute());
                    }
                  } else {
                    Get.offNamed(
                        RouteHelper.getSignInRoute(RouteHelper.splash));
                  }
                }
              }
            }
          }else if(GetPlatform.isIOS) {
            if (AppConstants.IOS_APP_VERSION < _minimumVersion || Get
                .find<SplashController>()
                .configModel
                .maintenanceMode) {
              Get.offNamed(RouteHelper.getUpdateRoute(
                  AppConstants.IOS_APP_VERSION < _minimumVersion));
            }
            else {
              if (widget.orderID != null) {
                Get.offNamed(RouteHelper.getOrderDetailsRoute(
                    int.parse(widget.orderID)));
              }
              else {
                if (Get.find<AuthController>().isLoggedIn()) {
                  Get.find<AuthController>().updateToken();
                  await Get.find<WishListController>().getWishList();
                  try {
                    await Firebase.initializeApp();
                    FlutterError.onError =
                        FirebaseCrashlytics.instance.recordFlutterFatalError;
                  } catch (e) {}
                  if (Get.find<LocationController>().getUserAddress() != null) {
                    //Get.offNamed(RouteHelper.getInitialRoute());
                    getBranchList();
                  } else {
                    Get.offNamed(RouteHelper.getAccessLocationRoute('splash'));
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
                      Get.offNamed(
                          RouteHelper.getSignInRoute(RouteHelper.splash));
                    } else {
                      Get.offNamed(RouteHelper.getOnBoardingRoute());
                    }
                  } else {
                    Get.offNamed(
                        RouteHelper.getSignInRoute(RouteHelper.splash));
                  }
                }
              }
            }
          }
        });
      }
    });
  }

  void getBranchList() {
    if (Get.find<BannerController>().branchStoreList!=null && Get.find<BannerController>().branchStoreList.branches.length > 0) {
      Get.offNamed(RouteHelper.getInitialRoute());
    } else {
      AppConstants.ModelID=Get.find<BannerController>().branchStoreList!=null && Get.find<BannerController>().branchStoreList.moduleId!=null?Get.find<BannerController>().branchStoreList.moduleId:0;
      Get.find<StoreController>().getStoreDetails(Store(id: AppConstants.StoreID),true);

      Get.find<StoreController>().getStoreItemList(AppConstants.StoreID, 1, 'all', false);
      /*if(Get.find<CategoryController>().categoryList == null) {*/
      Get.find<CategoryController>().getCategoryList(true);

      if (Get.find<SplashController>().moduleList != null) {
        for (ModuleModel module in Get.find<SplashController>().moduleList) {
          // if(module.id == _storeList[index].moduleId)

          if (module.id == 1) {
            Get.find<SplashController>().setModule(module);
            Get.offNamed(RouteHelper.getInitialRoute());
            break;
          }
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>().initSharedData();

    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
          child: splashController.hasConnection ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Images.logo, width: 300),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              // Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25)),
            ],
          ) : NoInternetScreen(child: SplashScreen(orderID: widget.orderID)),
        );
      }),
    );
  }
}
