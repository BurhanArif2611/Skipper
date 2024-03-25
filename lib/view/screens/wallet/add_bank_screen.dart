import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../home/widget/team_card.dart';

class AddBankScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  @override
  void initState() {
    super.initState();

    // _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        CustomAppBar(title: 'Add Bank', onBackPressed: () => {Get.back()}),
        body: Container(
            color: Theme.of(context).hintColor,
            child: Scrollbar(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      margin:
                      EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Account",
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color: Theme.of(context).cardColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Please enter your bank account details with which you are going to make add money or withdrawal.",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).cardColor.withOpacity(0.5)),
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
                            buttonText: 'Submit'.tr,
                            onPressed:  () {
                              Get.toNamed(RouteHelper.getKYCSuccessScreenRoute());
                            },
                          ),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )))));
  }
}
