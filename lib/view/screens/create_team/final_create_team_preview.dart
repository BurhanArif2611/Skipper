import 'dart:async';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/create_team/widget/captain_selection_card.dart';
import 'package:sixam_mart/view/screens/create_team/widget/slider_team_card.dart';


import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';


class FinalCreateTeamPreviewScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<FinalCreateTeamPreviewScreen> createState() => FinalCreateTeamPreviewScreenState();
}

class FinalCreateTeamPreviewScreenState extends State<FinalCreateTeamPreviewScreen> {
  int _index = 0;
  int activeStep = 0;

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
        appBar: CustomAppBar(
            title: '0h:15m', onBackPressed: () => {Get.back()}),
        body: GetBuilder<OnBoardingController>(builder: (onBoardingController) {
          return Container(
              color: Theme.of(context).backgroundColor,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child:
          SingleChildScrollView(
          child:
              Column(
                children: [


                  SliderTeamCard(),
                  SizedBox(height: 10,),
                  Image.asset(Images.teamPreviewbg)
                ],)));

        }));
  }

  void _moveToPage(int page) {
    setState(() {
      if (page == 3) {
        activeStep = page + 1;
      } else {
        activeStep = page;
      }
    });
    print("activeStep>>>${activeStep}");
  }

  List<Widget> _pageIndicators(
      OnBoardingController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0; i < 10; i++) {
      _indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
            borderRadius: i == onBoardingController.selectedIndex
                ? BorderRadius.circular(50)
                : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
