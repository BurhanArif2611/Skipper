import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/theme_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();

    if (_isLoggedIn /*&& Get.find<UserController>().userInfoModel == null*/) {
      Get.find<UserController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(
          title: 'Profile', onBackPressed: () => {Get.back()}),
     /* endDrawer: MenuDrawer(),*/
      backgroundColor: Theme.of(context).cardColor,
      body: GetBuilder<UserController>(builder: (userController) {
        return /*(_isLoggedIn && userController.userInfoModel == null)*/
            Container(
              color: Theme.of(context).backgroundColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                SizedBox(
                  height: 40,
                ),
                  Center(
                    child: CircleImageWithCameraIcon(
                      imageUrl: 'https://via.placeholder.com/150',
                      imageSize: 100.0,
                      cameraIconSize: 20.0,
                    ),
                  ),
                  SizedBox(
                  height: 40,
                ),
                Text(
                  "Beneficiary Name",
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).cardColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: 'Beneficiary Name'.tr,
                  /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                  divider: false,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  "Beneficiary Bank Name",
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).cardColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: 'Beneficiary Bank Name'.tr,
                  /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                  divider: false,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  "Routing number & Correspondent Account No.",
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).cardColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: 'Routing number & Correspondent Account No.'.tr,
                  /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                  divider: false,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  "Swift Code",
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).cardColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: 'Swift Code'.tr,
                  /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                  divider: false,
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  "Address",
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).cardColor),
                ),
                SizedBox(
                  height: 5,
                ),
                CustomTextField(
                  hintText: 'Address'.tr,
                  /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                  inputType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                  divider: false,
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  height: 50,
                  buttonText: 'Update'.tr,
                  onPressed:  () {
                    Get.back();
                    //Get.toNamed(RouteHelper.getKYCSuccessScreenRoute());
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],),);
      }),
    );
  }
}

class CircleImageWithCameraIcon extends StatelessWidget {
  final String imageUrl;
  final double imageSize;
  final double cameraIconSize;

  CircleImageWithCameraIcon({
    @required this.imageUrl,
    @required this.imageSize,
    @required this.cameraIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: imageSize,
          height: imageSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                width: 1,
                color: Theme.of(context)
                    .cardColor
                    .withOpacity(0.50)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2.0),
            ),
            child: Icon(
              Icons.camera_alt,
              size: cameraIconSize,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
