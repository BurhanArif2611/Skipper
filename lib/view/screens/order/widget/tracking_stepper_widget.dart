import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/screens/order/widget/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackingStepperWidget extends StatelessWidget {
  final String status;
  final String orderType;
  final bool takeAway;
  TrackingStepperWidget({@required this.status, @required this.takeAway, @required this.orderType});

  @override
  Widget build(BuildContext context) {
    int _status = -1;
    if(status == 'pending') {
      _status = 0;
    }else if(status == 'accepted' || status == 'confirmed') {
      _status = 1;
    }else if(status == 'processing') {
      _status = 2;
    }else if(status == 'handover') {
      _status = takeAway ? 3 : 2;
    }else if(status == 'picked_up') {
      _status = 3;
    }else if(status == 'delivered') {
      _status = 4;
    }

    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
      ),
      child: Row(children: [
        CustomStepper(
          title:'order_placed'.tr, isActive: _status > -1, haveLeftBar: false, haveRightBar: true, rightActive: _status > 0,
        ),
        CustomStepper(
          title:orderType=='errand'?'Order Confirmed & Vendor Assigned' :'order_confirmed'.tr, isActive: _status > 0, haveLeftBar: true, haveRightBar: true, rightActive: _status > 1,
        ),
        (orderType!='parcel' && orderType!='errand'?
        CustomStepper(
          title: orderType=='parcel'?'':'preparing_item'.tr, isActive:orderType=='parcel'?false: _status > 1, haveLeftBar:orderType=='parcel'?false: true, haveRightBar:orderType=='parcel'?false: true, rightActive:orderType=='parcel'?false: _status > 2,
        ):SizedBox()) ,
        (orderType!='errand'?
        CustomStepper(
          title: orderType=='parcel'?'Pick Up': takeAway ? 'ready_for_handover'.tr : 'delivery_on_the_way'.tr, isActive: _status > 2, haveLeftBar: true, haveRightBar: true, rightActive: _status > 3,
        ):SizedBox()),
        CustomStepper(
          title: orderType=='errand'?'Task Completed'.tr:'delivered'.tr, isActive: _status > 3, haveLeftBar: true, haveRightBar: false, rightActive: _status > 4,
        ),
      ]),
    );
  }
}
