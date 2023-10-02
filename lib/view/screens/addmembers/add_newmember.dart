import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sixam_mart/controller/home_controller.dart';

import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/item_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../base/custom_button.dart';
import '../../base/custom_dialog.dart';
import '../../base/custom_image.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';


class AddNewMembers extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<AddNewMembers> createState() => _AddNewMembersState();
}

class _AddNewMembersState extends State<AddNewMembers> {

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _regionFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();

  void _loadData() async {
    Get.find<AuthController>().clearData();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Scrollbar(
        child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
    child:
    GetBuilder<AuthController>(
    builder: (authController) =>
    !authController.isLoading ?
    Container(color:Theme.of(context).hintColor.withOpacity(0.1),
        child:Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          ),
          child: Column(children: [
            SizedBox(
                height:
                Dimensions.PADDING_SIZE_LARGE),

            CustomTextField(
              hintText: 'Enter First Name'.tr,
              controller: _nameController,
              focusNode: _nameFocus,
              nextFocus: _emailFocus,
              inputType: TextInputType.emailAddress,
              capitalization:
              TextCapitalization.words,
              prefixIcon: Images.user,
              divider: false,
            ),
            SizedBox(
                height:
                Dimensions.PADDING_SIZE_LARGE),
            CustomTextField(
              hintText: 'Enter Email Address'.tr,
               controller: _emailController,
              focusNode: _emailFocus,
              nextFocus: _phoneFocus,
              inputType: TextInputType.emailAddress,
              capitalization:
              TextCapitalization.words,
              prefixIcon: Images.mail,
              divider: false,
            ),SizedBox(
                height:
                Dimensions.PADDING_SIZE_LARGE),
            CustomTextField(
              hintText: 'Phone'.tr,
               controller: _phoneController,
              focusNode: _phoneFocus,
              nextFocus: _regionFocus,
              inputType: TextInputType.phone,
              prefixIcon: Images.call,
              divider: false,
            ),
            SizedBox(
                height:
                Dimensions.PADDING_SIZE_LARGE),
            CustomTextField(
              hintText: 'Region'.tr,
               controller: _regionController,
              focusNode: _regionFocus,
              nextFocus: _addressFocus,
              inputType: TextInputType.name,
              capitalization:
              TextCapitalization.words,
              prefixIcon: Images.region,
              divider: false,
            ), SizedBox(
                height:
                Dimensions.PADDING_SIZE_LARGE),
            CustomTextField(
              hintText: 'Address'.tr,
               controller: _addressController,
              focusNode: _addressFocus,
              nextFocus: _addressFocus,
              inputType: TextInputType.name,
              capitalization:
              TextCapitalization.words,
              prefixIcon: Images.address,
              divider: false,
            ),
            SizedBox(
                height:
                Dimensions.PADDING_SIZE_LARGE),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Upload member profile Images",
                style: robotoRegular.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: Dimensions.fontSizeLarge),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
            InkWell(
                onTap: () {
                  openSelectImage(authController);
                },
                child: authController.rawFile != null
                    ? Image.memory(
                  authController.rawFile,
                  fit: BoxFit.fitWidth,
                ):
                Image.asset(
                  Images.add_photo,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                )

            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

            CustomButton(
              buttonText: 'Add Member'.tr,
              onPressed: () => _login(authController)
              ,
            ), SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

          ],),
        )):
    Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
    )

    )));
  }


  void openSelectImage(AuthController authController) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return
            Container(
              height: 310,
              padding: EdgeInsets.all(
                Dimensions.RADIUS_SMALL,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  border:
                  Border.all(width: 1, color: Theme.of(context).cardColor),
                  color: Theme.of(context).cardColor),
              // Set the desired height of the bottom sheet
              child: Column(
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Center(
                    child: SvgPicture.asset(Images.bottom_sheet_line,color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Choose For Attach File '.tr,
                        textAlign: TextAlign.center,
                        style: robotoBold.copyWith(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeExtraLarge,
                        )),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    margin: EdgeInsets.all(
                      Dimensions.RADIUS_SMALL,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1, color: Theme.of(context).disabledColor),
                      color: Colors.transparent,
                    ),
                    child: InkWell(
                        onTap: () {
                          authController.pickImage();
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.gallery_image,color: Theme.of(context).primaryColor),
                          Expanded(
                            child: Text('Choose picture of gallery'.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),
                          Image.asset(Images.arrow_right_normal,
                              height: 10, fit: BoxFit.contain),
                          SizedBox(width: 10),
                        ])),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    margin: EdgeInsets.all(
                      Dimensions.RADIUS_SMALL,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1, color: Theme.of(context).disabledColor),
                      color: Colors.transparent,
                    ),
                    child: InkWell(
                        onTap: () {
                          authController.pickCameraImage();
                          Get.back();
                        },
                        child: Row(children: [
                          SizedBox(width: 10),
                          SvgPicture.asset(Images.take_photo,color: Theme.of(context).primaryColor,),
                          Expanded(
                            child: Text('Take a photo'.tr,
                                textAlign: TextAlign.center,
                                style: robotoBold.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: Dimensions.fontSizeLarge,
                                )),
                          ),

                          Image.asset(Images.arrow_right_normal,
                              height: 10, fit: BoxFit.contain),
                          SizedBox(width: 10),
                        ])),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),


                ],
              ));
        },
        backgroundColor: Colors.transparent);
  }

  void _login(AuthController authController) async {
    String _email = _emailController.text.trim();
    String _name = _nameController.text.trim();
    String _phone = _phoneController.text.trim();
    String _region = _regionController.text.trim();
    String _address = _addressController.text.trim();


    if (_name.isEmpty) {
      showCustomSnackBar('Enter Name'.tr);
    }
    else if (_email.isEmpty) {
      showCustomSnackBar('Enter Email Address'.tr);
    } else if (_phone.isEmpty) {
      showCustomSnackBar('Enter Phone'.tr);
    }else if (_region.isEmpty) {
      showCustomSnackBar('Enter Valid Region'.tr);
    }else if (_address.isEmpty) {
      showCustomSnackBar('Enter Address '.tr);
    } else {
      authController
          .asyncTestFileUpload(authController.file, _name, _email, _phone, _region, _address)
          .then((status) async {
        if (status) {
         authController.clearData();
         _emailController.text = "";
         _nameController.text = "";
         _phoneController.text = "";
         _regionController.text = "";
         _addressController.text = "";

        }
      });
      //
    }
  }
}


