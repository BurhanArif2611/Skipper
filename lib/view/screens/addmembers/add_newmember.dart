import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
/**/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../data/model/response/regions_response.dart';
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
    await Get.find<AuthController>().getRegions();
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
            /*CustomTextField(
              hintText: 'Region'.tr,
               controller: _regionController,
              focusNode: _regionFocus,
              nextFocus: _addressFocus,
              inputType: TextInputType.name,
              capitalization:
              TextCapitalization.words,
              prefixIcon: Images.region,
              divider: false,
            )*/
            GetBuilder<AuthController>(
                builder: (carlistingController) {
                  return TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _regionController,
                      textInputAction: TextInputAction.search,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.streetAddress,
                      onChanged: (text) {
                       // _regionController.getLocation(false, text);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Regions'.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              width: 1),
                        ),
                        hintStyle: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Color(0xFFA1A8B0),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        prefixIcon: IconButton(
                          icon: SvgPicture.asset(
                            Images.search,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      style: robotoMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                    ),
                    suggestionsCallback: (pattern) =>
                    carlistingController.regionsListModel!=null?carlistingController.regionsListModel.data:null,
                    itemBuilder: (context, RegionsData suggestion) {
                      return Padding(
                        padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: Row(children: [
                          Expanded(
                              child: Text(
                                suggestion.chiefPlace,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: robotoMedium.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color,
                                  fontSize: Dimensions.fontSizeSmall,
                                ),
                              )),
                        ]),
                      );
                    },
                    onSuggestionSelected: (RegionsData suggestion) async {
                      _regionController.text = suggestion.chiefPlace;

                    },
                  );
                })

            , SizedBox(
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


