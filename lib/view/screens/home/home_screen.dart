import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/banner_controller.dart';
import 'package:sixam_mart/controller/campaign_controller.dart';
import 'package:sixam_mart/controller/category_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/parcel_controller.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/paginated_list_view.dart';
import 'package:sixam_mart/view/base/web_menu_bar.dart';
import 'package:sixam_mart/view/screens/home/theme1/new_home_screen.dart';
import 'package:sixam_mart/view/screens/home/theme1/theme1_home_screen.dart';
import 'package:sixam_mart/view/screens/home/web_home_screen.dart';
import 'package:sixam_mart/view/screens/home/widget/filter_view.dart';
import 'package:sixam_mart/view/screens/home/widget/popular_item_view.dart';
import 'package:sixam_mart/view/screens/home/widget/item_campaign_view.dart';
import 'package:sixam_mart/view/screens/home/widget/popular_store_view.dart';
import 'package:sixam_mart/view/screens/home/widget/banner_view.dart';
import 'package:sixam_mart/view/screens/home/widget/category_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/home/widget/module_view.dart';
import 'package:sixam_mart/view/screens/home/widget/store_branch.dart';
import 'package:sixam_mart/view/screens/parcel/parcel_category_screen.dart';

import '../../../controller/dashboard_controller.dart';
import '../../base/custom_app_bar.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/not_logged_in_screen.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      bool _showMobileModule = !ResponsiveHelper.isDesktop(context) &&
          splashController.module == null &&
          splashController.configModel.module == null;
      bool _isParcel = splashController.module != null &&
          splashController.configModel.moduleConfig.module.isParcel;

      return Scaffold(
        appBar: InnerCustomAppBar(
            title: 'Home'.tr,
            leadingIcon: Images.circle_arrow_back,
            backButton: ResponsiveHelper.isDesktop(context),
            onBackPressed: () {
              Get.find<DashboardController>().changeIndex(0);
            }),
        endDrawer: MenuDrawer(),
        backgroundColor: ResponsiveHelper.isDesktop(context)
            ? Theme.of(context).cardColor
            : splashController.module == null
                ? Theme.of(context).backgroundColor
                : null,
        body: Get.find<AuthController>().isLoggedIn()
            ? Center(
                child: Text("Home Screen"),
              )
            : NotLoggedInScreen(),
        floatingActionButton: Container(
            width: 75, // Set the desired width here
            height: 75, // Set the desired height here
            child: FloatingActionButton(
              onPressed: () {
                // Add the action you want to perform when the FAB is pressed
                // For example, navigate to another page or show a dialog.
                print('Floating Action Button Pressed');
                Get.toNamed(RouteHelper.getSOSCOntactRoute());

              },
              child: Text(
                "SOS",
                style: robotoMedium.copyWith(color: Colors.white),
              ) /*Icon(Icons.add)*/,
              backgroundColor: Color(0xFFFF5454),
              // Set the FAB's background color
            )),
      );
    });
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
