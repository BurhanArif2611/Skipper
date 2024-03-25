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

class WithdrawScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
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
            CustomAppBar(title: 'Withdraw', onBackPressed: () => {Get.back()}),
        body: Container(
            color:  Color(0xFF19181E),
            child: Scrollbar(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      margin:
                          EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                      child: Stack(
                        children: [
                          Column(children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Image.asset(Images.my_matchs_selected),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Winning Balance",
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
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$0",
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context).cardColor,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF0F0C13),
                                        border: Border.all(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.RADIUS_SMALL)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Minimum withdraw \$10",
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color:
                                                  Theme.of(context).cardColor),
                                        ),
                                        Text(
                                          "\$0",
                                          style: robotoBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              color:
                                                  Theme.of(context).cardColor),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),


                          SizedBox(
                            height: 40,
                          ),
                          InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(Images.wallet_fill),
                                         SizedBox(width: 10,),
                                          Column( crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                            Text(
                                              "Bank of America",
                                              style: robotoBold.copyWith(
                                                  color:
                                                  Theme.of(context).cardColor,
                                                  fontSize:
                                                  Dimensions.fontSizeLarge),
                                            ),
                                            Text(
                                              "XXXXXXXXXX5161",
                                              style: robotoRegular.copyWith(
                                                  color:
                                                  Theme.of(context).cardColor,
                                                  fontSize:
                                                  Dimensions.fontSizeSmall),
                                            ),
                                          ],)
                                         ,
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.circle_outlined,
                                            color: Theme.of(context).cardColor,
                                          ),
                                        ],
                                      )),
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.getAddBankRoute());
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(Images.wallet_fill),
                                          SizedBox(width: 10,),
                                          Column( crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Add Bank Account",
                                                style: robotoBold.copyWith(
                                                    color:
                                                    Theme.of(context).primaryColor,
                                                    fontSize:
                                                    Dimensions.fontSizeLarge),
                                              ),

                                            ],)
                                          ,
                                        ],
                                      )),

                                ],
                              )),
                          ],),
                          Positioned(bottom: 100,left: 0,right: 0,
                            child: CustomButton(
                            height: 50,
                            buttonText: 'Withdraw'.tr,
                            onPressed: () {},
                          ),)
                        ],
                      ),
                    )))));
  }
}
