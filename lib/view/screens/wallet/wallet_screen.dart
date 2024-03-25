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

class WalletScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
            CustomAppBar(title: 'Wallet', onBackPressed: () => {Get.back()}),
        body: Container(
            color: Theme.of(context).backgroundColor,
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
                                  child: Row(
                                    children: [
                                      Image.asset(Images.wallet_selected),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Current Balance",
                                        style: robotoMedium.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  )),

                              Expanded(
                                  flex: 1,
                                  child: Row( crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      Text(
                                        "\$0",
                                        style: robotoBold.copyWith(
                                            color:
                                                Theme.of(context).cardColor,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),

                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(children: [
                            Expanded(flex: 3,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration:BoxDecoration(
                                    color:  Color(0xFF0F0C13),
                                    border: Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)
                                  ) ,
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                    Text("Amount to Add",style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).cardColor),),
                                    Text("\$0",style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).cardColor),),
                                  ],),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration:BoxDecoration(
                                    color:  Color(0xFF1D6F00),
                                    border: Border.all(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)
                                  ) ,
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Text("\$100",style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).cardColor),),
                                  ],),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration:BoxDecoration(
                                    color:  Color(0xFF1D6F00),
                                    border: Border.all(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)
                                  ) ,
                                  child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Text("\$500",style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).cardColor),),
                                  ],),
                                )),
                          ],),
                          SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            height: 50,
                            buttonText: 'Add \$0'.tr,
                            onPressed: () {
                              Get.toNamed(RouteHelper.getAddPaymentOptionRoute());
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InkWell(onTap: (){
                            Get.toNamed(RouteHelper.getWithdrawRoute());
                          },
                          child:
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [


                                      Text(
                                        "Withdraw Instantly ",
                                        style: robotoMedium.copyWith(
                                            color:
                                            Theme.of(context).primaryColor,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),

                                    ],
                                  )),

                              Expanded(
                                  flex: 1,
                                  child: Row( crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Theme.of(context).cardColor,
                                      ),

                                    ],
                                  )),
                            ],
                          )),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [


                                      Text(
                                        "My Transactions",
                                        style: robotoMedium.copyWith(
                                            color:
                                            Theme.of(context).primaryColor,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),

                                    ],
                                  )),

                              Expanded(
                                  flex: 1,
                                  child: Row( crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Theme.of(context).cardColor,
                                      ),

                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    )))));
  }
}
