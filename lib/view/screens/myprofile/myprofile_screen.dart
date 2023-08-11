import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/dashboard_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/screens/notification/widget/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/logout_confirmation.dart';
import '../../base/paginated_list_view.dart';
import '../profile/widget/profile_bg_widget.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  void _loadData() async {
    Get.find<UserController>().getUserInfo();

  }

  @override
  void initState() {
    super.initState();

      _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
          title: 'My profile'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
          ),
      endDrawer: MenuDrawer(),
      body: Get.find<AuthController>().isLoggedIn()
          ? GetBuilder<UserController>(builder: (userController) {
           return !userController.isLoading && userController.userDetailModel!=null?
           Scrollbar(
              child: SingleChildScrollView(
                  controller: scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                    margin: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                    child: Center(
                      child: Column(children: [
                        ClipOval(
                            child: CustomImage(
                          image: Images.user,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )),
                        SizedBox(
                          height: Dimensions.RADIUS_LARGE,
                        ),
                        Text(
                          userController.userDetailModel.name.first+" "+userController.userDetailModel.name.last,
                          style: robotoBold.copyWith(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                        SizedBox(
                          height: Dimensions.RADIUS_SMALL,
                        ),
                        Text(userController.userDetailModel.email),
                        SizedBox(
                          height: Dimensions.RADIUS_LARGE,
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Account",
                              textAlign: TextAlign.left,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge),
                            )),
                        SizedBox(
                          height: Dimensions.RADIUS_DEFAULT,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                  RouteHelper.getPersonalProfileRoute());
                            },
                            child:
                          Row(children: [
                            SizedBox(width: 10),
                            SvgPicture.asset(Images.change_personal_profile),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text('Change Personal Profile'.tr,
                                  textAlign: TextAlign.left,
                                  style: robotoBold.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeLarge,
                                  )),
                            ),
                            Image.asset(Images.arrow_right_normal, height: 20),
                          ])),
                        ),
                        SizedBox(
                          height: Dimensions.RADIUS_EXTRA_LARGE,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                  RouteHelper.getPersonalProfileRoute());
                            },
                            child: Row(children: [
                              SizedBox(width: 10),
                              SvgPicture.asset(Images.complaint),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text('Complaint'.tr,
                                    textAlign: TextAlign.start,
                                    style: robotoBold.copyWith(
                                      color: Theme.of(context).hintColor,
                                      fontSize: Dimensions.fontSizeLarge,
                                    )),
                              ),
                              Image.asset(Images.arrow_right_normal,
                                  height: 20),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.RADIUS_EXTRA_LARGE,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                          child:InkWell(
                            onTap: () {
                              Get.toNamed(
                                  RouteHelper.getChangeEmailRoute());
                            },
                            child:
                          Row(children: [
                            SizedBox(width: 10),
                            SvgPicture.asset(Images.change_email),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text('Change Email Address'.tr,
                                  textAlign: TextAlign.left,
                                  style: robotoBold.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeLarge,
                                  )),
                            ),
                            Image.asset(Images.arrow_right_normal, height: 20),
                          ])),
                        ),
                        SizedBox(
                          height: Dimensions.RADIUS_EXTRA_LARGE,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                          child:InkWell(
                            onTap: () {
                              Get.toNamed(
                                  RouteHelper.getChangePasswordRoute());
                            },
                            child:
                          Row(children: [
                            SizedBox(width: 10),
                            SvgPicture.asset(Images.change_password),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text('Change Password'.tr,
                                  textAlign: TextAlign.left,
                                  style: robotoBold.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeLarge,
                                  )),
                            ),
                            Image.asset(Images.arrow_right_normal, height: 20),
                          ])),
                        ),
                        SizedBox(
                          height: Dimensions.RADIUS_EXTRA_LARGE,
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                          child: InkWell(
                              onTap: () {
                                Get.dialog(
                                    LogoutConfirmationDialog(
                                        icon: Images.support,
                                        title: 'logout'.tr,
                                        description:
                                            'Are you sure? you want to logout.'
                                                .tr,
                                        isLogOut: false,
                                        onYesPressed: () {
                                          print("sdjsndjsnd");
                                          userController.removeUser();
                                          Get.find<AuthController>().clearSharedData();
                                          Get.find<UserController>().initData();
                                          Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));

                                        }
                                        ),
                                    useSafeArea: false);
                              },
                              child: Row(children: [
                                SizedBox(width: 10),
                                SvgPicture.asset(Images.logout),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text('Logout'.tr,
                                      textAlign: TextAlign.left,
                                      style: robotoBold.copyWith(
                                        color: Theme.of(context).hintColor,
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                ),
                                Image.asset(Images.arrow_right_normal,
                                    height: 20),
                              ])),
                        ),
                        SizedBox(
                          height: Dimensions.RADIUS_DEFAULT,
                        ),
                      ]),
                    ),
                  ))): Center(child: CircularProgressIndicator());
   })

          : NotLoggedInScreen(),
    );
  }
}
