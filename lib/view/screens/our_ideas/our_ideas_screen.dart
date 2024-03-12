import 'dart:async';


import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';



class OurIdeasScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {}

  @override
  State<OurIdeasScreen> createState() => _OurIdeasScreenState();
}

class _OurIdeasScreenState extends State<OurIdeasScreen> {
  final ScrollController _scrollController = ScrollController();




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


    return Scaffold(
        body: Scrollbar(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                    children: [

                      Text("national_program".tr,style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeExtraLarge),),
                      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),

                      Text("national_program_detail".tr,textAlign: TextAlign.center,
                        style: robotoBold.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeExtraSmall),),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).disabledColor),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions
                                  .PADDING_SIZE_SMALL), // Set the radius here
                              child: Image.asset(
                                Images.political_event,
                                // Replace with your image URL or asset path
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width of the image
                                height: 400, // Set the height of the image
                                fit: BoxFit
                                    .cover, // Set the image fit (you can choose BoxFit.fill, BoxFit.fitWidth, etc.)
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "political_program".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).disabledColor),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions
                                  .PADDING_SIZE_SMALL), // Set the radius here
                              child: Image.asset(
                                Images.economic_programme,
                                // Replace with your image URL or asset path
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width of the image
                                height: 400, // Set the height of the image
                                fit: BoxFit
                                    .cover, // Set the image fit (you can choose BoxFit.fill, BoxFit.fitWidth, etc.)
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "political_program".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).disabledColor),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions
                                  .PADDING_SIZE_SMALL), // Set the radius here
                              child: Image.asset(
                                Images.social_programme,
                                // Replace with your image URL or asset path
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width of the image
                                height: 400, // Set the height of the image
                                fit: BoxFit
                                    .cover, // Set the image fit (you can choose BoxFit.fill, BoxFit.fitWidth, etc.)
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "social_Programme".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.PADDING_SIZE_SMALL),
                          border: Border.all(
                              width: 1, color: Theme.of(context).disabledColor),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions
                                  .PADDING_SIZE_SMALL), // Set the radius here
                              child: Image.asset(
                                Images.culture_programme,
                                // Replace with your image URL or asset path
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width of the image
                                height: 400, // Set the height of the image
                                fit: BoxFit
                                    .cover, // Set the image fit (you can choose BoxFit.fill, BoxFit.fitWidth, etc.)
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            Text(
                              "culture_Programme".tr,
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            SizedBox(
                              height: Dimensions.PADDING_SIZE_SMALL,
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.PADDING_SIZE_DEFAULT,
                      ),


                    ],
                  ),
                ))));
  }
}


