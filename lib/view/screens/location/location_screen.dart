import 'dart:async';


import 'package:geolocator/geolocator.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';

import 'package:sixam_mart/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/base/common_dailog.dart';

import '../../../util/dimensions.dart';
import '../../../util/styles.dart';

class LocationScreen extends StatefulWidget {
  final String orderID;

  LocationScreen({@required this.orderID});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();



  @override
  void initState() {
    super.initState();
    _loadData();
    /* _checkPermissions();*/
  }

  void _loadData() async {
    Get.find<SplashController>().showLoader();

    Get.find<SplashController>().determinePosition(context).then((value) async {
      if (value != null)
        Get.find<SplashController>().getBlackGeoList(
            value.latitude, value.longitude).then((value) async{
        if(!value){
        Get.offNamed(RouteHelper
            .getInitialRoute());
        }
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>().initSharedData();

    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return LoadingOverlay(
            isLoading: splashController.isLoading,
            progressIndicator: CircularProgressIndicator(
              color:
              Theme
                  .of(context)
                  .primaryColor, // Set your desired color here
            ),
            child: Container(
                height: double.infinity,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Theme
                    .of(context)
                    .backgroundColor,
                child: Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: Image.asset(
                              Images.logo,
                              width: 100,
                            )),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Expanded(
                            flex: 2,
                            child: Center(
                                child:
                                Image.asset(Images.location_map_icon_png))),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        splashController.blockGeoList != null
                            ? Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Enable Your Location",
                                  style: robotoBlack.copyWith(
                                      color: Theme
                                          .of(context)
                                          .cardColor,
                                      fontSize:
                                      Dimensions.fontSizeOverLarge),
                                ),
                                SizedBox(
                                    height: Dimensions.PADDING_SIZE_SMALL),
                                Text(
                                  "Allow maps to access your location while you use the app?",
                                  style: robotoMedium.copyWith(
                                      color: Theme
                                          .of(context)
                                          .cardColor,
                                      fontSize: Dimensions.fontSizeDefault),
                                ),
                                SizedBox(
                                    height: Dimensions.PADDING_SIZE_SMALL),
                                !splashController.isWithinRadius
                                    ? InkWell(
                                    onTap: () {
                                      Get.offNamed(RouteHelper
                                          .getInitialRoute());
                                    },
                                    child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFF8CA0A),
                                              Color(0xFFFFE166),
                                              Color(0xFFDCB822),
                                              Color(0xFFFFE166),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius
                                              .all(Radius.circular(
                                              Dimensions
                                                  .RADIUS_SMALL)),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisSize:
                                          MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.asset(Images
                                                .Location_small_Icon),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              "Allow Device Location",
                                              style: robotoBlack.copyWith(
                                                  color:
                                                  Theme
                                                      .of(context)
                                                      .hintColor,
                                                  fontSize: Dimensions
                                                      .fontSizeLarge),
                                            ),
                                          ],
                                        )))
                                    : Text(
                                  "Sorry Our Service is not enable in your location",
                                  style: robotoBlack.copyWith(
                                      color: Theme
                                          .of(context)
                                          .errorColor,
                                      fontSize:
                                      Dimensions.fontSizeLarge),
                                ),
                              ],
                            ))
                            : SizedBox.shrink(),
                      ],
                    ))));
      }),
    );
  }
}
