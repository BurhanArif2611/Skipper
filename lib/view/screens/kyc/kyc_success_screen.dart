import 'dart:async';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/kyc/widget/steppage.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../home/widget/team_card.dart';

class KYCSUCCESSScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<KYCSUCCESSScreen> createState() => KYCSUCCESSScreenState();
}

class KYCSUCCESSScreenState extends State<KYCSUCCESSScreen> {
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
        body: Container(
            color: Theme.of(context).backgroundColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.sticker),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "KYC Completed",
                  style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Thanks for submitting your document we’ll verify it and complete your KYC as soon as possible",
                  style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Theme.of(context).cardColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  height: 50,
                  buttonText: 'Back to home'.tr,
                  onPressed:  () {
                    Get.toNamed(RouteHelper.getDashboardRoute());
                  },
                ),
              ],
            )));
  }
}
