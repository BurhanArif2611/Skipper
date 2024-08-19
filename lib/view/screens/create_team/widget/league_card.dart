import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../controller/home_controller.dart';
import '../../../../data/model/response/featured_matches.dart';
import '../../../../data/model/response/league_list.dart';
import '../../../../data/model/response/player.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class LeagueCard extends StatelessWidget {
  Data league;
  Matches matchID;

  LeagueCard(this.league,this.matchID );

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeController>(
        builder: (homeController) {
          return

            InkWell(
                onTap: () {
                 // Get.toNamed(RouteHelper.getCreateTeamScreenRoute(matchID,league));
                   Get.toNamed(RouteHelper.getJoinTeamScreenRoute(matchID,league));
                },
                child: Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
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
                                      Text("\$${league.leagueCost}", style: robotoBlack.copyWith(
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
                                                '\$ ${"50"}',
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
                          Expanded(flex:1,child: Text("10,000 Spots",style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeDefault))),
                          Expanded(flex:1,child: Text("5789 Spots Left",style: robotoMedium.copyWith(
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
