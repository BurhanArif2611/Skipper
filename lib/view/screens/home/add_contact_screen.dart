import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/dashboard_controller.dart';
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
import '../../../controller/home_controller.dart';
import '../../../controller/store_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../helper/responsive_helper.dart';
import '../../../helper/route_helper.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_snackbar.dart';
import '../../base/custom_text_field.dart';
import '../../base/inner_custom_app_bar.dart';


class AddContactScreen extends StatefulWidget {
  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _relationFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: InnerCustomAppBar(
        title: 'Add Contact'.tr,
        leadingIcon: Images.circle_arrow_back,
        backButton: !ResponsiveHelper.isDesktop(context),
      ),
      endDrawer: MenuDrawer(),
      body: Get.find<AuthController>().isLoggedIn()
          ? Scrollbar(
          child: SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                margin: EdgeInsets.all(Dimensions.RADIUS_DEFAULT),
                child: Center(
                  child: Column(children: [
                    SizedBox(
                      height: Dimensions.RADIUS_LARGE,
                    ),

                    CustomTextField(
                      hintText: 'Enter Name'.tr,
                       controller: _firstNameController,
                      focusNode: _firstNameFocus,
                      nextFocus: _relationFocus,
                      inputType: TextInputType.name,
                      inputAction:TextInputAction.next,
                      capitalization: TextCapitalization.words,
                      prefixIcon: Images.user,
                      divider: false,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                    CustomTextField(
                      hintText: 'Select Relation'.tr,
                       controller: _relationController,
                      focusNode: _relationFocus,
                      nextFocus: _phoneFocus,
                      inputType: TextInputType.name,
                      inputAction:TextInputAction.next,
                      capitalization: TextCapitalization.words,
                      prefixIcon: Images.user,
                      divider: false,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                    CustomTextField(
                      hintText: '+234 12345 78945'.tr,
                       controller: _phoneController,
                      focusNode: _phoneFocus,
                      inputType: TextInputType.phone,
                        inputAction:TextInputAction.done,
                      prefixIcon: Images.call,
                      divider: false,
                      maxLength: 10,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),


                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Spacer(),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          buttonText: 'Save Contact'.tr,

                          onPressed:  (){
                            _addSaveContact();
                          },
                        ),
                      ),
                    ),






                  ]),
                ),
              )))
          : NotLoggedInScreen(),
    );
  }
  void _addSaveContact() async {
    String _firstName = _firstNameController.text.toString();
    String _relation = _relationController.text.toString();
    String _number = _phoneController.text.trim();

    if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    }  else if (_relation.isEmpty) {
      showCustomSnackBar('Enter relation'.tr);
    } else if (_number.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    }
     else {
      await Get.find<HomeController>().addSOSContact(_firstName,_relation,_number).then((status) async {
        if (status.statusCode == 200) {
          Get.back();
          showCustomSnackBar("Contact Added Successfully");

        } else {
          showCustomSnackBar(status.body["message"]);
        }
      });
    }
  }
}
