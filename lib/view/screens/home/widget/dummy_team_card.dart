import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../data/model/response/matchList/matches.dart';
import '../../../../data/model/response/matchlist.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class DummyTeamCardItem extends StatelessWidget {

  Matches matches;
  bool shadow;
  DummyTeamCardItem(this.matches,this.shadow);

  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap: (){
      Get.toNamed(RouteHelper.getMyMatchesDetailRoute());
    },
    child:
    Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
          boxShadow: shadow?[
            BoxShadow(
                color: Colors.yellowAccent[Get.isDarkMode ? 600 : 100],
                spreadRadius: 0.5,
                blurRadius: 10)
          ]:null,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${matches.tournament.name}",
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeExtraSmall),
                        ))),
                Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Live",
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).errorColor,
                              fontSize: Dimensions.fontSizeSmall),
                        ))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(Images.team_logo),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            matches.teams.a.name,
                            style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible( // Make this text flexible to prevent overflow
                        child: Text(
                          matches.teams.a.code,
                          style: robotoBold.copyWith(
                            color: Theme.of(context).cardColor,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis, // Ensure text truncates if too long
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.20),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "0h:8m",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).errorColor,
                                    fontSize: Dimensions.fontSizeSmall),
                              ),
                            ),*/
                        Text(
                          '${matches.startAt}',
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: Dimensions.fontSizeSmall),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          matches.teams.b.code,
                          style: robotoBold.copyWith(
                            color: Theme.of(context).cardColor,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow
                              .ellipsis, // This will ensure the text doesn't overflow
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Image.asset(Images.team_logo),
                          SizedBox(height: 5),
                          Text(
                            matches.teams.b.name,
                            style: robotoMedium.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow
                                .ellipsis, // Ensures the text doesn't overflow
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 0.5,
              color: Theme.of(context).disabledColor.withOpacity(0.50),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          "2 Team",
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeExtraSmall),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "3 Contests",
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeExtraSmall),
                        )
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Lineup Announced",
                          style: robotoMedium.copyWith(
                              color: Colors.green,
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          Images.lineup,
                        )
                      ],
                    )),
              ],
            ),
          ],
        ))
    );
  }
}
