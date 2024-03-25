import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/cart_widget.dart';
import 'package:sixam_mart/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';
import 'package:sixam_mart/view/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/banner_controller.dart';
import '../../../controller/dashboard_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/module_model.dart';
import '../../../helper/route_helper.dart';
import '../../../util/app_constants.dart';
import '../../../util/images.dart';
import '../../base/inner_custom_app_bar.dart';

import '../account/account_screen.dart';
import '../my_matches/my_matches_screen.dart';
import '../our_ideas/our_ideas_screen.dart';
import '../wallet/wallet_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
//  static PageController _pageController;
  int _pageIndex = 0;
  String toolbar_name="home".tr;
  List<Widget> _screens;

  // GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;
  bool eccorance = false;

  void _loadData() async {
    Get.find<AuthController>().clearData();
  }

  Future<void> _getDeviceId() async {
    try{
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
     if(androidInfo.id!=null){
      Get.find<AuthController>().changeDeviceID(androidInfo.id);}
     else if(androidInfo.model!=null){
      Get.find<AuthController>().changeDeviceID(androidInfo.model);}


    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      if(iosInfo.identifierForVendor!=null){
        Get.find<AuthController>().changeDeviceID(iosInfo.identifierForVendor);}
      else if(iosInfo.model!=null){
        Get.find<AuthController>().changeDeviceID(iosInfo.model);}
    }}catch(e){}
  }

  @override
  void initState() {
    super.initState();
    _getDeviceId();
    _pageIndex = widget.pageIndex;

    //  _pageController = PageController(initialPage: widget.pageIndex);
    if (Get.find<StoreController>().store != null &&
        Get.find<StoreController>().store.ecommerce == 1) {
      eccorance = true;
    } else {
      eccorance = false;
    }

    _screens = [
      HomeScreen(),
      MyMatchesScreen(),
      WalletScreen(),
      AccountScreen(),

    ];

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        print("initState>>>>>");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Get.find<StoreController>().store != null &&
        Get.find<StoreController>().store.ecommerce == 1) {
      eccorance = true;
      _screens = [
        HomeScreen(),
        MyMatchesScreen(),
        WalletScreen(),
        AccountScreen(),

        // MyProfileScreen(),
      ];
    } else {
      eccorance = false;
      _screens = [
        HomeScreen(),
        MyMatchesScreen(),
        WalletScreen(),
        AccountScreen(),

        // MyProfileScreen(),
      ];
    }

    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          if (!ResponsiveHelper.isDesktop(context) &&
              Get.find<SplashController>().module != null &&
              Get.find<SplashController>().configModel.module == null) {
            if (Get.find<BannerController>().branchStoreList.branches.length >
                0) {
              Get.find<SplashController>().setModule(null);
            } else if (_canExit) {
              return true;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('back_press_again_to_exit'.tr,
                    style: TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              ));
              _canExit = true;
              Timer(Duration(seconds: 2), () {
                _canExit = false;
              });
              return false;
            }
            return false;
          } else {
            if (_canExit) {
              return true;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('back_press_again_to_exit'.tr,
                    style: TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              ));
              _canExit = true;
              Timer(Duration(seconds: 2), () {
                _canExit = false;
              });
              return false;
            }
          }
        }
      },
      child: Scaffold(

        bottomNavigationBar: GetBuilder<DashboardController>(builder: (cartController) {
                if (cartController.currentIndex != null &&
                    cartController.currentIndex != 0 &&
                    _pageIndex != null) {
                  // _pageController.jumpToPage(cartController.currentIndex);
                  //_setPage(cartController.currentIndex);
                }
                return BottomAppBar(
                  elevation: 5,
                  notchMargin: 5,
                  clipBehavior: Clip.antiAlias,
                  shape: CircularNotchedRectangle(),
                  child: Container(
                      height: 70.0,
                      color: Theme.of(context).hintColor,
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(children: [
                          BottomNavItem(
                              isSelected: cartController.currentIndex == 0,
                              onTap: () => _setPage(0),
                              countVisible: false,
                              title: "arena".tr,
                              ImagePath: Images.arena,
                              ImagePathSelected: Images.arena_selected,
                          ),
                          BottomNavItem(
                              isSelected: cartController.currentIndex == 1,
                              onTap: () => {_setPage(1)},
                              countVisible: true,
                              title: "my_matches".tr,
                              ImagePath: Images.my_matchs,
                              ImagePathSelected: Images.my_matchs_selected,
                          ),


                          BottomNavItem(
                            isSelected: cartController.currentIndex == 2,
                              onTap: () => _setPage(2),
                              countVisible: false,
                              title: "wallet".tr,
                              ImagePath: Images.wallet,
                            ImagePathSelected: Images.wallet_selected,
                          ),
                          BottomNavItem(
                              iconData: Icons.menu,
                              isSelected: cartController.currentIndex == 3,
                              onTap: () {
                                _setPage(3);
                                },
                              countVisible: false,
                              title: "account".tr,
                              ImagePath: Images.account,
                            ImagePathSelected: Images.account_selected,
                          ),
                        ]),
                      )),
                );
              }),
        body: GetBuilder<DashboardController>(builder: (cartController) {
          return PageView.builder(
            controller: cartController.pageController,
            itemCount: _screens.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _screens[index];
            },
          );
        }),
      ),
    );
  }

  _setPage(int pageIndex) {
    try {
      _loadData();
      setState(() {
        // _pageController.jumpToPage(pageIndex);
        _pageIndex = pageIndex;
        if(pageIndex==0){
          toolbar_name="home".tr;
        }if(pageIndex==1){
          toolbar_name="who_are_we".tr;
        }if(pageIndex==2){
          toolbar_name="polling_events".tr;
        }if(pageIndex==3){
          toolbar_name="our_ideas".tr;
        }if(pageIndex==4){
          toolbar_name="add_new_member".tr;
        }
      });
      print("if >>>${_pageIndex.toString()}");
      Get.find<DashboardController>().changeIndex(pageIndex);
    } catch (e) {
      print("dddfdfdff${e.toString()}");
    }
  }
}
