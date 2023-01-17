import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/parcel_controller.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
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


class ParcelView extends StatefulWidget {
  final bool isSender;

  final Widget bottomButton;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController streetController;
  final TextEditingController houseController;
  final TextEditingController floorController;

  ParcelView(
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
  State<ParcelView> createState() => _ParcelViewState();
}

class _ParcelViewState extends State<ParcelView> {
  ScrollController scrollController = ScrollController();
  final FocusNode _streetNode = FocusNode();
  final FocusNode _houseNode = FocusNode();
  final FocusNode _floorNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();

  // var parcelController_main;
//  AddressModel addressModel_ = null;
  List<AddressModel> anotherList = List<AddressModel>();

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
       /* if (parcelController.destinationAddress != null) {
          addressModel_ = parcelController.destinationAddress;
        }*/
        //parcelController_main = parcelController;
        return SingleChildScrollView(
          controller: ScrollController(),
          child: Center(
              child: FooterView(
            child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    if (parcelController.isSender)
                      SearchLocationWidget(
                        mapController: null,
                        pickedAddress: parcelController.isSender
                            ? parcelController.pickupAddress.address
                            : parcelController.destinationAddress != null
                                ? parcelController.destinationAddress.address
                                : '',
                        isEnabled: widget.isSender
                            ? parcelController.isPickedUp
                            : !parcelController.isPickedUp,
                        isPickedUp: parcelController.isSender,
                        hint: parcelController.isSender
                            ? 'pick_up'.tr
                            : 'destination'.tr,
                      ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    if (parcelController.isSender)
                      Row(children: [
                        Expanded(
                          flex: 4,
                          child: CustomButton(
                              fontSize: Dimensions.fontSizeDefault,
                              buttonText: 'set_from_map'.tr,
                              onPressed: () => {
                                    print("address>ddfdf>>>>"),
                                    Get.toNamed(
                                        RouteHelper.getPickMapRoute(
                                            'parcel', false),
                                        arguments: PickMapScreen(
                                          fromSignUp: false,
                                          fromAddAddress: false,
                                          canRoute: false,
                                          route: '',
                                          onPicked: (AddressModel address) {
                                            if (parcelController.isPickedUp) {
                                              parcelController.setPickupAddress(
                                                  address, true);
                                            } else {
                                              parcelController
                                                  .setDestinationAddress(
                                                      address,true);
                                            }
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
                                  showCustomSnackBar(
                                      'you_are_not_logged_in'.tr);
                                }
                              },
                              child: Container(
                                height: ResponsiveHelper.isDesktop(context)
                                    ? 44
                                    : 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                child: Center(
                                    child: Text('set_from_saved_address'.tr,
                                        style: robotoBold.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize:
                                                Dimensions.fontSizeDefault))),
                              ),
                            )),
                      ]),
                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    if (parcelController.isSender)
                      Column(children: [
                        Center(
                            child: Text(
                                parcelController.isSender
                                    ? 'sender_information'.tr
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
                            inputAction:TextInputAction.done,
                            controller: widget.phoneController,
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      ]),
                    if (parcelController.isSender)
                      Column(children: [
                        Center(
                            child: Text(
                                parcelController.isSender
                                    ? 'pickup_information'.tr
                                    : 'destination_information'.tr,
                                style: robotoMedium)),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                        TextFieldShadow(
                          child: MyTextField(
                            hintText:
                                "${'street_number'.tr} (${'optional'.tr})",
                            inputType: TextInputType.streetAddress,
                            focusNode: _streetNode,
                            nextFocus: _houseNode,
                            inputAction:TextInputAction.done,
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
                                inputAction:TextInputAction.done,
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
                                inputAction:TextInputAction.done,
                                controller: widget.floorController,
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      ]),
                    if (!parcelController.isSender)
                      if (anotherList.length > 0)
                        Container(child: updateListView()),
                    if (!parcelController.isSender)
                      /*Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child:*/
                      Container(
                          height: 80.0,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CustomButton(
                              margin: ResponsiveHelper.isDesktop(context)
                                  ? null
                                  : EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                              buttonText: parcelController.isSender
                                  ? 'continue'.tr
                                  : anotherList.length > 0
                                      ? 'Add a More drop location'
                                      : 'Add a drop location',
                              onPressed: () {
                                //addressModel_=null;
                                parcelController.removeDestinationAddress();
                                showCustomDialog(context);
                              },
                            ),
                            /* FloatingActionButton(
                              child: Icon(Icons.add,
                                  color: Theme.of(context).primaryColor),
                              mini: true,
                              backgroundColor: Theme.of(context).cardColor,
                              onPressed: () => showCustomDialog(context))*/
                          )),
                    //)
                    //,
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

  void showCustomDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController streetController = TextEditingController();
    TextEditingController houseController = TextEditingController();
    TextEditingController floorController = TextEditingController();
    String selectedAddress = "";
     AddressModel addressModel_ = null;
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (context, animation1, animation2) {
        return GetBuilder<ParcelController>(builder: (parcelController) {
          print("parcelController>>12>" + (parcelController.destinationAddress!=null && parcelController.destinationAddress.address!=null?parcelController.destinationAddress.address:""));
          if (parcelController.destinationAddress != null && parcelController.destinationAddress.address!=null) {
            addressModel_ = parcelController.destinationAddress;
          }
          return Center(
            child: Container(
              height: 600,
              child: Card(

                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(

                    child: Column(children: [
                      SearchLocationWidget(
                        mapController: null,
                        // pickedAddress: selectedAddress,
                        // pickedAddress:selectedAddress!=null && selectedAddress!=""?selectedAddress: Get.find<ParcelController>().destinationAddress!=null && Get.find<ParcelController>().destinationAddress.address!=null ? Get.find<ParcelController>().destinationAddress.address:"",
                        /*pickedAddress: addressModel_ != null
                            ? addressModel_.address != null
                                ? addressModel_.address.toString()
                                : ""
                            : "",*/
                        pickedAddress: parcelController.destinationAddress!=null && parcelController.destinationAddress.address!=null?parcelController.destinationAddress.address:addressModel_ != null
                            ? addressModel_.address != null
                            ? addressModel_.address.toString()
                            : ""
                            : "",
                        isEnabled: false,
                        isPickedUp: false,
                        hint: 'destination'.tr,
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
                                            parcelController.setDestinationAddress(address,true);
                                            Get.find<ParcelController>()
                                                .removeDestinationAddress();
                                            addressModel_ = null;
                                            addressModel_ = address;
                                            selectedAddress = addressModel_
                                                        .additionalAddress !=
                                                    null
                                                ? addressModel_
                                                    .additionalAddress
                                                    .toString()
                                                : addressModel_.address != null
                                                    ? addressModel_.address
                                                        .toString()
                                                    : "";
                                            print("Selected_address>>>" +
                                                selectedAddress);
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
                                    Get.find<ParcelController>()
                                        .removeDestinationAddress();
                                    addressModel_ = null;
                                    /*widget.streetController.text =
                                      address.streetNumber ?? '';
                                  widget.houseController.text =
                                      address.house ?? '';
                                  widget.floorController.text =
                                      address.floor ?? '';*/
                                    addressModel_ = address;
                                    selectedAddress = addressModel_
                                                .additionalAddress !=
                                            null
                                        ? addressModel_.additionalAddress
                                            .toString()
                                        : addressModel_.address != null
                                            ? addressModel_.address.toString()
                                            : "";
                                    print("Selected_address>>>" +
                                        selectedAddress);
                                  }));
                                } else {
                                  showCustomSnackBar(
                                      'you_are_not_logged_in'.tr);
                                }
                              },
                              child: Container(
                                height: ResponsiveHelper.isDesktop(context)
                                    ? 44
                                    : 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                child: Center(
                                    child: Text('set_from_saved_address'.tr,
                                        style: robotoBold.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize:
                                                Dimensions.fontSizeLarge))),
                              ),
                            )),
                      ]),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      Column(children: [
                        Center(
                            child: Text('receiver_information'.tr,
                                style: robotoMedium)),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                        TextFieldShadow(
                          child: MyTextField(
                            hintText: 'receiver_name'.tr,
                            inputType: TextInputType.name,
                            controller: nameController,
                            focusNode: _nameNode,
                            nextFocus: _phoneNode,
                            autoFocus: true,
                            capitalization: TextCapitalization.words,
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                        TextFieldShadow(
                          child: MyTextField(
                            hintText: 'receiver_phone_number'.tr,
                            inputType: TextInputType.phone,
                            focusNode: _phoneNode,
                            /*nextFocus: _streetNode,*/
                            maxLength: 11,
                            inputAction:TextInputAction.done,
                            controller: phoneController,
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      ]),
                      Column(children: [
                        Center(
                            child: Text('destination_information'.tr,
                                style: robotoMedium)),
                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                        TextFieldShadow(
                          child: MyTextField(
                            hintText:
                                "${'street_number'.tr} (${'optional'.tr})",
                            inputType: TextInputType.streetAddress,
                            focusNode: _streetNode,
                            nextFocus: _houseNode,
                            inputAction:TextInputAction.done,
                            controller: streetController,
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
                                inputAction:TextInputAction.done,
                                controller: houseController,
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
                                controller: floorController,
                              ),
                            ),
                          ),
                        ]),
                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      ]),
                      CustomButton(
                        // margin: ResponsiveHelper.isDesktop(context) ? null : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        buttonText: 'save'.tr,
                        onPressed: () {
                          if (addressModel_ == null) {
                            showCustomSnackBar('select_destination_address'.tr);
                          }
                          /* if (Selected_address.isEmpty) {
                          showCustomSnackBar('Please add destination'.tr);
                        }*/
                          else if (nameController.text.isEmpty) {
                            showCustomSnackBar('enter_receiver_name'.tr);
                          } else if (phoneController.text.isEmpty) {
                            showCustomSnackBar(
                                'enter_receiver_phone_number'.tr);
                          } else {
                            AddressModel _destination = AddressModel(
                              address: addressModel_.address.toString(),
                              additionalAddress:
                                  addressModel_.additionalAddress.toString(),
                              addressType: addressModel_.addressType.toString(),
                              contactPersonName: nameController.text.trim(),
                              contactPersonNumber: phoneController.text.trim(),
                              latitude: addressModel_.latitude.toString(),
                              longitude: addressModel_.longitude.toString(),
                              method: addressModel_.method.toString(),
                              zoneId: 0,
                              id: 0,
                              streetNumber: streetController.text.trim(),
                              house: houseController.text.trim(),
                              floor: floorController.text.trim(),
                            );
                            // anotherList=[];
                            /* parcelController_main
                              .setMultiDropDestinationAddress(_destination); */
                            Get.find<ParcelController>()
                                .setMultiDropDestinationAddress(_destination);
                            addressModel_ = null;
                            setState(() => anotherList.add(_destination));

                            Navigator.pop(context, false);
                          }
                        },
                      ),
                    ]),
                  ),
                ),
                color:Color(0xFF303030) ,
              ),
            ),
          );
        });
      },
      transitionBuilder: (context, anim, __, widget) {
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
            child: widget,
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      print("update Pickup location23");
      updateListView();
    });
  }

  Widget updateListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, position) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: Column(children: [
                Column(children: [
                  Row(children: [
                    Center(
                        child: Text(
                            "${'receiver_information'.tr} ${' ('}${position + 1}${')'}",
                            style: robotoMedium)),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Expanded(child: SizedBox()),
                    InkWell(
                      child: Icon(Icons.cancel, size: 25),
                      onTap: () {
                        setState(() => {
                              Get.find<ParcelController>()
                                  .removeMultiDropDestinationAddress(position),
                              anotherList.removeAt(position)
                            });
                      },
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  /* TextFieldShadow(*/
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, bottom: 0, right: 0, top: 10),
                          //apply padding to all four sides
                          child: Column(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Drop Location',
                                  textAlign: TextAlign.start,
                                  style: robotoMedium.copyWith(
                                      color: Colors.black,
                                      fontSize: Dimensions.fontSizeDefault)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  anotherList[position].address.toString(),
                                  textAlign: TextAlign.start,
                                  style: robotoMedium.copyWith(
                                      color: Colors.grey,
                                      fontSize: Dimensions.fontSizeDefault)),
                            )
                          ]),
                        )
                      ])),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  /* TextFieldShadow(*/
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, bottom: 0, right: 0, top: 10),
                          //apply padding to all four sides
                          child: Column(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('receiver_name'.tr,
                                  textAlign: TextAlign.start,
                                  style: robotoMedium.copyWith(
                                      color: Colors.black,
                                      fontSize: Dimensions.fontSizeDefault)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  anotherList[position]
                                      .contactPersonName
                                      .toString(),
                                  textAlign: TextAlign.start,
                                  style: robotoMedium.copyWith(
                                      color: Colors.grey,
                                      fontSize: Dimensions.fontSizeDefault)),
                            )
                          ]),
                        )
                      ])),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, bottom: 0, right: 0, top: 10),
                          //apply padding to all four sides
                          child: Column(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text('receiver_phone_number'.tr,
                                  textAlign: TextAlign.start,
                                  style: robotoMedium.copyWith(
                                      color: Colors.black,
                                      fontSize: Dimensions.fontSizeDefault)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  anotherList[position]
                                      .contactPersonNumber
                                      .toString(),
                                  textAlign: TextAlign.start,
                                  style: robotoMedium.copyWith(
                                      color: Colors.grey,
                                      fontSize: Dimensions.fontSizeDefault)),
                            )
                          ]),
                        )
                      ])),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                ]),
                Column(children: [
                  Center(
                      child: Text('destination_information'.tr,
                          style: robotoMedium)),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, bottom: 0, right: 0, top: 10),
                          //apply padding to all four sides
                          child: Column(children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "${'street_number'.tr} (${'optional'.tr})",
                                  textAlign: TextAlign.start,
                                  style: robotoMedium.copyWith(
                                      color: Colors.black,
                                      fontSize: Dimensions.fontSizeDefault)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  anotherList[position].streetNumber.toString(),
                                  textAlign: TextAlign.start,
                                  style: robotoMedium.copyWith(
                                      color: Colors.grey,
                                      fontSize: Dimensions.fontSizeDefault)),
                            )
                          ]),
                        )
                      ])),
                  SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                  Row(children: [
                    Expanded(
                     /* child: TextFieldShadow(*/
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, bottom: 0, right: 0, top: 10),
                                //apply padding to all four sides
                                child: Column(children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "${'house'.tr} (${'optional'.tr})",
                                        textAlign: TextAlign.start,
                                        style: robotoMedium.copyWith(
                                            color: Colors.black,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        anotherList[position].house.toString(),
                                        textAlign: TextAlign.start,
                                        style: robotoMedium.copyWith(
                                            color: Colors.grey,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                  )
                                ]),
                              )
                            ])),
                     /* ),*/
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                    /*  child: TextFieldShadow(*/
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, bottom: 0, right: 0, top: 10),
                                //apply padding to all four sides
                                child: Column(children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "${'floor'.tr} (${'optional'.tr})",
                                        textAlign: TextAlign.start,
                                        style: robotoMedium.copyWith(
                                            color: Colors.black,
                                            fontSize: Dimensions.fontSizeDefault)),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        anotherList[position].floor.toString(),
                                        textAlign: TextAlign.start,
                                        style: robotoMedium.copyWith(
                                            color: Colors.grey,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                  )
                                ]),
                              )
                            ])),
                     /* ),*/
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                ]),
              ]),
            ),
          ),
          color: Color(0xFF303030),
        );
      },
      itemCount: anotherList.length,
    );
  }
}
