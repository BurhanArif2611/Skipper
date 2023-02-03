import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/parcel_controller.dart';
import 'package:sixam_mart/data/model/response/prediction_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../controller/splash_controller.dart';
import '../../../../util/styles.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController mapController;
  final bool isPickedUp;

  final BuildContext context;
  LocationSearchDialog({@required this.mapController, this.isPickedUp,@required this.context});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      margin: EdgeInsets.only(top: ResponsiveHelper.isWeb() ? 80 : 0),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
        child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child:
    Padding(
    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
    child:
        GooglePlaceAutoCompleteTextField(
            textEditingController: _controller,
            googleAPIKey:
            Get.find<SplashController>().configModel.map_api_key,
            inputDecoration: InputDecoration(
              hintText: 'search_location'.tr,
              hintStyle: robotoRegular.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeDefault),
              border: InputBorder.none,
            ),
            debounceTime: 800,
            // default 600 ms,
            countries: [ "NGA","nga","in"],
            // optional by default null is set
            isLatLngRequired: true,
            // if you required coordinates from place detail
            getPlaceDetailWithLatLng: (Prediction prediction) {
              // this method will return latlng with place detail
              print("placeDetails" + prediction.lng.toString());

              if(isPickedUp == null) {
                Get.find<LocationController>().setLocation(prediction.placeId, prediction.description, mapController);
              }else {
                Get.find<ParcelController>().setLocationFromPlace(prediction.placeId, prediction.description, isPickedUp,context);
              }
              Get.back();
            },
            // this callback is called when isLatLngRequired is true
            itmClick: (Prediction prediction) {
              _controller.text = prediction.description;
              _controller.selection = TextSelection.fromPosition(
                  TextPosition(
                      offset: prediction.description.length));
            })),
        /*TypeAheadField(
          textFieldConfiguration:
          TextFieldConfiguration(
            controller: _controller,
            textInputAction: TextInputAction.search,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              hintText: 'search_location'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(style: BorderStyle.none, width: 0),
              ),
              hintStyle: Theme.of(context).textTheme.headline2.copyWith(
                fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).disabledColor,
              ),
              filled: true, fillColor: Theme.of(context).cardColor,
            ),
            style: Theme.of(context).textTheme.headline2.copyWith(
              color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.fontSizeLarge,
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await Get.find<LocationController>().searchLocation(context, pattern);
          },
          itemBuilder: (context, PredictionModel suggestion) {
            return Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Row(children: [
                Icon(Icons.location_on),
                Expanded(
                  child: Text(suggestion.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.fontSizeLarge,
                  )),
                ),
              ]),
            );
          },
          onSuggestionSelected: (PredictionModel suggestion) {
            if(isPickedUp == null) {
              Get.find<LocationController>().setLocation(suggestion.placeId, suggestion.description, mapController);
            }else {
              Get.find<ParcelController>().setLocationFromPlace(suggestion.placeId, suggestion.description, isPickedUp);
            }
            Get.back();
          },
        )*/
        ),
      ),
    );
  }
}
