import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/home_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/no_data_screen.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/screens/incidences/widget/comments.dart';
import 'package:sixam_mart/view/screens/incidences/widget/description.dart';
import 'package:sixam_mart/view/screens/notification/widget/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/custom_image.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/paginated_list_view.dart';

class IncidenceDetailScreen extends StatefulWidget {
  final String incidence_id;

  IncidenceDetailScreen({@required this.incidence_id});

  @override
  State<IncidenceDetailScreen> createState() => _IncidenceDetailScreenState();
}

class _IncidenceDetailScreenState extends State<IncidenceDetailScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  TabController _tabController;
  bool securityOfficer = false;

  void _loadData() async {
    Get.find<HomeController>().getIncidenceDetail(widget.incidence_id);
    Get.find<HomeController>().getCommentList(widget.incidence_id);

    Get.find<HomeController>().getCommentList(widget.incidence_id);
    securityOfficer = Get.find<SplashController>().isSecurityOfficer;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        appBar: InnerCustomAppBar(
          title: 'Incidence'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
        ),
       /* endDrawer: MenuDrawer(),*/
        body: Get.find<AuthController>().isLoggedIn() ?
                homeController.incidenceDetailResponse != null
            ?
        SingleChildScrollView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Theme.of(context).cardColor.withOpacity(0.5),
                      child: Stack(children: [
                        /*Image.asset(
                        Images.homepagetopslider,
                        height: 220 */ /*context.height * 0.3*/ /*,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),*/
                        Container(
                          height: 240,
                          child: Stack(
                            children: [
                              Expanded(
                                  child: PageView.builder(
                                itemCount: homeController
                                    .incidenceDetailResponse.images.length,
                                controller: _pageController,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  print("imahe URL>>> ${homeController
                                      .incidenceDetailResponse
                                      .images[index]}");
                                  return
                                    InkWell(
                                      onTap: (){

                                      Get.toNamed(
                                          RouteHelper.getItemImagesRoute(
                                              homeController
                                                  .incidenceDetailResponse));

                                  },
                                  child:
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.all(
                                                context.height * 0.05),
                                            child: CustomImage(
                                              fit: BoxFit.fitWidth,
                                              image: homeController
                                                  .incidenceDetailResponse
                                                  .images[index],
                                            )),
                                      ]));
                                },
                                onPageChanged: (index) {
                                  homeController.changeSelectIndex(index);
                                },
                              )),
                              Positioned(
                                  bottom: 60,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _pageIndicators(
                                        homeController, context),
                                  ))
                            ],
                          ),
                        ),
                        Positioned.fill(
                            top: 180,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_SMALL),
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context).disabledColor),
                                  color: Theme.of(context).cardColor),
                              child: SingleChildScrollView(
                                  controller: scrollController,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width: 50,
                                                    padding: EdgeInsets.all(
                                                        Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Theme.of(
                                                                    context)
                                                                .cardColor),
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        homeController
                                                            .incidenceDetailResponse
                                                            .incidentType
                                                            .name,
                                                        style: robotoMedium
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .cardColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 3,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      SvgPicture.asset(
                                                          Images.calendar),
                                                      SizedBox(
                                                          width: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      Text(
                                                          DateConverter.getDate(
                                                              homeController
                                                                  .incidenceDetailResponse
                                                                  .createdAt),
                                                          style: robotoMedium.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor,
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall)),
                                                      SizedBox(
                                                          width: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      SizedBox(
                                                          width: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      SvgPicture.asset(
                                                          Images.clock),
                                                      SizedBox(
                                                          width: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      Text(
                                                          DateConverter.getTime(
                                                              homeController
                                                                  .incidenceDetailResponse
                                                                  .createdAt),
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: robotoMedium.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor,
                                                              fontSize: Dimensions
                                                                  .fontSizeSmall)),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              homeController
                                                  .incidenceDetailResponse
                                                  .shortDescription,
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraLarge,
                                                  color: Theme.of(context)
                                                      .hintColor),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          Row(children: [
                                            Text("By :",
                                                style: robotoMedium.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                    fontSize: Dimensions
                                                        .fontSizeDefault)),
                                            ( homeController
                                                .incidenceDetailResponse
                                                .user!=null &&  homeController
                                                .incidenceDetailResponse
                                                .user.name!=null?
                                            Text(
                                                homeController
                                                        .incidenceDetailResponse
                                                        .user
                                                        .name
                                                        .first +
                                                    " " +
                                                    homeController
                                                        .incidenceDetailResponse
                                                        .user
                                                        .name
                                                        .last,
                                                style: robotoBold.copyWith(
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                    fontSize: Dimensions
                                                        .fontSizeDefault)):SizedBox())
                                          ]),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          Divider(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL,
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(0.3),
                                          ),
                                          Container(
                                            width: Dimensions.WEB_MAX_WIDTH,
                                            color: Theme.of(context).cardColor,
                                            child: TabBar(
                                              controller: _tabController,
                                              indicatorColor: Theme.of(context)
                                                  .primaryColor,
                                              indicatorWeight: 3,
                                              isScrollable: false,
                                              labelColor: Theme.of(context)
                                                  .primaryColor,
                                              physics: ScrollPhysics(),
                                              unselectedLabelColor:
                                                  Theme.of(context).hintColor,
                                              unselectedLabelStyle:
                                                  robotoRegular.copyWith(
                                                      color: Theme.of(context)
                                                          .disabledColor,
                                                      fontSize: Dimensions
                                                          .fontSizeSmall),
                                              labelStyle: robotoBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                              tabs: [
                                                Tab(text: 'Description'.tr),
                                                Tab(text: 'Comments'),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          Container(
                                            height: 450,
                                            child: TabBarView(
                                              controller: _tabController,
                                              children: [
                                                Description(isItem: false),
                                                Comments(
                                                    isItem: true,
                                                    homeController:
                                                        homeController,
                                                    incidence_id:
                                                        widget.incidence_id),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ))),

                              /*  Expanded(
                                child:
                                 TabBarView(
                                    controller: _tabController,
                                    children: [
                                      Description(isItem: false),
                                      Comments(isItem: true),
                                    ],
                                  ),
                                ),*/
                            )),
                      ]),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  ],
                )):Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,))
            : NotLoggedInScreen(),
        floatingActionButton: securityOfficer
            ? Container(
                width: 75, // Set the desired width here
                height: 75, // Set the desired height here
                child: FloatingActionButton(
                  onPressed: () {
                    // Add the action you want to perform when the FAB is pressed
                    // For example, navigate to another page or show a dialog.
                    Get.toNamed(RouteHelper.getSecurityOfficerCHatScreenRoute(
                        widget.incidence_id));
                  },
                  child: Icon(
                    Icons.comment,
                    color: Theme.of(context).cardColor,
                  ) /*Icon(Icons.add)*/,
                  backgroundColor: Theme.of(context).primaryColor,
                  // Set the FAB's background color
                ))
            : SizedBox(),
      );
    });
  }

  List<Widget> _pageIndicators(
      HomeController onBoardingController, BuildContext context) {
    List<Container> _indicators = [];

    for (int i = 0;
        i < onBoardingController.incidenceDetailResponse.images.length;
        i++) {
      _indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: i == onBoardingController.selectedIndex
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor,
            borderRadius: i == onBoardingController.selectedIndex
                ? BorderRadius.circular(50)
                : BorderRadius.circular(25),
          ),
        ),
      );
    }
    return _indicators;
  }
}
