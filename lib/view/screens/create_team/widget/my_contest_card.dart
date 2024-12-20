import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/home_controller.dart';
import '../../../../data/model/response/league_data.dart';
import '../../../../data/model/response/matchList/matches.dart';

import '../../../../data/model/response/my_contest_list/my_contest_data.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class MyContestCard extends StatelessWidget {
  MyContestData myContest;
  Matches matchID;
  LeagueData data;


  MyContestCard(this.myContest,this.matchID, this.data);

  @override
  Widget build(BuildContext context) {
    print("entryfees>>>>> " +
        (data != null && data.entryfees != null
            ? data.entryfees.toString()
            : "sdad"));
    return  GetBuilder<HomeController>(
        builder: (homeController) {
          return

            InkWell(
                onTap: () {
                //  Get.toNamed(RouteHelper.getContestDetailScreen());
                  // Get.toNamed(RouteHelper.getMa(matchID,league));
                 // Get.toNamed(RouteHelper.getJoinTeamScreenRoute(matchID,league));
                },
                child: Container(

                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor,
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                      /* boxShadow: [BoxShadow(color: Colors.yellowAccent[Get.isDarkMode ? 600 : 100], spreadRadius: 0.5, blurRadius: 10)],
           */
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                       child:
                       Column(children: [

                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:Column(crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Text("Price", style: robotoMedium.copyWith(
                                              color: Theme.of(context).cardColor,
                                              fontSize: Dimensions.fontSizeDefault)),
                                          Text("\$${data.entryfees}", style: robotoBlack.copyWith(
                                              color: Theme.of(context).cardColor,
                                              fontSize: Dimensions.fontSizeDefault)),

                                        ],)
                                      ,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Entry",
                                              style: robotoMedium.copyWith(
                                                  color: Theme.of(context).cardColor,
                                                  fontSize: Dimensions.fontSizeDefault),
                                            ),
                                            Container(
                                              decoration:BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Dimensions
                                                            .RADIUS_SMALL)),
                                              )
                                              ,
                                              padding: EdgeInsets.all(
                                                  Dimensions
                                                      .PADDING_SIZE_EXTRA_SMALL),
                                              child:Padding(  padding: EdgeInsets.only(left:
                                              Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL,right: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                                  child:

                                                  Text(
                                                    '\$ ${data.entryfees}',
                                                    style: robotoBold.copyWith(
                                                        color:  Theme.of(
                                                            context)
                                                            .cardColor
                                                    ),
                                                    textAlign:
                                                    TextAlign.center,
                                                  )),
                                            )


                                          ],
                                        )),
                                  ],
                                )),



                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearProgressIndicator(
                          value: 0.5,
                          backgroundColor: Colors.white,

                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(thickness: 0.5,color: Theme.of(context).cardColor.withOpacity(0.5),),
                        Row(children: [
                          Expanded(flex:1,child: Text("${data.total_join_participent_count} Spots",style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeDefault))),
                          Expanded(flex:1,child: Text("${data.total_join_participent_count}/${data.totalParticipent} Spots Left",style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeDefault),
                            textAlign: TextAlign.end,
                          )
                          ),
                        ],),
                        SizedBox(
                          height: 10,
                        ),
                       ],),),
                        Container(
                          height: 40,
                          padding:
                          EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).backgroundColor,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.first_st),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "\$NAN",
                                        style: robotoMedium.copyWith(
                                            color:
                                            Theme.of(context).cardColor,
                                            fontSize:
                                            Dimensions.fontSizeSmall),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.match),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "\$NAN",
                                        style: robotoMedium.copyWith(
                                            color:
                                            Theme.of(context).cardColor,
                                            fontSize:
                                            Dimensions.fontSizeSmall),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SvgPicture.asset(
                                          Images.circle_correct_tick),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Guaranteed",
                                        style: robotoMedium.copyWith(
                                            color:
                                            Theme.of(context).cardColor,
                                            fontSize:
                                            Dimensions.fontSizeSmall),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
               /* Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                        Text(
                          "Joined with 1 team",
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Text(
                          "Team 1",
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ])),*/
                      ],
                    )));
        });
  }
}
