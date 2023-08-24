import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/dashboard_controller.dart';
import 'package:sixam_mart/controller/home_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/screens/notification/widget/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/logout_confirmation.dart';
import '../../base/paginated_list_view.dart';
import '../profile/widget/profile_bg_widget.dart';

class ResourceCenterScreen extends StatefulWidget {
  @override
  State<ResourceCenterScreen> createState() => _ResourceCenterScreenState();
}

class _ResourceCenterScreenState extends State<ResourceCenterScreen> with WidgetsBindingObserver {
  void _loadData() async {
    Get.find<HomeController>().getResourceCenterList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadData();
  }
  @override
  void dispose() {
    // Remove the observer in the dispose method
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App paused>>>>${state.toString()} ');
    if (state == AppLifecycleState.paused) {
      // Implement your onPause logic here
      print('App paused');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
        title: 'Resource Center'.tr,
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
      endDrawer: MenuDrawer(),
      body: Get.find<AuthController>().isLoggedIn()
          ?

      GetBuilder<HomeController>(
                builder: (onBoardingController) =>
                !onBoardingController.isLoading?
                onBoardingController.resourceCenterListModel != null ?
                Container(
                    height:  MediaQuery.of(context).size.height,
                    padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                    margin: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                    /*color: Colors.red,*/
                    child: ListView.builder(
                      /*controller: _scrollController,*/
                      itemCount: onBoardingController
                          .resourceCenterListModel.data.length,
                      padding: EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child:
                        InkWell(
                        onTap: () {
                          _launchURL(onBoardingController
                              .resourceCenterListModel
                              .data[index].resource);
                        },
                        child:
                        Column(
                            children: [
                              Align(
                                  alignment:
                                  Alignment.centerLeft,
                                  child: Text(
                                    onBoardingController
                                        .resourceCenterListModel
                                        .data[index]
                                        .title,
                                    style: robotoBold.copyWith(
                                        fontSize: Dimensions
                                            .fontSizeLarge /*context.height*0.015*/,
                                        color: Theme.of(context).hintColor),
                                    textAlign: TextAlign.start,)),

                              SizedBox(
                                  height: Dimensions
                                      .PADDING_SIZE_EXTRA_SMALL),
                              Divider(height: Dimensions.PADDING_SIZE_DEFAULT,color: Theme.of(context).hintColor.withOpacity(0.5),)

                            ],
                          )),
                        );
                      },
                    ))
                    : SizedBox():Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)))
           : NotLoggedInScreen(),
    );
  }
  void _launchURL(String url) async {
    // Replace with your desired URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
