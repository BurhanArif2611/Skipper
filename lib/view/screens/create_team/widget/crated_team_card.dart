import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../controller/home_controller.dart';

import '../../../../data/model/response/matchList/match_team_list_model.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class CreatedCard extends StatelessWidget {
  Data league;
  String matchID;
  int index;

  CreatedCard(this.league,this.matchID, this.index );

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeController>(
        builder: (homeController) {
          return

          /*  InkWell(
                onTap: () {
                  // Get.toNamed(RouteHelper.getCreateTeamScreenRoute(matchID,league));
                  // Get.toNamed(RouteHelper.getCreateTeamScreenRoute());
                },
                child:*/
                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                    Text(
                    "Team ${index+1}",
                    style: robotoBold.copyWith(
                        color: Theme.of(context).primaryColor),
                  ),

                Container(
                  margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hintColor,
                    borderRadius:
                    BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL)),
                  ),
                  alignment: Alignment.center,
                  child:

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "5",
                                style: robotoBold.copyWith(
                                    color: Theme.of(context).cardColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "IND",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).cardColor),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "5",
                                style: robotoBold.copyWith(
                                    color: Theme.of(context).cardColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "PAK",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).cardColor),
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Stack(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                        // Set your desired radius
                                        child: Image.asset(
                                          Images.defult_user_png,
                                          fit: BoxFit.fitWidth,
                                          height: 100,
                                        ))),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color: Theme.of(context).cardColor),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "C",
                                      style: robotoBold.copyWith(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin:
                            EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Stack(
                              children: [
                                Container(
                                    margin: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.PADDING_SIZE_EXTRA_LARGE),
                                        // Set your desired radius
                                        child: Image.asset(
                                          Images.defult_user_png,
                                          fit: BoxFit.fitWidth,
                                          height: 100,
                                        ))),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1,
                                          color: Theme.of(context).cardColor),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "VC",
                                      style: robotoBold.copyWith(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                ],);

            /*);*/
        });
  }
}
