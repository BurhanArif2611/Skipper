import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class SliderTeamCard extends StatelessWidget {


  SliderTeamCard();

  @override
  Widget build(BuildContext context) {
    return  InkWell(onTap: (){
    //  Get.toNamed(RouteHelper.getCreateTeamScreenRoute());
    },
        child:
        Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            margin: EdgeInsets.only(top:Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
             /* boxShadow: [BoxShadow(color: Colors.yellowAccent[Get.isDarkMode ? 600 : 100], spreadRadius: 0.5, blurRadius: 10)],
           */ ),
            child:Column(children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Maximum of 8 Players From One Team",style: robotoRegular.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeExtraSmall),))),
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child:
                          Text("Live",style: robotoMedium.copyWith(color: Theme.of(context).errorColor,fontSize: Dimensions.fontSizeSmall),))
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:Row(children: [
                        Column(children: [
                          Image.asset(Images.team_logo),
                          SizedBox(height: 5,),
                          Text("INDIA",style: robotoMedium.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),)
                        ],),
                        SizedBox(width: 10,),
                        Text("IND",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),)
                      ],)
                  ),

                  Expanded(
                      flex: 1,
                      child:Column(crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container( decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor.withOpacity(0.20),
                          ),
                            padding: EdgeInsets.all(5),
                            child:Text("0h:8m",style: robotoMedium.copyWith(color: Theme.of(context).errorColor,fontSize: Dimensions.fontSizeSmall),) ,),
                          Text("9:30AM EST",style: robotoMedium.copyWith(color: Theme.of(context).disabledColor,fontSize: Dimensions.fontSizeSmall),)
                        ],)
                  ),


                  Expanded(
                      flex: 1,
                      child:Row(crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          Text("IND",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),),
                          SizedBox(width: 10,),
                          Column(children: [
                            Image.asset(Images.team_logo),
                            SizedBox(height: 5,),
                            Text("INDIA",style: robotoMedium.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),)
                          ],),
                        ],)
                  ),
                ],
              ),
              SizedBox(height: 10,),


            ],)
        ))
    ;
  }
}
