import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/controller/onboarding_controller.dart';
import 'package:sixam_mart/util/images.dart';

import '../../controller/home_controller.dart';
import '../../data/model/body/country_flag.dart';
import '../../util/dimensions.dart';

class CountryFlagImage extends StatelessWidget {

  String code;

  CountryFlagImage(this.code);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (homeController)
    {
      return
        FutureBuilder<CountryFlag>(
          future: homeController
              .getCountryFlagByCode("code"),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData ||
                snapshot.data == null) {
              return  Container(
                  width: 60.0,
                  // Slightly larger to accommodate the border
                  height: 60.0,
                  padding: EdgeInsets.all(
                      Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),

                  ),
                  child:
                  Image.asset(
                    Images.no_data_found,
                    fit: BoxFit.cover, // Specify width
                  ));
            } else {
              final country = snapshot.data;
              return
                Container(
                    width: 60.0,
                    // Slightly larger to accommodate the border
                    height: 60.0,
                    padding: EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),

                    ),
                    child:
                    ClipOval(child:
                    SvgPicture.network(
                      country.image,
                      placeholderBuilder:
                          (BuildContext context) =>
                          CircularProgressIndicator(),
                      fit: BoxFit.cover, // Specify width
                    )));
            }
          },
        );
    });
  }
}