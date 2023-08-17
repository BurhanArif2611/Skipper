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

class SelectCountryScreen extends StatefulWidget {
  final String state_id;

  SelectCountryScreen({@required this.state_id});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  void _loadData() async {
    print("object>>>>>${widget.state_id.toString()}");
    if (widget.state_id == "State") {
      Get.find<HomeController>().getStateList();
    } else if (widget.state_id == "lga") {
      Get.find<HomeController>()
          .getLgaList(Get.find<HomeController>().state_id);
    } else if (widget.state_id == "ward") {
      Get.find<HomeController>()
          .getWardList(Get.find<HomeController>().lga_id);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
        title: widget.state_id == "State"
            ? 'Select State'.tr
            : widget.state_id == "lga"
                ? "Select Lga"
                : widget.state_id == "ward"
                    ? "Select Ward"
                    : "",
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
      endDrawer: MenuDrawer(),
      body: Get.find<AuthController>().isLoggedIn()
          ? GetBuilder<HomeController>(
              builder: (homeController) => (homeController.countryList !=
                          null &&
                      homeController.countryList.length > 0)
                  ? Container(
                      child: ListView.builder(
                        itemCount: homeController.countryList.length,
                        padding: EdgeInsets.only(
                            left: Dimensions.PADDING_SIZE_SMALL),
                        /* physics: BouncingScrollPhysics(),*/
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                if (widget.state_id == "State") {
                                  homeController.selectState(
                                      homeController.countryList[index].sId,
                                      homeController.countryList[index].name);
                                }else if (widget.state_id == "lga") {
                                  homeController.selectLga(
                                      homeController.countryList[index].sId,
                                      homeController.countryList[index].name);
                                }else if (widget.state_id == "ward") {
                                  homeController.selectWard(
                                      homeController.countryList[index].sId,
                                      homeController.countryList[index].name);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                margin: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          homeController.countryList[index]
                                                      .name !=
                                                  null
                                              ? homeController
                                                  .countryList[index].name
                                              : "",
                                          style: robotoBold.copyWith(
                                              fontSize: Dimensions
                                                  .fontSizeDefault /*context.height*0.022*/),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Divider(
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ]),
                              ));
                        },
                      ),
                    )
                  : NoDataScreen(
                      text: widget.state_id == "State"
                          ? ' State Not Found!'.tr
                          : widget.state_id == "lga"
                              ? " Lga Not Found!"
                              : widget.state_id == "ward"
                                  ? " Ward Not Found!"
                                  : ""))
          : NotLoggedInScreen(),
    );
  }
}
