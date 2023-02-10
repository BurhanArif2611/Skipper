import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/parcel_controller.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/screens/address/widget/address_widget.dart';

import '../../../../util/styles.dart';

class AddressDialog extends StatelessWidget {
  final Function(AddressModel address) onTap;
  final Function(int index) index1;

  const AddressDialog({@required this.onTap,@required this.index1});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        width: context.width * 0.8, height: context.height * 0.7,
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(children: [
        Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

              Text("Saved addresses from "+
                Get.find<LocationController>().getUserAddress().address.tr+" regions",
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
              ),
            ]),
          ),
          Align(alignment: Alignment.topRight, child: IconButton(icon: Icon(Icons.clear), onPressed: () => Get.back())),
        ]),
          Expanded(
            child: Scrollbar(
              child: GetBuilder<LocationController>(builder: (locationController) {
                // List<AddressModel> _addressList = [];
                // if(locationController.addressList != null) {
                //   for(int index=0; index<locationController.addressList.length; index++) {
                //     if(locationController.getUserAddress().zoneIds.contains(locationController.addressList[index].zoneId)) {
                //       _addressList.add(locationController.addressList);
                //     }
                //   }
                // }
                return Get.find<AuthController>().isLoggedIn() ? locationController.addressList != null ? locationController.addressList.length > 0 && locationController.getUserAddress().zoneIds!=null ? ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  itemCount: locationController.addressList.length,
                  itemBuilder: (context, index) {
                    if(locationController.getUserAddress().zoneIds!=null && locationController.getUserAddress().zoneIds.contains(locationController.addressList[index].zoneId)) {
                      return Center(child: SizedBox(width: 700, child: AddressWidget(
                        address: locationController.addressList[index],
                        fromAddress: false,
                        onTap: () {
                          onTap(locationController.addressList[index]);

                          AddressModel _address = AddressModel(
                            address: locationController.addressList[index].address,
                            additionalAddress: locationController.addressList[index].additionalAddress,
                            addressType: locationController.addressList[index].addressType,
                            contactPersonName: locationController.addressList[index].contactPersonName,
                            contactPersonNumber: locationController.addressList[index].contactPersonNumber,
                            latitude: locationController.addressList[index].latitude,
                            longitude: locationController.addressList[index].longitude,
                            method: locationController.addressList[index].method,
                            zoneId: locationController.addressList[index].zoneId,
                            id: locationController.addressList[index].id,
                          );
                          if(Get.find<ParcelController>().isSender){
                            Get.find<ParcelController>().setPickupAddress(_address, true);
                            Get.back();
                          }else{
                            Get.find<ParcelController>().setDestinationAddress(_address,false);
                            Get.back();
                          }
                          try{
                          index1(index);}catch(e){}
                        },
                      )));
                    }else {
                      return Center(child: NoDataScreen(text: 'no_saved_address_found'.tr));

                    }
                  },
                ) : NoDataScreen(text: 'no_saved_address_found'.tr) : Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(child: CircularProgressIndicator()),
                ) : SizedBox();
              }),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
