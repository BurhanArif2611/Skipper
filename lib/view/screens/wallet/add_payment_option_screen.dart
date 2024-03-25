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
import '../home/widget/team_card.dart';

class AddPaymentOptionScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<AddPaymentOptionScreen> createState() => _AddPaymentOptionScreenState();
}

class _AddPaymentOptionScreenState extends State<AddPaymentOptionScreen> {
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
        CustomAppBar(title: 'Add Payment Option', onBackPressed: () => {Get.back()}),
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
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Text(
                                        "Debit/Credit Card",
                                        style: robotoMedium.copyWith(
                                            color:
                                            Theme.of(context).primaryColor,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "Add a Card for Convenient Payments From Payment Option.",
                                        style: robotoMedium.copyWith(
                                            color:
                                            Theme.of(context).cardColor.withOpacity(0.5),
                                            fontSize: Dimensions.fontSizeSmall),
                                      ),

                                    ],
                                  )),


                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),



                          SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            height: 50,
                            buttonText: 'Add Card'.tr,
                            onPressed: () {
                              Get.toNamed(RouteHelper.getAddCardRoute());
                            },
                          ),

                          SizedBox(
                            height: 40,
                          ),
                          Align(alignment: Alignment.topLeft,
                          child:
                          Text("Wallet",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)),


                        ],
                      ),
                    )))));
  }
}
