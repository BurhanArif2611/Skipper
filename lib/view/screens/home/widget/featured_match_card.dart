import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../data/model/response/featured_matches.dart';
import '../../../../data/model/response/matchlist.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class FeaturedMatchCardItem extends StatelessWidget {
  Tournaments matches;
  int Index;

  FeaturedMatchCardItem(this.matches,this.Index);

  @override
  Widget build(BuildContext context) {


    var parts = matches.shortName.split(" vs ");
    return  InkWell(onTap: (){
    //  Get.toNamed(RouteHelper.getCreateTeamScreenRoute());
      Get.toNamed(RouteHelper.getCreateLeagueRoute(matches.key));
    },
        child:
        Container(
          width: MediaQuery.of(context).size.width-100,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            margin: EdgeInsets.only(top:Dimensions.PADDING_SIZE_LARGE,left:Index>0?Dimensions.PADDING_SIZE_LARGE:0),
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
              boxShadow: [BoxShadow(color: Colors.yellowAccent[Get.isDarkMode ? 600 : 100], spreadRadius: 0.5, blurRadius: 10)],
            ),
            child:Column(children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("World Cup 2023 | T20",style: robotoRegular.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeExtraSmall),))),
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
                          Text( parts[0],style: robotoMedium.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),)
                        ],),
                        SizedBox(width: 10,),
                        Text( parts[0],style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),)
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

                          Text( parts[1]!=null?parts[1]:"",style: robotoBold.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),),
                          SizedBox(width: 10,),
                          Column(children: [
                            Image.asset(Images.team_logo),
                            SizedBox(height: 5,),
                            Text( parts[1]!=null?parts[1]:"",style: robotoMedium.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeSmall),)
                          ],),
                        ],)
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Divider(thickness: 0.5,color: Theme.of(context).disabledColor.withOpacity(0.50),),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child:Row(children: [
                        Text("2 Team",style: robotoRegular.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeExtraSmall),),
                        SizedBox(width: 5,),
                        Text("3 Contests",style: robotoRegular.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeExtraSmall),)
                      ],)
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Lineup Announced",style: robotoMedium.copyWith(color: Colors.green,fontSize: Dimensions.fontSizeSmall),),
                          SizedBox(width: 5,),
                          Image.asset(Images.lineup,)
                        ],)
                  ),
                ],
              ),

            ],)
        ))
    ;
  }

/* void ConvertTime(int time) {
    // Convert Unix timestamp to milliseconds
    try {
      int timestamp = time * 1000;

      // Create a DateTime object from the timestamp
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      // Format the DateTime object to display in IST
      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(
          dateTime.toUtc().add(Duration(hours: 5, minutes: 30)));

      print(formattedDateTime); // Output: 2021-01-26 05:30:00
    }catch(e){}
  }*/
}
