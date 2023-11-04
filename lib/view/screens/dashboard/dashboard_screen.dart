import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_svg/svg.dart';
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
import '../addmembers/add_newmember.dart';

import '../member/member_search_screen.dart';
import '../more/more_main_screen.dart';
import '../polling/polling_survey_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;

  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
//  static PageController _pageController;
  int _pageIndex = 0;
  String toolbar_name="Home";
  List<Widget> _screens;

  // GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;
  bool eccorance = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    print("_openDrawer click");
    scaffoldKey.currentState.openDrawer();
  }
  void _loadData() async {
    Get.find<AuthController>().clearData();
  }

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
      MemberSearchScreen(),
      PollingSurveyScreen(),
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
        MemberSearchScreen(),
        PollingSurveyScreen(),
        MoreMainScreen(),
        AddNewMembers(),
        // MyProfileScreen(),
      ];
    } else {
      eccorance = false;
      _screens = [
        HomeScreen(),
        MemberSearchScreen(),
        PollingSurveyScreen(),
        MoreMainScreen(),
        AddNewMembers(),
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
        drawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        appBar: InnerCustomAppBar(
            title: toolbar_name,
            leadingIcon: Images.menu_drawer_png,
            backButton: !ResponsiveHelper.isDesktop(context),
            onBackPressed: () {
              _openDrawer();
            }),
        drawer: Drawer(
            child: Container(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(),
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.logo,
                          width: 100,
                          height: 100,
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "General",
                  style: robotoBold.copyWith(
                      color: Theme.of(context).hintColor.withOpacity(0.5),
                      fontSize: Dimensions.fontSizeLarge),
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.notification),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'Notification',
                        style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Divider(
                    thickness: 1,
                  )),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.languge),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'Languages',
                        style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Divider(
                    thickness: 1,
                  )),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.help_support),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'Help and Support',
                        style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Divider(
                    thickness: 1,
                  )),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.share_app),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'Share App',
                        style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Divider(
                    thickness: 1,
                  )),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),


            ListTile(
                title:  InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.getWebViewScreen("https://partilespatriotes.org/nos-documents-fondamentaux/"));
                  },
                  child:
                Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.share_app),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'Our fundamental documents',
                        style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )
                    ],
                  ),
                )),

              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Divider(
                    thickness: 1,
                  )),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                    title:   InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.getWebViewScreen("https://partilespatriotes.org/notre-organisation-et-fonctionnement/"));
                      },
                      child:
                    Container(
                      child: Row(
                        children: [
                          SvgPicture.asset(Images.share_app),
                          SizedBox(
                            width: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          Text(
                            'Organization and operation',
                            style: robotoBold.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: Dimensions.fontSizeLarge),
                          )
                        ],
                      ),
                    )),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
              Padding(
                  padding:
                  EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Divider(
                    thickness: 1,
                  )),
            
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.rate_us),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'Rate App',
                        style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Divider(
                    thickness: 1,
                  )),
            ],
          ),
        ) // Populate the Drawer in the next step.
            ),
        floatingActionButton: ResponsiveHelper.isDesktop(context)
            ? null
            : FloatingActionButton(
                elevation: 5,
                backgroundColor: Theme.of(context)
                    .primaryColor /*_pageIndex == 2
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor*/
                ,
                onPressed: () => _setPage(4),
                child: CartWidget(
                    color: Theme.of(context)
                        .cardColor /*_pageIndex == 2
                  ? Theme.of(context).cardColor
                  : Theme.of(context).disabledColor*/
                    ,
                    size: 30),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                              title: "Members",
                              ImagePath: Images.incidences),
                          Expanded(child: SizedBox()),
                          BottomNavItem(
                              iconData: Icons.shopping_bag,
                              isSelected: cartController.currentIndex == 2,
                              onTap: () => _setPage(2),
                              countVisible: false,
                              title: "Poll Events",
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
                              title: "Profile",
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
      _loadData();
      setState(() {
        // _pageController.jumpToPage(pageIndex);
        _pageIndex = pageIndex;
        if(pageIndex==0){
          toolbar_name="Home";
        }if(pageIndex==1){
          toolbar_name="Who are we";
        }if(pageIndex==2){
          toolbar_name="Polling Events";
        }if(pageIndex==3){
          toolbar_name="Notification";
        }if(pageIndex==4){
          toolbar_name="Add New Member";
        }
      });
      print("if >>>${_pageIndex.toString()}");
      Get.find<DashboardController>().changeIndex(pageIndex);
    } catch (e) {
      print("dddfdfdff${e.toString()}");
    }
  }
}
