import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/parcel_controller.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/task_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/my_text_field.dart';
import 'package:sixam_mart/view/base/text_field_shadow.dart';
import 'package:sixam_mart/view/screens/location/pick_map_screen.dart';
import 'package:sixam_mart/view/screens/location/widget/serach_location_widget.dart';
import 'package:sixam_mart/view/screens/parcel/widget/address_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../controller/location_controller.dart';
import '../../../../controller/splash_controller.dart';
import '../../../../controller/user_controller.dart';
import '../../../../util/images.dart';
import '../../../base/custom_image.dart';
import '../../../base/image_picker_widget.dart';
import '../../../base/squre_image_picker_widget.dart';

class LocationView extends StatefulWidget {
  final bool isSender;

  final Widget bottomButton;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController streetController;
  final TextEditingController houseController;
  final TextEditingController floorController;

  LocationView(
      {Key key,
      @required this.isSender,
      @required this.nameController,
      @required this.phoneController,
      @required this.streetController,
      @required this.houseController,
      @required this.floorController,
      @required this.bottomButton})
      : super(key: key);

  @override
  State<LocationView> createState() => _LocationView();
}

class _LocationView extends State<LocationView> {
  ScrollController scrollController = ScrollController();
  final FocusNode _streetNode = FocusNode();
  final FocusNode _houseNode = FocusNode();
  final FocusNode _floorNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final TextEditingController _notsController = TextEditingController();
  var parcelController_main;
  AddressModel addressModel_ = null;
  List<TaskModel> anotherList = List<TaskModel>();
  TextEditingController main_titleController = TextEditingController();
  TextEditingController main_commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.WEB_MAX_WIDTH,
      child: GetBuilder<ParcelController>(builder: (parcelController) {
        if (parcelController.destinationAddress != null) {
          addressModel_ = parcelController.destinationAddress;
        }
        print("<><><><>" + parcelController.isSender.toString());

        parcelController_main = parcelController;
        return SingleChildScrollView(
          // controller: ScrollController(),
          child: Center(
              child: FooterView(
            child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    SearchLocationWidget(
                      mapController: null,
                      pickedAddress: parcelController.pickupAddress != null
                          ? parcelController.pickupAddress.address
                          : '',
                      isEnabled: false,
                      isPickedUp: true,
                      hint: parcelController.isSender
                          ? 'pick_up'.tr
                          : 'destination'.tr,
                      context: context,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Row(children: [
                      Expanded(
                        flex: 4,
                        child: CustomButton(
                            buttonText: 'set_from_map'.tr,
                            onPressed: () => {
                                  Get.toNamed(
                                      RouteHelper.getPickMapRoute(
                                          'parcel', false),
                                      arguments: PickMapScreen(
                                        fromSignUp: false,
                                        fromAddAddress: false,
                                        canRoute: false,
                                        route: '',
                                        onPicked: (AddressModel address) {
                                          parcelController.setPickupAddress(
                                              address, true);
                                        },
                                      )),
                                }),
                      ),
                      SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                      Expanded(
                          flex: 6,
                          child: InkWell(
                            onTap: () {
                              if (Get.find<AuthController>().isLoggedIn()) {
                                Get.dialog(AddressDialog(
                                    onTap: (AddressModel address) {
                                  widget.streetController.text =
                                      address.streetNumber ?? '';
                                  widget.houseController.text =
                                      address.house ?? '';
                                  widget.floorController.text =
                                      address.floor ?? '';
                                }));
                              } else {
                                showCustomSnackBar('you_are_not_logged_in'.tr);
                              }
                            },
                            child: Container(
                              height:
                                  ResponsiveHelper.isDesktop(context) ? 44 : 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_SMALL),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 1)),
                              child: Center(
                                  child: Text('set_from_saved_address'.tr,
                                      style: robotoBold.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: Dimensions.fontSizeLarge))),
                            ),
                          )),
                    ]),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Column(children: [
                      Center(
                          child: Text(
                              parcelController.isSender
                                  ? 'Receiver Information'
                                  : 'receiver_information'.tr,
                              style: robotoMedium)),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      TextFieldShadow(
                        child: MyTextField(
                          hintText: parcelController.isSender
                              ? 'sender_name'.tr
                              : 'receiver_name'.tr,
                          inputType: TextInputType.name,
                          controller: widget.nameController,
                          focusNode: _nameNode,
                          nextFocus: _phoneNode,
                          capitalization: TextCapitalization.words,
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      TextFieldShadow(
                        child: MyTextField(
                          hintText: parcelController.isSender
                              ? 'sender_phone_number'.tr
                              : 'receiver_phone_number'.tr,
                          inputType: TextInputType.phone,
                          focusNode: _phoneNode,
                          nextFocus: _streetNode,
                          controller: widget.phoneController,
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    ]),
                    Column(children: [
                      /* Center(
                                child:
                                Text(
                                    parcelController.isSender
                                        ? 'pickup_information'.tr
                                        : 'destination_information'.tr,
                                    style: robotoMedium)),*/
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      TextFieldShadow(
                        child: MyTextField(
                          hintText: "${'street_number'.tr} (${'optional'.tr})",
                          inputType: TextInputType.streetAddress,
                          focusNode: _streetNode,
                          nextFocus: _houseNode,
                          controller: widget.streetController,
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      Row(children: [
                        Expanded(
                          child: TextFieldShadow(
                            child: MyTextField(
                              hintText: "${'house'.tr} (${'optional'.tr})",
                              inputType: TextInputType.text,
                              focusNode: _houseNode,
                              nextFocus: _floorNode,
                              controller: widget.houseController,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        Expanded(
                          child: TextFieldShadow(
                            child: MyTextField(
                              hintText: "${'floor'.tr} (${'optional'.tr})",
                              inputType: TextInputType.text,
                              focusNode: _floorNode,
                              inputAction: TextInputAction.done,
                              controller: widget.floorController,
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      TextFieldShadow(
                        child: MyTextField(
                          hintText: 'Notes',
                          //controller: _notsController,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                        ),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      TextFieldShadow(
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: (anotherList.length == 0
                                ?
                            Container(
                              color:Theme.of(context)
                                  .disabledColor ,
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
                                child:
                            Column(children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Task 1',
                                            style: robotoMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge,color: Theme.of(context).primaryColor))),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            'Take the Picture of Product',
                                            style: robotoMedium.copyWith(
                                                color: Theme.of(context)
                                                    .hintColor,
                                                fontSize:
                                                    Dimensions.fontSizeLarge))),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  if (parcelController
                                                          .pickedFileList
                                                          .length >
                                                      0)
                                                    Container(
                                                        child:
                                                            updateImagesListView()),
                                                  SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        child: DottedBorder(
                                                            color: Colors.black,
                                                            strokeWidth: 1,
                                                            child: /*Get.find<UserController>().rawFile.toString()!=""?*/
                                                                SqureImagePickerWidget(
                                                              image:
                                                                  '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}/${Get.find<ParcelController>().pickedFile}',
                                                              onTap: () => Get.find<
                                                                      ParcelController>()
                                                                  .pickImage(),

                                                            )

                                                            )),
                                                  ),
                                                  SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_LARGE),
                                                ]),
                                          ]),

                                    ),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Title',
                                        style: robotoRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: Theme.of(context)
                                                .hintColor),
                                      ),
                                    ),
                                    SizedBox(
                                        height: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    MyTextField(
                                      hintText: 'Enter Title',
                                      inputType: TextInputType.name,
                                      controller: main_titleController,
                                      autoFocus: true,
                                      capitalization: TextCapitalization.words,
                                    ),
                                    SizedBox(
                                        height: Dimensions.PADDING_SIZE_LARGE),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Comment',
                                        style: robotoRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: Theme.of(context)
                                                .hintColor),
                                      ),
                                    ),
                                    SizedBox(
                                        height: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    MyTextField(
                                      hintText: 'Type here...',
                                      inputType: TextInputType.name,
                                      maxLines: 5,
                                      inputAction: TextInputAction.done,
                                      controller: main_commentController,
                                      capitalization: TextCapitalization.words,
                                    ),
                                  ]))
                                : null)),
                      ),
                    ]),
                    if (anotherList.length > 0)
                      Container(child: updateListView()),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          height: 60.0,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CustomButton(
                              fontSize: Dimensions.fontSizeSmall,
                              margin: ResponsiveHelper.isDesktop(context)
                                  ? null
                                  : EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                              buttonText: anotherList.length == 0
                                  ? 'Add Task'
                                  : 'Add a More Task',
                              onPressed: () {
                                if (anotherList.length == 0) {
                                  if (main_titleController.text.isEmpty) {
                                    showCustomSnackBar('Enter task title');
                                  } else if (main_commentController
                                      .text.isEmpty) {
                                    showCustomSnackBar('Enter task comment');
                                  } else if (Get.find<ParcelController>()
                                      .pickedFileList
                                      .length==0) {
                                    showCustomSnackBar('Please select one Task image !');
                                  }
                                  else {

                                    List<File_Unitpath> file_raw =
                                        List<File_Unitpath>();
                                    for (int i = 0;
                                        i <
                                            Get.find<ParcelController>()
                                                .pickedFileList
                                                .length;
                                        i++) {
                                      File_Unitpath file_unitpath =
                                          File_Unitpath(
                                              rawFile:
                                                  Get.find<ParcelController>()
                                                      .pickedUintFileList[i]
                                                      .rawFile);
                                      file_raw.add(file_unitpath);
                                    }
                                    print("file_raw>>>" +
                                        file_raw.length.toString());

                                    List<File_path> file_raw1 =
                                        List<File_path>();
                                    for (int i = 0;
                                        i <
                                            Get.find<ParcelController>()
                                                .pickedFileList
                                                .length;
                                        i++) {
                                      File_path file_unitpath = File_path(
                                          file: Get.find<ParcelController>()
                                              .pickedFileList[i]
                                              .file);
                                      file_raw1.add(file_unitpath);
                                    }
                                    print("file_raw>>>" +
                                        file_raw.length.toString());
                                    TaskModel _destination = TaskModel(
                                      task_title:
                                          main_titleController.text.toString(),
                                      task_description: main_commentController
                                          .text
                                          .toString(),
                                      task_media: file_raw1,
                                      rawFile: file_raw,
                                      /* rawFile: Get.find<ParcelController>()
                                          .pickedUintFileList,*/
                                    );
                                    // anotherList=[];
                                    parcelController_main
                                        .setMultiTask(_destination);

                                    setState(
                                        () => anotherList.add(_destination));
                                    parcelController_main.clear_pickupImage();
                                    parcelController_main.pickedFile_null();
                                    // createNewTaskCustomDialog(context);
                                  }
                                } else {
                                  createNewTaskCustomDialog(context);
                                }
                              },
                            ),
                            /* FloatingActionButton(
                              child: Icon(Icons.add,
                                  color: Theme.of(context).primaryColor),
                              mini: true,
                              backgroundColor: Theme.of(context).cardColor,
                              onPressed: () => createNewTaskCustomDialog(context))*/
                          )),
                    ),
                    ResponsiveHelper.isDesktop(context)
                        ? widget.bottomButton
                        : SizedBox(),
                  ]),
                )),
          )),
        );
      }),
    );
  }

  void createNewTaskCustomDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController commentController = TextEditingController();
    Uint8List media;

    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        /*GetBuilder<LocationController>(builder: (locationController)
        {*/
        return GetBuilder<ParcelController>(builder: (parcelController) {
          return Center(
            child: Container(
              height: 520,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "${'Task'} ${' ('}${anotherList.length + 1}${')'}",
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeLarge))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Take the Picture of Product',
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: Dimensions.fontSizeLarge))),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(mainAxisSize: MainAxisSize.max, children: <
                                    Widget>[
                                  if (parcelController.pickedFileList.length >
                                      0)
                                    Container(child: updateImagesListView()),
                                  SizedBox(
                                      width: Dimensions.PADDING_SIZE_SMALL),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        height: 60,
                                        width: 60,
                                        child: DottedBorder(
                                            color: Colors.black,
                                            strokeWidth: 1,
                                            child: /*Get.find<UserController>().rawFile.toString()!=""?*/
                                                SqureImagePickerWidget(
                                              image:
                                                  '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}/${parcelController.pickedFile}',
                                              onTap: () => setState(() =>
                                                  Get.find<ParcelController>()
                                                      .pickImage()),
                                            ))),
                                  ),
                                  SizedBox(
                                      width: Dimensions
                                          .PADDING_SIZE_LARGE),
                                ]),
                              ]),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Title',
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).disabledColor),
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        MyTextField(
                          hintText: 'Enter Title',
                          inputType: TextInputType.name,
                          controller: titleController,
                          inputAction: TextInputAction.done,
                          autoFocus: true,
                          capitalization: TextCapitalization.words,
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Comment',
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).disabledColor),
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        MyTextField(
                          hintText: 'Type here...',
                          inputType: TextInputType.name,
                          maxLines: 5,
                          inputAction: TextInputAction.done,
                          controller: commentController,
                          capitalization: TextCapitalization.words,
                        ),
                        CustomButton(
                          // margin: ResponsiveHelper.isDesktop(context) ? null : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          buttonText: 'save'.tr,
                          onPressed: () {
                            /*if (addressModel_ == null) {
                          showCustomSnackBar('select_destination_address'.tr);
                        }else*/

                            if (titleController.text.isEmpty) {
                              showCustomSnackBar('Enter task title');
                            } else if (commentController.text.isEmpty) {
                              showCustomSnackBar('Enter task comment');
                            }else if (parcelController.pickedFileList.length==0) {
                              showCustomSnackBar('Please select one Task image !');
                            }
                            else {
                              List<File_Unitpath> file_raw =
                                  List<File_Unitpath>();
                              for (int i = 0;
                                  i < parcelController.pickedFileList.length;
                                  i++) {
                                File_Unitpath file_unitpath = File_Unitpath(
                                    rawFile: parcelController
                                        .pickedUintFileList[i].rawFile);
                                file_raw.add(file_unitpath);
                              }
                              List<File_path> file_raw1 = List<File_path>();
                              for (int i = 0;
                                  i < parcelController.pickedFileList.length;
                                  i++) {
                                File_path file_unitpath = File_path(
                                    file: parcelController
                                        .pickedFileList[i].file);
                                file_raw1.add(file_unitpath);
                              }
                              print("file_raw>>>" + file_raw.length.toString());
                              TaskModel _destination = TaskModel(
                                task_title: titleController.text.toString(),
                                task_description:
                                    commentController.text.toString(),
                                task_media: file_raw1,
                                rawFile: file_raw,
                              );
                              // anotherList=[];
                              parcelController_main.setMultiTask(_destination);

                              setState(() => anotherList.add(_destination));
                              parcelController_main.clear_pickupImage();
                              parcelController_main.pickedFile_null();
                              Navigator.pop(context, false);
                            }
                          },
                        ),
                      ])),
                ),
                color: Colors.white,
              ),
            ),
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateImagesListView();
    setState(() {
      updateListView();
    });
  }

  Widget updateListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, position) {
        print("<><>" + anotherList[position].rawFile.length.toString());

        return Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                child: Column(children: [
              Row(children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${'Task'} ${' ('}${position + 1}${')'}",
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).hintColor))),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Expanded(child: SizedBox()),
                InkWell(
                  child: Icon(Icons.cancel, size: 25),
                  onTap: () {
                    setState(() => {
                          Get.find<ParcelController>()
                              .removeMultiTask(position),
                          anotherList.removeAt(position)
                        });
                  },
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              ]),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Picture of Product',
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeLarge))),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              /* Align(
                  alignment: Alignment.centerLeft,
                  child: DottedBorder(
                      color: Colors.black,
                      strokeWidth: 1,
                      child: (anotherList[position].rawFile != null
                          ? Image.memory(
                              anotherList[position].rawFile,
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(Images.placeholder,
                             height: 50, width: 50, fit: BoxFit.fill)))),*/
              SizedBox(
                height: 70,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, Position) {
                    return Container(
                        width: 70,
                        child: Stack(children: [
                          //Stack

                          Align(
                              alignment: Alignment.centerLeft,
                              child: DottedBorder(
                                  color: Colors.black,
                                  strokeWidth: 1,
                                  child: Image.memory(
                                    anotherList[position]
                                        .rawFile[Position]
                                        .rawFile,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.fill,
                                  ))),
                        ]));
                  },
                  itemCount: anotherList[position].rawFile.length,
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ttile',
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).hintColor),
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(anotherList[position].task_title.toString(),
                    textAlign: TextAlign.start,
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: Dimensions.fontSizeDefault)),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Comment',
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).hintColor),
                ),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(anotherList[position].task_description.toString(),
                    textAlign: TextAlign.start,
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).hintColor,
                        fontSize: Dimensions.fontSizeDefault)),
              )
            ])),
          ),
          color: Theme.of(context).disabledColor,
        );
      },
      itemCount: anotherList.length,
    );
  }

  Widget updateImagesListView() {
    return GetBuilder<ParcelController>(builder: (parcelController) {
      return SizedBox(
        height: 70,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, position) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 1),
                child: Container(
                    width: 70,
                    child: Stack(children: [
                      //Stack

                      Align(
                          alignment: Alignment.centerLeft,
                          child: DottedBorder(
                              color: Colors.black,
                              strokeWidth: 1,
                              child: Image.memory(
                                Get.find<ParcelController>()
                                    .pickedUintFileList[position]
                                    .rawFile,
                                width: 60,
                                height: 60,
                                fit: BoxFit.fill,
                              ))),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          child: Icon(Icons.cancel, size: 20),
                          onTap: () {
                            setState(() => {
                                  Get.find<ParcelController>()
                                      .removeImageInList(position),
                                });
                          },
                        ),
                      ),
                    ])));
          },
          itemCount: parcelController.pickedFileList.length,
        ),
      );
    });
  }
}
