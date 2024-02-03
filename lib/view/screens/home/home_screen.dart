import 'dart:async';

import 'package:sixam_mart/controller/home_controller.dart';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time

  double latitude;
  double longitude;



  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());

    return Scaffold(
        body: Scrollbar(
            child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(children: [

          Text("over_mission".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeExtraLarge),),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

          Text("over_mission_content".tr,style: robotoMedium.copyWith(color: Theme.of(context).hintColor.withOpacity(0.5),fontSize: Dimensions.fontSizeDefault),),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

          Container(
            alignment: Alignment.topLeft,
            child: Column(children: [
           Align(alignment: Alignment.topLeft,
           child:
              Text("justice".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)),
            Align(alignment: Alignment.topLeft,
              child:
            Container(
              width: 50,
              alignment: Alignment.topLeft,// Set the height of the line
              child:  Divider(color: Theme.of(context).primaryColor,thickness: 1,),// Set the color of the line
            )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text("justice_content".tr,style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),

          ],),),

          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

          Container(
            alignment: Alignment.topLeft,
            child: Column(children: [
           Align(alignment: Alignment.topLeft,
           child:
              Text("national_unity".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)),
            Align(alignment: Alignment.topLeft,
              child:
            Container(
              width: 50,
              alignment: Alignment.topLeft,// Set the height of the line
              child:  Divider(color: Theme.of(context).primaryColor,thickness: 1,),// Set the color of the line
            )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text("national_unity_content".tr,style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),

          ],),),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

          Container(
            alignment: Alignment.topLeft,
            child: Column(children: [
           Align(alignment: Alignment.topLeft,
           child:
              Text("work".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)),
            Align(alignment: Alignment.topLeft,
              child:
            Container(
              width: 50,
              alignment: Alignment.topLeft,// Set the height of the line
              child:  Divider(color: Theme.of(context).primaryColor,thickness: 1,),// Set the color of the line
            )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text("work_content".tr,style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),

          ],),),

          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

          Container(
            alignment: Alignment.topLeft,
            child: Column(children: [
           Align(alignment: Alignment.topLeft,
           child:
              Text("education".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)),
            Align(alignment: Alignment.topLeft,
              child:
            Container(
              width: 50,
              alignment: Alignment.topLeft,// Set the height of the line
              child:  Divider(color: Theme.of(context).primaryColor,thickness: 1,),// Set the color of the line
            )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text("education_content".tr,style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),

          ],),),
 SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

          Container(
            alignment: Alignment.topLeft,
            child: Column(children: [
           Align(alignment: Alignment.topLeft,
           child:
              Text("health".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)),
            Align(alignment: Alignment.topLeft,
              child:
            Container(
              width: 50,
              alignment: Alignment.topLeft,// Set the height of the line
              child:  Divider(color: Theme.of(context).primaryColor,thickness: 1,),// Set the color of the line
            )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text("health_content".tr,style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),

          ],),),SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

          Container(
            alignment: Alignment.topLeft,
            child: Column(children: [
           Align(alignment: Alignment.topLeft,
           child:
              Text("food_safety".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)),
            Align(alignment: Alignment.topLeft,
              child:
            Container(
              width: 50,
              alignment: Alignment.topLeft,// Set the height of the line
              child:  Divider(color: Theme.of(context).primaryColor,thickness: 1,),// Set the color of the line
            )),
            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text("food_safety_content".tr,style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeLarge),),

          ],),),



        ],),
      ),
    )));
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
