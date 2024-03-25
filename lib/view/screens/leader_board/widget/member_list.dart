import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class MemberListItem extends StatelessWidget {


  MemberListItem();

  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap: (){
     // Get.toNamed(RouteHelper.getCreateTeamScreenRoute());
    },
        child:
        Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE_SMALL),
            margin: EdgeInsets.only(top:Dimensions.PADDING_SIZE_EXTRA_SMALL),

            child:Column(children: [

              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:Row(children: [
                        Image.asset(Images.team_logo),
                        SizedBox(width: 10,),
                        Text("Robert Fox  ",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),),
                        Text("T3",style: robotoBold.copyWith(color: Theme.of(context).cardColor.withOpacity(0.5),fontSize: Dimensions.fontSizeSmall),),
                      ],)
                  ),


                ],
              ),
              SizedBox(height: 10,),
              Divider(thickness: 0.5,color: Theme.of(context).disabledColor.withOpacity(0.50),),


            ],)
        ))
    ;
  }
}
