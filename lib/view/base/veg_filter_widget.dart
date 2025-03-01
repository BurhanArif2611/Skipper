import 'package:sixam_mart/controller/localization_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VegFilterWidget extends StatelessWidget {
  final String type;
  final Function(String value) onSelected;
  VegFilterWidget({@required this.type, @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final bool _ltr = Get.find<LocalizationController>().isLtr;
    bool showVeg=false;
    try{
      int moduleId = Get.find<StoreController>().store != null
          ? Get.find<StoreController>().store.moduleId
          : 0;
      if (Get.find<SplashController>().moduleList != null) {
        Get.find<SplashController>().moduleList.forEach((storeCategory) => {
          if (storeCategory.id == moduleId)
            {
              if (storeCategory.moduleType == 'food' ||
                  storeCategory.moduleType == 'Food')
                {showVeg = true}
            }
        });
      }}catch(e){}
    return (Get.find<SplashController>().configModel.moduleConfig.module.vegNonVeg
    && Get.find<SplashController>().configModel.toggleVegNonVeg) ? Align(alignment: Alignment.center, child: Container(
      height: showVeg?30:0,
      margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      decoration: showVeg?BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL)),
        border: Border.all(color: Theme.of(context).primaryColor),
      ):null,
      child:showVeg?
      ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Get.find<ItemController>().itemTypeList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => onSelected(Get.find<ItemController>().itemTypeList[index]),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(
                    _ltr ? index == 0 ? Dimensions.RADIUS_SMALL : 0
                        : index == Get.find<ItemController>().itemTypeList.length-1
                        ? Dimensions.RADIUS_SMALL : 0,
                  ),
                  right: Radius.circular(
                    _ltr ? index == Get.find<ItemController>().itemTypeList.length-1
                        ? Dimensions.RADIUS_SMALL : 0 : index == 0
                        ? Dimensions.RADIUS_SMALL : 0,
                  ),
                ),
                color: Get.find<ItemController>().itemTypeList[index] == type ? Theme.of(context).primaryColor
                    : Theme.of(context).cardColor,
              ),
              child: Text(
                Get.find<ItemController>().itemTypeList[index].tr,
                style: Get.find<ItemController>().itemTypeList[index] == type
                    ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor)
                    : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
            ),
          );
        },
      ):SizedBox( width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
    )) : SizedBox();
  }
}
