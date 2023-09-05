import 'package:flutter_svg/flutter_svg.dart';
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
import '../../../controller/home_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/paginated_list_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class IncidencesScreen extends StatefulWidget {
  @override
  State<IncidencesScreen> createState() => _IncidencesScreenState();
}

class _IncidencesScreenState extends State<IncidencesScreen> {
  void _loadData() async {
    await Get.find<HomeController>().getIncidenceList();
  }

  @override
  void initState() {
    super.initState();

   // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar:  InnerCustomAppBar(
          title: 'Incidences'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
          onBackPressed: () {
            Get.find<DashboardController>().changeIndex(0);
          }),
     /* endDrawer: MenuDrawer(),*/
      body: RefreshIndicator(
        onRefresh: () async {
      _loadData();
    },
    child: NotificationListener<OverscrollIndicatorNotification>(
    onNotification: (OverscrollIndicatorNotification overscroll) {
    overscroll.disallowGlow();
    return;
    },
    child:

      Get.find<AuthController>().isLoggedIn()
          ? GetBuilder<HomeController>(
          builder: (onBoardingController) =>
          onBoardingController.incidenceListModel!=null &&  onBoardingController.incidenceListModel.docs!=null &&  onBoardingController.incidenceListModel.docs.length>0 ?
          Container(child: ListView.builder(
             itemCount: onBoardingController.incidenceListModel.docs.length,
             padding: EdgeInsets.only(
                 left: Dimensions.PADDING_SIZE_SMALL),
             /* physics: BouncingScrollPhysics(),*/
             scrollDirection: Axis.vertical,
             itemBuilder: (context, index) {
               return
                 InkWell(
                   onTap: () { Get.toNamed(RouteHelper.getIncidenceDetailScreen(onBoardingController.incidenceListModel.docs[index].sId));},
               child:
                 Container(
                   padding: EdgeInsets.all(
                       Dimensions.PADDING_SIZE_DEFAULT),
                   margin: EdgeInsets.all(
                      Dimensions
                           .PADDING_SIZE_EXTRA_SMALL),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5.0),
                     border: Border.all(
                         width: 1,
                         color:
                         Theme.of(context).disabledColor),
                   ),
                   child: Column(
                       mainAxisAlignment:
                       MainAxisAlignment.start,
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         /*Image.asset(
                           Images.homepagetopslider,
                           height:
                           150 *//*context.height * 0.3*//*,
                           width: MediaQuery.of(context)
                               .size
                               .width,
                           fit: BoxFit.fill,
                         ),*/
                       Container(
                       height: 150,
                       width: MediaQuery.of(context).size.width,
                       child:
                         (onBoardingController.incidenceListModel.docs[index].images!=null && onBoardingController.incidenceListModel.docs[index].images.length>0?
                         CustomImage(
                           fit: BoxFit.fitWidth,
                           height:
                           150,
                           image: onBoardingController.incidenceListModel.docs[index].images[0],
                         ):Image.asset(
                           Images.no_data_found,
                           width: MediaQuery.of(context).size.height*0.15, height: 150,
                         ))),
                         SizedBox(
                             height: Dimensions
                                 .PADDING_SIZE_EXTRA_SMALL),
                         Align(
                           alignment: Alignment.centerLeft,
                           child: Text(onBoardingController.incidenceListModel.docs[index].incidentType!=null?
                             onBoardingController.incidenceListModel.docs[index].incidentType.name:"",
                             style: robotoBold.copyWith(
                                 fontSize: Dimensions
                                     .fontSizeDefault /*context.height*0.022*/),
                             textAlign: TextAlign.start,
                           ),
                         ),
                         SizedBox(
                             height: Dimensions
                                 .PADDING_SIZE_EXTRA_SMALL),
                   Align(
                       alignment: Alignment.centerLeft,
                       child: Text(
                           onBoardingController.incidenceListModel.docs[index].shortDescription,
                           style: robotoRegular.copyWith(
                               fontSize: Dimensions
                                   .fontSizeDefault /*context.height*0.015*/,
                               color: Theme.of(context)
                                   .hintColor),
                           textAlign: TextAlign.start,
                         )),
                         SizedBox(
                             height: Dimensions
                                 .PADDING_SIZE_EXTRA_SMALL),
                         Row(
                           children: [
                             (onBoardingController.incidenceListModel.docs[index].user!=null && onBoardingController.incidenceListModel.docs[index].user.name!=null?
                             Expanded(
                               flex: 2,
                               child: Row(children: [
                                 Text("By :",
                                     style: robotoMedium.copyWith(
                                         color:
                                         Theme.of(context)
                                             .hintColor,
                                         fontSize: Dimensions
                                             .fontSizeDefault)),
                                 Text(onBoardingController.incidenceListModel.docs[index].user.name.first,
                                     style: robotoBold.copyWith(
                                         color:
                                         Theme.of(context)
                                             .hintColor,
                                         fontSize: Dimensions
                                             .fontSizeDefault))
                               ]),
                             ):SizedBox()),
                             Expanded(
                                 flex: 1,
                                 child: Text(
                                   timeago.format(DateTime.parse(onBoardingController.incidenceListModel.docs[index].createdAt), locale: 'en'),
                                   textAlign: TextAlign.right,
                                 )),
                           ],
                         ),
                       ]),
                 ));
             },
           ),):SizedBox()


      )
          : NotLoggedInScreen()),),

      floatingActionButton: Container(
          width: MediaQuery.of(context).size.width, // Set the desired width here
          height: 45,
          margin: EdgeInsets.only(left:Dimensions.PADDING_SIZE_EXTRA_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            border: Border.all(
                width: 1,
                color: Theme.of(context).disabledColor),
            color: Theme.of(context).primaryColor,
          ),
          alignment: Alignment.center,// Set the desired height here
          child:
    InkWell(
    onTap: () { Get.toNamed(RouteHelper.getReportIncidenceScreen());},
    child:
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SvgPicture.asset(Images.plus,color: Theme.of(context).cardColor,),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
            Text("Report Incidence",style: robotoBold.copyWith(color: Theme.of(context).cardColor))
          ],)),

      ),
    );
  }
}
