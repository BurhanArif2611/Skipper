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
import '../addmembers/add_newmember.dart';

import '../member/member_search_screen.dart';
import '../more/more_main_screen.dart';
import '../our_ideas/our_ideas_screen.dart';
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
  String toolbar_name="home".tr;
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
      MemberSearchScreen(),
      PollingSurveyScreen(),
      OurIdeasScreen(),
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
        OurIdeasScreen(),
        AddNewMembers(),
        // MyProfileScreen(),
      ];
    } else {
      eccorance = false;
      _screens = [
        HomeScreen(),
        MemberSearchScreen(),
        PollingSurveyScreen(),
        OurIdeasScreen(),
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
                padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "general".tr,
                  style: robotoBold.copyWith(
                      color: Theme.of(context).hintColor.withOpacity(0.5),
                      fontSize: Dimensions.fontSizeLarge),
                ),
              ),
             /* SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.notification),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'notification'.tr,
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
                  )),*/


              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title:
                Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.languge),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'languages'.tr,
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
                  Get.offNamed(RouteHelper.getLanguageRoute('menu'));
                },
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Divider(
                    thickness: 1,
                  )),
             /* SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.help_support),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'help_and_support'.tr,
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
                  )),*/



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
                        'share_app'.tr,
                        style: robotoBold.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: Dimensions.fontSizeLarge),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Share.share('check out our ${AppConstants.APP_NAME} App ${'https://play.google.com/store/apps/details?id=com.patriotes.androidapp'}', subject: 'Look what I made!');

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
                        'our_fundamental_documents'.tr,
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
                            'organization_and_operation'.tr,
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
            
             /* SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ListTile(
                title: Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(Images.rate_us),
                      SizedBox(
                        width: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Text(
                        'rate_app'.tr,
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
                  )),*/
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
                              title: "home".tr,
                              ImagePath: Images.home),
                          BottomNavItem(
                              iconData: eccorance
                                  ? Icons.shopping_cart
                                  : Icons.notifications,
                              isSelected: cartController.currentIndex == 1,
                              onTap: () => {_setPage(1)},
                              countVisible: true,
                              title: "members".tr,
                              ImagePath: Images.incidences),
                          Expanded(child:Container(alignment: Alignment.center,padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                              child: Align(alignment:Alignment.center,child:Text("join_us".tr,textAlign: TextAlign.center, style: robotoRegular.copyWith(color: _pageIndex==4 ? Theme.of(context).primaryColor : Colors.black,fontSize: Dimensions.fontSizeSmall ),)))),
                          BottomNavItem(
                              iconData: Icons.shopping_bag,
                              isSelected: cartController.currentIndex == 2,
                              onTap: () => _setPage(2),
                              countVisible: false,
                              title: "poll_events".tr,
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
                              title: "profile".tr,
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
