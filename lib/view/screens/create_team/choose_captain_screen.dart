import 'dart:async';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/create_team/widget/captain_selection_card.dart';
import 'package:sixam_mart/view/screens/create_team/widget/member_card.dart';
import 'package:sixam_mart/view/screens/create_team/widget/slider_team_card.dart';
import 'package:sixam_mart/view/screens/kyc/widget/steppage.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../controller/auth_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../home/widget/team_card.dart';

class ChooseCaptainTeamScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<ChooseCaptainTeamScreen> createState() => ChooseCaptainTeamScreenState();
}

class ChooseCaptainTeamScreenState extends State<ChooseCaptainTeamScreen> {
  int _index = 0;
  int activeStep = 0;
  final PageController _pageController = PageController();

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
            title: 'Create Team', onBackPressed: () => {Get.back()}),
        body: GetBuilder<OnBoardingController>(builder: (onBoardingController) {
          return Container(
              color: Theme.of(context).backgroundColor,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child:Stack(
                children: [


                        Container(
                            width: MediaQuery.of(context).size.width,
                            child:
                                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text("Choose your Captain and Vice Captain",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),),
                                          SizedBox(height: 5,),
                                          Text("C Get 2X Points, VC Get 1.5X Points",style: robotoMedium.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),),

                                          SizedBox(height: 20,),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "Type",
                                                    style: robotoBold.copyWith(
                                                        color: Theme.of(context)
                                                            .cardColor.withOpacity(0.5),
                                                        fontSize:
                                                        Dimensions.fontSizeSmall),
                                                  )),Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    "Points",
                                                    style: robotoBold.copyWith(
                                                        color: Theme.of(context)
                                                            .cardColor.withOpacity(0.5),
                                                        fontSize:
                                                        Dimensions.fontSizeSmall),
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child:Text(
                                                  "%C By",
                                                  style: robotoBold.copyWith(
                                                      color: Theme.of(context)
                                                          .cardColor.withOpacity(0.5),
                                                      fontSize:
                                                      Dimensions.fontSizeSmall),
                                                ),
                                              ),

                                              Expanded(
                                                flex: 1,
                                                child:Text(
                                                  "%VC By",
                                                  style: robotoBold.copyWith(
                                                      color: Theme.of(context)
                                                          .cardColor.withOpacity(0.5),
                                                      fontSize:
                                                      Dimensions.fontSizeSmall),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                            Expanded(
                              flex: 1,
                              child:
                              ListView.builder(
                                              shrinkWrap: true,
                                               /* controller: _scrollController,*/
                                              itemCount: 10,
                                              /*physics: ScrollPhysics(),*/
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index_option) {
                                                return CaptainSelectionCard();
                                              })),
                                        ],
                                      )),


                Positioned(bottom: 10,left: 0,right: 0,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 200,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor ,
                            borderRadius: BorderRadius.all( Radius.circular(Dimensions.RADIUS_SMALL)),
                          ),
                          alignment: Alignment.center,
                          child: Text("Preview",style: robotoBold.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),
                        ),
                        SizedBox(width: 10,),
                        InkWell(onTap: (){
                          Get.toNamed(RouteHelper.getFinalTeamScreenRoute());
                        },
                            child:
                            Container(width: 80,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:Color(0xFF1D6F00) ,
                                borderRadius: BorderRadius.all( Radius.circular(Dimensions.RADIUS_SMALL)),
                              ),
                              alignment: Alignment.center,
                              child: Text("Save",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeLarge),),
                            )),


                      ],
                    ))
              ],));

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
