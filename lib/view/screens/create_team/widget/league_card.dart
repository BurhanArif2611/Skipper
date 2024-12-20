import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/view/base/common_dailog.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../controller/home_controller.dart';
import '../../../../data/model/response/featured_matches.dart';
import '../../../../data/model/response/league_data.dart';
import '../../../../data/model/response/league_list.dart';
import '../../../../data/model/response/matchList/matches.dart';
import '../../../../data/model/response/player.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class LeagueCard extends StatelessWidget {
  LeagueData league;
  Matches matchID;

  LeagueCard(this.league,this.matchID );

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeController>(
        builder: (homeController) {
          double value=0.0;
          try {
            value = (double.parse(league.total_join_participent_count) /
                double.parse(league.totalParticipent));
          }catch(e){}
          return
            InkWell(
                onTap: () {
                 // Get.toNamed(RouteHelper.getCreateTeamScreenRoute(matchID,league));
                 if(league.total_join_participent_count!=league.totalParticipent) {
                   if (matchID.play_status.contains("scheduled")) {
                     Get.toNamed(
                         RouteHelper.getJoinTeamScreenRoute(matchID, league));
                   }
                   else {
                     CommonDialog.info(context,
                         "The match has already started. That's why you are not able to join a league.");
                   }
                 }else {
                  CommonDialog.info(context, "The league is already full.");

                  }

                },
                child: Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      color:league.total_join_participent_count==league.totalParticipent?Colors.grey.withOpacity(0.5): Theme.of(context).hintColor,
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                      /* boxShadow: [BoxShadow(color: Colors.yellowAccent[Get.isDarkMode ? 600 : 100], spreadRadius: 0.5, blurRadius: 10)],
           */
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                      Text("Entry Price", style: robotoMedium.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize: Dimensions.fontSizeDefault)),
                                         SizedBox(height: 5,),
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
                                                  '\$ ${league.entryfees}',
                                                  style: robotoBold.copyWith(
                                                      color:  Theme.of(
                                                          context)
                                                          .cardColor
                                                  ),
                                                  textAlign:
                                                  TextAlign.center,
                                                )),
                                          )

                                      ],)
                                      ,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),

                                  ],
                                )),



                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LinearProgressIndicator(
                          value: value,
                          backgroundColor: Colors.white,

                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(thickness: 0.5,color: Theme.of(context).cardColor.withOpacity(0.5),),
                        Row(children: [
                          Expanded(flex:1,child: Text("${league.total_join_participent_count} Spots",style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeDefault))),
                          Expanded(flex:1,child: Text("${league.totalParticipent} Participants",style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeDefault),
                            textAlign: TextAlign.end,
                          )
                          ),
                        ],),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )));
        });
  }
}
