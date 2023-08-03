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

class PersonalProfileScreen extends StatefulWidget {
  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  void _loadData() async {
    Get.find<NotificationController>().clearNotification();
    if (Get.find<SplashController>().configModel == null) {
      await Get.find<SplashController>().getConfigData();
    }
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<NotificationController>().getNotificationList(1, true);
    }
  }

  @override
  void initState() {
    super.initState();

   // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
          title: 'Personal Profile'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
          ),
      endDrawer: MenuDrawer(),
      body: !Get.find<AuthController>().isLoggedIn()
          ? SizedBox(
          height: MediaQuery.of(context).size.height, // Set the desired height here
          child:
           Scrollbar(
             child: SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(

                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                margin: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                child: Center(
                  child: Column(children: [


                    SizedBox(
                      height: Dimensions.RADIUS_LARGE,
                    ),

                    CustomTextField(
                      hintText: 'Enter First Name'.tr,
                     /* controller: _firstNameController,
                      focusNode: _firstNameFocus,
                      nextFocus: _lastNameFocus,*/
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                      prefixIcon: Images.user,
                      divider: false,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      hintText: 'Enter Last Name'.tr,
                     /* controller: _lastNameController,
                      focusNode: _lastNameFocus,
                      nextFocus: _emailFocus,*/
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                      prefixIcon: Images.user,
                      divider: false,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      hintText: '+234 12345 78945'.tr,
                     /* controller: _lastNameController,
                      focusNode: _lastNameFocus,
                      nextFocus: _emailFocus,*/
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                      prefixIcon: Images.call,
                      divider: false,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    CustomTextField(
                      hintText: 'Anonymous Name'.tr,
                     /* controller: _lastNameController,
                      focusNode: _lastNameFocus,
                      nextFocus: _emailFocus,*/
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                      prefixIcon: Images.user,
                      divider: false,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    Spacer(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          buttonText: ' Save Changes'.tr,

                          onPressed: () => (){},
                        ),
                      ),
                    ),

                  ]),
                ),
              ))))
          : NotLoggedInScreen(),

    );
  }
}
