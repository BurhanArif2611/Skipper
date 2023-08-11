import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/cart_widget.dart';
import 'package:sixam_mart/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';
import 'package:sixam_mart/view/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/dashboard_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/module_model.dart';
import '../../../util/app_constants.dart';
import '../../../util/images.dart';
import '../incidences/incidences_screen.dart';
import '../latestnews/latestnews_screen.dart';
import '../more/more_main_screen.dart';
import '../myprofile/myprofile_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();


}



class _DashboardScreenState extends State<DashboardScreen> {
//  static PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;
  bool eccorance = false;

  @override
  void initState() {
    super.initState();

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
      IncidencesScreen(),
      LatestNewsScreen(),
      MoreMainScreen(),
      Container(),
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
        IncidencesScreen(),
        LatestNewsScreen(),
        MoreMainScreen(),
       // MyProfileScreen(),
      ];
    } else {
      eccorance = false;
      _screens = [
        HomeScreen(),
        IncidencesScreen(),
        LatestNewsScreen(),
        MoreMainScreen(),
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
        key: _scaffoldKey,
        bottomNavigationBar: ResponsiveHelper.isDesktop(context)
            ? SizedBox()
            : GetBuilder<DashboardController>(builder: (cartController) {
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
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(children: [
                          BottomNavItem(
                              iconData: Icons.home,
                              isSelected: cartController.currentIndex == 0,
                              onTap: () => _setPage(0),
                              countVisible: false,
                              title: "Home",
                              ImagePath: Images.home),
                          BottomNavItem(
                              iconData: eccorance
                                  ? Icons.shopping_cart
                                  : Icons.notifications,
                              isSelected: cartController.currentIndex == 1,
                              onTap: () => {_setPage(1)},
                              countVisible: true,
                              title: "Incidences",
                              ImagePath: Images.incidences),
                          BottomNavItem(
                              iconData: Icons.shopping_bag,
                              isSelected: cartController.currentIndex == 2,
                              onTap: () => _setPage(2),
                              countVisible: false,
                              title: "Latest News",
                              ImagePath: Images.latests_news),
                          BottomNavItem(
                              iconData: Icons.menu,
                              isSelected: cartController.currentIndex == 3,
                              onTap: () {
                                _setPage(3);
                                /*Get.bottomSheet(MenuScreen(),
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true);*/
                              },
                              countVisible: false,
                              title: "More",
                              ImagePath: Images.more),
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
      setState(() {
       // _pageController.jumpToPage(pageIndex);
        _pageIndex = pageIndex;
      });
      print("if >>>${_pageIndex.toString()}");
      Get.find<DashboardController>().changeIndex(pageIndex);
    } catch (e) {
      print("dddfdfdff${e.toString()}");
    }
  }
}
