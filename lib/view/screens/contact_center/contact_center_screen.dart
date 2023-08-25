import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/dashboard_controller.dart';
import 'package:sixam_mart/controller/home_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/app_constants.dart';
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

class ContactCenterScreen extends StatefulWidget {
  @override
  State<ContactCenterScreen> createState() => _ContactCenterScreenState();
}

class _ContactCenterScreenState extends State<ContactCenterScreen>
    with WidgetsBindingObserver {
  void _loadData() async {
    Get.find<HomeController>().getContactCenterList();
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
        title: 'Contact Center'.tr,
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
     /* endDrawer: MenuDrawer(),*/
      body: Get.find<AuthController>().isLoggedIn()
          ? GetBuilder<HomeController>(
              builder: (onBoardingController) => !onBoardingController.isLoading
                  ? onBoardingController.contactCenterListModel != null
                      ? Container(
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          margin: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                          /*color: Colors.red,*/
                          child: ListView.builder(
                            /*controller: _scrollController,*/
                            itemCount: onBoardingController
                                .contactCenterListModel.docs.length,
                            padding: EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context).disabledColor),
                                  color: Colors.white,
                                ),
                                child: Column(children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Name",
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor),
                                      )), 
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        onBoardingController.contactCenterListModel.docs[index].name,
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor.withOpacity(0.3)),
                                      )),
                                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Email",
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor),
                                      )),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        onBoardingController.contactCenterListModel.docs[index].email,
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor.withOpacity(0.3)),
                                      )),
                                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Designation",
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor),
                                      )),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        onBoardingController.contactCenterListModel.docs[index].designation,
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor.withOpacity(0.3)),
                                      )),
                                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Phone Number",
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor),
                                      )),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        onBoardingController.contactCenterListModel.docs[index].mobileNumber.toString(),
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).hintColor.withOpacity(0.3)),
                                      )),
                                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                                  Row(children: [
                                    Expanded(flex:1,child:
                                    InkWell(
                                      onTap: () {
                                        _launchPhoneCall(onBoardingController.contactCenterListModel.docs[index].mobileNumber.toString());
                                      },
                                      child:
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context).disabledColor),
                                          color: Colors.white,

                                        ),
                                        alignment: Alignment.center,
                                        child:
                                        Text("Call",style: robotoBold.copyWith(color: Theme.of(context).primaryColor),))),
                                    ),

                                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                    Expanded(flex:1,child:
                                    InkWell(
                                      onTap: () {
                                        _launchEmail(onBoardingController.contactCenterListModel.docs[index].email,AppConstants.APP_NAME,AppConstants.APP_NAME+" contact center");
                                      },
                                      child:
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.0),
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context).disabledColor),
                                          color: Colors.white,
                                        ),
                                        alignment: Alignment.center,
                                        child:Text("Email",style: robotoBold.copyWith(color: Theme.of(context).primaryColor),))),),
                                  ],)
                                ]),
                              );
                            },
                          ))
                      : SizedBox()
                  : Center(
                      child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    )))
          : NotLoggedInScreen(),
    );
  }
  _launchPhoneCall(String phoneNumber) async {
    try{
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }}catch(e){}
  }
  _launchEmail(String email, String subject, String body) async {
    String url = 'mailto:$email?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
