import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/data/model/response/my_contest_list/my_contest_data.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../data/model/response/matchList/matches.dart';
import '../../../../data/model/response/match_leader_board/leaderboard_data.dart';
import '../../../../data/model/response/matchlist.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class LeaderBoardUserList extends StatelessWidget {

  LeaderBoardDetails leaderBoardDetails;

  LeaderBoardUserList(this.leaderBoardDetails);

  @override
  Widget build(BuildContext context) {
    return
        Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            margin: EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),

            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: Image.asset(
                        Images.defult_user_png,
                        fit: BoxFit.cover, // Ensure the image fits well
                        width: 40, // Set width to control image size
                        height: 40,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded( // Use Expanded to prevent overflow and use available space
                      child: Text(
                        leaderBoardDetails.teamname,
                        style: robotoMedium.copyWith(color: Theme.of(context).cardColor),
                        overflow: TextOverflow.ellipsis, // Optional, to handle overflow in the text
                      ),
                    ),
                    Spacer(),
                    Text(
                      leaderBoardDetails.position,
                      style: robotoBold.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
              Divider(thickness: 0.5,color: Theme.of(context).disabledColor,)
              ],
            ))
    ;
  }
}
