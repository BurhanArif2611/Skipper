import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sixam_mart/controller/home_controller.dart';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/view/screens/home/widget/featured_match_card.dart';
import 'package:sixam_mart/view/screens/home/widget/team_card.dart';

import 'package:timeago/timeago.dart' as timeago;
import '../../../helper/route_helper.dart';
import '../../base/no_data_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController scrollController = ScrollController();
  int seconds = 5; // Initial countdown time

  double latitude;
  double longitude;

  void _loadData() async {
    await Get.find<HomeController>().getUserData();

    await Get.find<HomeController>().getMatchesList();
    await Get.find<HomeController>().getMyMatchesLiveList("");
    // await Get.find<HomeController>().getBannerList();
    // await Get.find<HomeController>().getFeaturedMatchesList();

    /*  if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<NotificationController>().getNotificationList(1, true);
    }*/
  }

  @override
  void initState() {
    super.initState();
    _loadData();
   // timeFormatLoop();
  }
  void timeFormatLoop() async {
    Timer _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
      await Get.find<HomeController>().getMatchesList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  Future<void> _refreshItems() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate delay
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: GetBuilder<HomeController>(builder: (homeController) {
        return homeController != null && !homeController.isLoading
            ? homeController.matchlist != null &&
                    homeController.matchlist?.data != null
                ? RefreshIndicator(
                    onRefresh: _refreshItems,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      // Ensures scrollable behavior
                      children: [
                        Container(
                          color: Theme.of(context).backgroundColor,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_LARGE),
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                          SvgPicture.asset(Images.logo_white),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getNotificationRoute());
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: SvgPicture.asset(
                                          Images.notification,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (homeController.featuredMatchesList != null &&
                                  homeController
                                          .featuredMatchesList.data?.matches !=
                                      null &&
                                  homeController.featuredMatchesList.data
                                      .matches.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Featured Matches",
                                      style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraSingleLarge,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Container(
                                      height: 190,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        controller: _scrollController,
                                        itemCount: homeController
                                            .featuredMatchesList
                                            .data
                                            .matches
                                            .length,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL,
                                          vertical:
                                              Dimensions.PADDING_SIZE_SMALL,
                                        ),
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return FeaturedMatchCardItem(
                                            homeController.featuredMatchesList
                                                .data.matches[index],
                                            index
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 20),
                              if (homeController.liveMatchesList != null && homeController.liveMatchesList.length>0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Live Matches",
                                      style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraSingleLarge,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),

                                    Container(
                                        height: 240,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          controller: _scrollController,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL,
                                            vertical:
                                                Dimensions.PADDING_SIZE_SMALL,
                                          ),
                                          itemCount: homeController
                                              .liveMatchesList.length,
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return FeaturedMatchCardItem(
                                                homeController
                                                    .liveMatchesList[index],index);
                                          },
                                        )),
                                  ],
                                ),

                              if (homeController.liveMatchesList != null &&  homeController.liveMatchesList.length>0)
                                SizedBox(height: 20),

                              if (homeController.upcomingList != null && homeController.upcomingList.length>0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upcoming Matches",
                                      style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraSingleLarge,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      controller: _scrollController,
                                      itemCount:
                                          homeController.upcomingList.length,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return TeamCardItem(
                                            homeController.upcomingList[index],
                                            true,true);
                                      },
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: NoDataScreen(text: 'No Data Found'))
            : Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  List<Widget> imageSliders = [];

  @override
  void initState() {
    super.initState();
    //  _initializeImageSliders();
  }

  void _initializeImageSliders() {
    final bannerList = Get.find<HomeController>().bannerList.data;

    setState(() {
      imageSliders = bannerList.map((item) {
        return Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
          ),
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
            child: Stack(
              children: <Widget>[
                getImageWidget(item.banner, item.bannerName),
              ],
            ),
          ),
        );
      }).toList();
    });
  }

  Future<File> base64ToFile(String base64String, String fileName) async {
    try {
      // Decode Base64 string
      final decodedBytes = base64Decode(base64String);

      // Get the application's directory
      final directory = await getApplicationDocumentsDirectory();

      // Create the file path with the desired name
      final filePath = '${directory.path}/$fileName';

      // Write the decoded bytes to the file
      final file = File(filePath);
      await file.writeAsBytes(decodedBytes);

      return file; // Return the file for further use
    } catch (e) {
      throw Exception('Error converting Base64 to file: $e');
    }
  }

  Future<String> getFilePath(String value, String bannerName) async {
    // Example Base64 string
    String base64String = "data:image/jpeg;base64,$value";

    // Extract MIME type and remove the prefix
    String mimeType =
        base64String.split(";")[0].split(":")[1]; // e.g., "image/jpeg"

    // Map MIME type to file extension
    Map<String, String> mimeToExtension = {
      "image/jpeg": "jpeg",
      "image/png": "png",
      "image/gif": "gif",
    };

    String fileExtension = mimeToExtension[mimeType] ?? "unknown";

    // Remove the Base64 prefix (if present)
    base64String = base64String.split(",")[1];

    // Save the image
    final fileName = "vishal.$fileExtension";
    File file = await base64ToFile(base64String, bannerName);

    print("Image saved at: ${file.path}");
    return file.path;
  }

  Widget getImageWidget(String base64String, String bannerName) {
    // debugPrint("getImageWidget>>"+base64String);
    try {
      //  try {
      /* getFilePath(base64String);
      String sanitizedString = base64String.trim();
      Uint8List imageBytes = base64Decode(sanitizedString);
*/
      Future<String> path = getFilePath(base64String, bannerName);
      debugPrint("getImageWidget>>" + path.toString());
      return Image.file(
        File('/data/user/0/com.skipper.android/app_flutter/vishal.jpeg'),
        fit: BoxFit.cover,
      );
    } catch (e) {
      return Image.asset(Images.no_data_found);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<HomeController>(builder: (homeController) {
      return homeController.bannerList != null
          ? Column(children: [
              Expanded(
                child: CarouselSlider(
                  items: imageSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    homeController.bannerList.data.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ])
          : SizedBox.shrink();
    }));
  }
}
