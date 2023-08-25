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
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';
import '../../base/paginated_list_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class SecurityOfficerChatScreen extends StatefulWidget {
  final String incidence_id;

  SecurityOfficerChatScreen({@required this.incidence_id});

  @override
  State<SecurityOfficerChatScreen> createState() =>
      _SecurityOfficerChatScreenState();
}

class _SecurityOfficerChatScreenState extends State<SecurityOfficerChatScreen>
    with TickerProviderStateMixin {
  ScrollController _scrollController;
  final TextEditingController _firstNameController = TextEditingController();

  void _loadData() async {
    Get.find<HomeController>()
        .getSecurityOfficerCommentList(widget.incidence_id);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en', timeago.EnMessages());
    final ScrollController scrollController = ScrollController();
    return GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        appBar: InnerCustomAppBar(
          title: 'Security Officer Chat'.tr,
          leadingIcon: Images.circle_arrow_back,
          backButton: !ResponsiveHelper.isDesktop(context),
        ),
       /* endDrawer: MenuDrawer(),*/
        body: Get.find<AuthController>().isLoggedIn()
            ? homeController.securitycommentList != null
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    child: Stack(
                      children: [
                        ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              homeController.securitycommentList.docs.length,
                          padding: EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          physics: AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.only(
                                    top: Dimensions.PADDING_SIZE_LARGE),
                                padding: EdgeInsets.all(
                                     Dimensions.PADDING_SIZE_SMALL),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        /* SvgPicture.asset(Images.circle_user),*/

                                        ClipOval(
                                            child: CustomImage(
                                          image: homeController
                                              .securitycommentList
                                              .docs[index]
                                              .user
                                              .image,
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                        )),
                                        SizedBox(
                                          width: Dimensions.PADDING_SIZE_SMALL,
                                        ),
                                        Text(
                                          homeController.securitycommentList
                                                  .docs[index].user.name.first +
                                              " " +
                                              homeController.securitycommentList
                                                  .docs[index].user.name.last,
                                          style: robotoBold.copyWith(
                                              color:
                                                  Theme.of(context).hintColor),
                                        ),
                                        SizedBox(
                                          width: Dimensions.PADDING_SIZE_SMALL,
                                        ),
                                        Text(
                                          timeago.format(
                                              DateTime.parse(homeController
                                                  .securitycommentList
                                                  .docs[index]
                                                  .createdAt),
                                              locale: 'en'),
                                          style: robotoBold.copyWith(
                                              color: Theme.of(context)
                                                  .hintColor
                                                  .withOpacity(0.3)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        homeController.securitycommentList
                                            .docs[index].text,
                                        style: robotoMedium.copyWith(
                                            color: Theme.of(context).hintColor,
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        ),
                        Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                  left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              margin: EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35)),
                                  border: Border.all(
                                      width: 0.5,
                                      color: Theme.of(context).hintColor),
                                  color: Theme.of(context).cardColor),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: CustomTextField(
                                      hintText: 'Text here ……'.tr,
                                      controller: _firstNameController,
                                      inputType: TextInputType.multiline,
                                      prefixIcon: null,
                                      inputAction: TextInputAction.done,
                                      divider: false,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: InkWell(
                                          onTap: () {
                                            String _firstName =
                                                _firstNameController.text;
                                            if (_firstName.isEmpty) {
                                              showCustomSnackBar(
                                                  'enter_your_first_name'.tr);
                                            } else {
                                              homeController
                                                  .addIncidenceComment(
                                                      widget.incidence_id,
                                                      _firstName)
                                                  .then((status) async {
                                                if (status.statusCode == 200) {
                                                  _firstNameController.text="";
                                                  homeController
                                                      .getSecurityOfficerCommentList(widget.incidence_id);
                                                }
                                              });
                                              _scrollController.animateTo(
                                                _scrollController
                                                    .position.maxScrollExtent,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                // Adjust the duration as needed
                                                curve: Curves.easeOut,
                                              );
                                            }
                                          },
                                          child: SvgPicture.asset(
                                              Images.send_chat)))
                                ],
                              ),
                            )),
                      ],
                    ))
                : Center(child: CircularProgressIndicator())
            : NotLoggedInScreen(),
      );
    });
  }
}
