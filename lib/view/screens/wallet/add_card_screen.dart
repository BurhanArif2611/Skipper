import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../auth/widget/condition_check_box.dart';
import '../home/widget/team_card.dart';

class AddCardScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
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
            CustomAppBar(title: 'Add Card', onBackPressed: () => {Get.back()}),
        body: Container(
            color: /*Theme.of(context).hintColor*/ Color(0xFF19181E),
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
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Color(0xFF0F0C13),
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Enter card details",
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  hintText: 'Card name'.tr,
                                  /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                                  inputType: TextInputType.name,
                                  capitalization: TextCapitalization.words,
                                  divider: false,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  hintText: 'Card number'.tr,
                                  /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                                  inputType: TextInputType.name,
                                  capitalization: TextCapitalization.words,
                                  divider: false,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextField(
                                        hintText: 'Expiry date'.tr,
                                        /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                                        inputType: TextInputType.name,
                                        capitalization:
                                            TextCapitalization.words,
                                        divider: false,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CustomTextField(
                                        hintText: 'CVV'.tr,
                                        /* controller: _firstNameController,
          focusNode: _firstNameFocus,
          nextFocus: _lastNameFocus,*/
                                        inputType: TextInputType.name,
                                        capitalization:
                                            TextCapitalization.words,
                                        divider: false,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GetBuilder<AuthController>(
                                    builder: (authController) {
                                  return ConditionCheckBox(
                                      authController: authController);
                                }),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  height: 50,
                                  buttonText: 'Add \$0'.tr,
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    )))));
  }
}
