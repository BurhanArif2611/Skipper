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
import '../../../controller/home_controller.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../data/model/response/matchList/matches.dart';
import '../../../data/model/response/player.dart';
import '../../../helper/route_helper.dart';
import '../../base/custom_app_bar.dart';
import '../home/widget/team_card.dart';

class FinalCreateTeamPreviewScreen extends StatefulWidget {
  Matches matchID;

  FinalCreateTeamPreviewScreen({ @required this.matchID});

  @override
  State<FinalCreateTeamPreviewScreen> createState() =>
      FinalCreateTeamPreviewScreenState();
}

class FinalCreateTeamPreviewScreenState
    extends State<FinalCreateTeamPreviewScreen> {
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
        appBar:
            CustomAppBar(title: '0h:15m', onBackPressed: () => {Get.back()}),
        body: GetBuilder<HomeController>(builder: (homeController) {
          return Container(
              color: Theme.of(context).backgroundColor,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(10),
              child:
                  /* SingleChildScrollView(
          child:*/
                  Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(margin:EdgeInsetsDirectional.symmetric (horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child:
                      TeamCardItem(widget.matchID,false)),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                          width: MediaQuery.of(context).size.width - 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Images.preview_bg),
                                fit:
                                    BoxFit.cover // Specify your image path here
                                // You can adjust the fit as per your requirement
                                ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: 10,),
                           Text("Wicket keeper",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeDefault),),
                              SizedBox(height: 10,),
                            Expanded(flex: 1,
                                child:
                              Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ProfileWidget(player:homeController.selectedPlayersList.length>0?homeController.selectedPlayersList[0]:null),
                                  SizedBox(width: 20,),
                              ProfileWidget(player:homeController.selectedPlayersList.length>1?homeController.selectedPlayersList[1]:null),

                                ],
                              )),

                              SizedBox(height: 20,),
                              Text("Batters",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeDefault),),
                              SizedBox(height: 20,),
                              Expanded(flex: 1,
                            child:
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              Expanded(flex: 1,
                              child:
                                  ProfileWidget(player:homeController.selectedPlayersList.length>2?homeController.selectedPlayersList[2]:null),
                              ),
                                  SizedBox(width: 20,),
                                  Expanded(flex: 1,
                                    child:
                                  ProfileWidget(player:homeController.selectedPlayersList.length>3?homeController.selectedPlayersList[3]:null),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(flex: 1,
                                    child:
                                  ProfileWidget(player:homeController.selectedPlayersList.length>4?homeController.selectedPlayersList[4]:null),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(flex: 1,
                                    child:
                                  ProfileWidget(player:homeController.selectedPlayersList.length>5?homeController.selectedPlayersList[5]:null),
                                  ),
                                ],
                              )),
                              SizedBox(height: 20,),
                              Text("All Rounders",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeDefault),),
                              SizedBox(height: 20,),
                              Flexible(flex: 1,
                            child:
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                              Expanded(flex: 1,
                              child:
                                  ProfileWidget(player:homeController.selectedPlayersList.length>6?homeController.selectedPlayersList[6]:null),
                              ),
                                  SizedBox(width: 20,),
                                  Expanded(flex: 1,
                                    child:
                                  ProfileWidget(player:homeController.selectedPlayersList.length>7?homeController.selectedPlayersList[7]:null),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(flex: 1,
                                    child:
                                  ProfileWidget(player:homeController.selectedPlayersList.length>8?homeController.selectedPlayersList[8]:null),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(flex: 1,
                                    child:
                                  ProfileWidget(player:homeController.selectedPlayersList.length>9?homeController.selectedPlayersList[9]:null),
                                  ),
                                ],
                              )),




                              SizedBox(height: 20,),
                              Text("Bowlers",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeDefault),),
                              SizedBox(height: 20,),
                              Flexible(flex: 1,
                            child:
                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ProfileWidget(player:homeController.selectedPlayersList.length>10?homeController.selectedPlayersList[10]:null),

                                  SizedBox(width: 20,),
                                  ProfileWidget(player:homeController.selectedPlayersList.length>11?homeController.selectedPlayersList[11]:null),

                                  SizedBox(width: 20,),
                                  ProfileWidget(player:homeController.selectedPlayersList.length>12?homeController.selectedPlayersList[12]:null),

                                ],
                              )),
                            ],
                          ))),
                ],
              )
              /*)*/
              );
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

class ProfileWidget extends StatelessWidget {

  final Player player;
  ProfileWidget({@required this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        /*CircleAvatar(
          radius: 30, // Size of the avatar
          backgroundImage: NetworkImage(
              'https://via.placeholder.com/150'), // Network image URL or you can use AssetImage for a local file
        ),*/ // Space between image and text
        Image.asset(Images.defult_user_png,width: 50,height: 50,),

        Container(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Color(0xFF0C1287),
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),

            ),
            /*${player.name}*/
            child: Text(
              '${player!=null?player.name:""}', // Replace with dynamic variable if needed
              style: robotoMedium.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeExtraSmall),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
  }
}
