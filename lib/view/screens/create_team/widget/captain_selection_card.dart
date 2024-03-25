import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../helper/route_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class CaptainSelectionCard extends StatelessWidget {
  CaptainSelectionCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {

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
                                          )),child: Text("AUS",style: robotoMedium.copyWith(color: Theme.of(context).cardColor,fontSize: Dimensions.fontSizeLargeExtraSmall),),))
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
                                      "David Warner",
                                      style: robotoBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize: Dimensions.fontSizeSmall),
                                    ),
                                    Text(
                                      "300",
                                      style: robotoBold.copyWith(
                                          color: Theme.of(context)
                                              .cardColor
                                              .withOpacity(0.5),
                                          fontSize: Dimensions.fontSizeSmall),
                                    ),

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
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
                                    border: Border.all(width: 1, color: Theme.of(context).cardColor),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("C",style: robotoBold.copyWith(color: Theme.of(context).cardColor),),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
                                    border: Border.all(width: 1, color: Theme.of(context).cardColor),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text("VC",style: robotoBold.copyWith(color: Theme.of(context).cardColor),),
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
  }
}
