import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/styles.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
 /* if (message != null && message.isNotEmpty && !isError) {*/
    ScaffoldMessenger.of(Get.context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        right: ResponsiveHelper.isDesktop(Get.context)
            ? Get.context.width * 0.7
            : Dimensions.PADDING_SIZE_SMALL,
        top: Dimensions.PADDING_SIZE_SMALL,
        bottom: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_SMALL,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      content: Text(message, style: robotoMedium.copyWith(color: Colors.white)),
    ));
  /* }
  else {
    showDialog(
        context: Get.context,
        builder: (ctx) => AlertDialog(
              title: const Text("Alert"),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    color: Theme.of(Get.context).disabledColor,
                    padding: const EdgeInsets.all(14),
                    child:  Text("okay",style:robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(Get.context).primaryColor),
                        textAlign: TextAlign.center),
                  ),
                ),
              ],
            ));
  }*/
}
