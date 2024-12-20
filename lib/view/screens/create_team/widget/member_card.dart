import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../controller/home_controller.dart';
import '../../../../data/model/response/player.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class MemberCard extends StatelessWidget {
  Player player;
  String skills;

  MemberCard(this.player,this.skills );

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeController>(
        builder: (homeController) {
      return

      InkWell(
        onTap: () {
         // Get.toNamed(RouteHelper.getCreateTeamScreenRoute());
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
                              child:Stack(children: [
                                SvgPicture.asset(Images.defult_member_user),
                                Positioned(bottom: 0,left: 0,
                                    child: Container(
                                      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right:Dimensions.PADDING_SIZE_DEFAULT,top:Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL ,bottom:Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL ),
                                      decoration:BoxDecoration(
                                        color: Color(0xFF003F16)  ,
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)
                                    )),child: Text(player.nationality!=null && player.nationality.shortCode!=null ?player.nationality.shortCode :"",style: robotoMedium.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeLargeExtraSmall),),))
                              ],)
                                 ,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      player.name,
                                      style: robotoBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize: Dimensions.fontSizeDefault),
                                    ),
                                    // Text(
                                    //   "Sel By 94.24",
                                    //   style: robotoBold.copyWith(
                                    //       color: Theme.of(context)
                                    //           .cardColor
                                    //           .withOpacity(0.5),
                                    //       fontSize: Dimensions.fontSizeSmall),
                                    // ),
                                    //
                                    // Text(
                                    //   "Played last Match",
                                    //   style: robotoBold.copyWith(
                                    //       color: Theme.of(context)
                                    //           .cardColor
                                    //           .withOpacity(0.5),
                                    //       fontSize: Dimensions.fontSizeSmall),
                                    // ),
                                  ],
                                )),
                          ],
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                                flex: 1,
                                child: Column(children: [
                                Text(
                                  '${homeController.getPoints(player.key)}',
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context)
                                          .cardColor
                                          .withOpacity(0.5)),
                                ),
                                  SizedBox(height: 5,)
                                ],)
                            ),

                            Expanded(
                                flex: 2,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${homeController.getCreditPoint(player.key)}',
                                      style: robotoBold.copyWith(
                                          color: Theme.of(context).cardColor),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(onTap: (){
                                      homeController.addPlayersInMyTeam(player,skills);
                                    },
                                    child:
                                    homeController.selectedPlayersList.contains(player)?
                                        Icon(Icons.check_circle_outline_rounded,color: Theme.of(context).primaryColor,size: 30,):
                                    SvgPicture.asset(Images.select_plus))
                                  ],
                                )),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )));
        });
  }
}
