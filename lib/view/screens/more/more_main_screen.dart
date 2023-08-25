import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/screens/notification/widget/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/dashboard_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/paginated_list_view.dart';

class MoreMainScreen extends StatefulWidget {
  @override
  State<MoreMainScreen> createState() => _MoreMainScreenState();
}

class _MoreMainScreenState extends State<MoreMainScreen> {


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
          title: 'More'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
          onBackPressed: () {
            print("skldksjd");
            Get.find<DashboardController>().changeIndex(0);
          }),
     /* endDrawer: MenuDrawer(),*/
      body: SingleChildScrollView(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            /* color: Colors.red,*/
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child:
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),

                      child:InkWell(
                        onTap: () { Get.toNamed(RouteHelper.getMyprofileScreen());},
                        child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Images.my_profile,color: Theme.of(context).primaryColor),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          Text("My Profile",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)
                        ],
                      )),
                    )),
                   SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                    Expanded(
                        flex: 1,
                        child:
                        InkWell(
                            onTap: () { Get.toNamed(RouteHelper.getTopNewsScreen());},
                            child:
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                          child:Center(child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images.incidence_icon,color: Theme.of(context).primaryColor),
                              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                              Text("Incidences",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)
                            ],
                          ),),
                        ))
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child:
                        InkWell(
                            onTap: () { Get.toNamed(RouteHelper.getTopNewsScreen());},
                            child:
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                      child: Column( mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Images.latest_news,color: Theme.of(context).primaryColor),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          Text("Latest New",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)
                        ],
                      ),
                    ))

                    ),
                   SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getSurveyScreen());
                            },
                            child:
                            Container(
                          height: 120,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                          child: Column( mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images.survay_icon,color: Theme.of(context).primaryColor),
                              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                              Text("Survey",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)
                            ],
                          ),
                        ))),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child:
                        InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getResourceCenterRoute());
                            },
                            child:
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                      child: Column( mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Images.resource_center,color: Theme.of(context).primaryColor,),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          Text("Resource Center",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)
                        ],
                      ),
                    ))
                    ),
                   SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

                   /* Get.toNamed(RouteHelper.getSOSCOntactRoute());*/
                    Expanded(
                        flex: 1,
                        child:
                        InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getSOSCOntactRoute());
                              },
                            child:
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                          child: Column( mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images.sos_icon,height: 50,color: Theme.of(context).primaryColor),
                              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                              Text("SOS contacts",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)
                            ],
                          ),
                        ))),
                  ],
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                        child:
                        InkWell(
                            onTap: () {
                              Get.toNamed(RouteHelper.getContactCenterRoute());
                            },
                            child:
                        Container(
                          height: 120,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                width: 1,
                                color: Theme.of(context).disabledColor),
                            color: Colors.transparent,
                          ),
                      child: Column( mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Images.contact_center,color: Theme.of(context).primaryColor),
                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          Text("Contact Center",style: robotoBold.copyWith(color: Theme.of(context).primaryColor,fontSize: Dimensions.fontSizeLarge),)
                        ],
                      ),
                    ))
                    ),
                   SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                    Expanded(
                        flex: 1,
                        child: Text("")),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
