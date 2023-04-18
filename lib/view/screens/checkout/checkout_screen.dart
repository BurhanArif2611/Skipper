import 'package:flutter/services.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/cart_controller.dart';
import 'package:sixam_mart/controller/coupon_controller.dart';
import 'package:sixam_mart/controller/localization_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/order_controller.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/data/model/body/place_order_body.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/cart_model.dart';
import 'package:sixam_mart/data/model/response/config_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_app_bar.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/custom_text_field.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/image_picker_widget.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/my_text_field.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/screens/address/widget/address_widget.dart';
import 'package:sixam_mart/view/screens/cart/widget/delivery_option_button.dart';
import 'package:sixam_mart/view/screens/checkout/widget/payment_button.dart';
import 'package:sixam_mart/view/screens/checkout/widget/slot_widget.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sixam_mart/view/screens/checkout/widget/tips_widget.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';
import 'package:sixam_mart/view/screens/parcel/widget/address_dialog.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';

import '../../../controller/parcel_controller.dart';
import '../../base/custom_loader.dart';
import '../../base/text_field_shadow.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> cartList;
  final bool fromCart;

  CheckoutScreen({@required this.fromCart, @required this.cartList});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _couponController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _streetNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  TextEditingController _tipController = TextEditingController();
  final FocusNode _streetNode = FocusNode();
  final FocusNode _houseNode = FocusNode();
  final FocusNode _floorNode = FocusNode();
  var regexToRemoveEmoji =
      '   /\uD83C\uDFF4\uDB40\uDC67\uDB40\uDC62(?:\uDB40\uDC77\uDB40\uDC6C\uDB40\uDC73|\uDB40\uDC73\uDB40\uDC63\uDB40\uDC74|\uDB40\uDC65\uDB40\uDC6E\uDB40\uDC67)\uDB40\uDC7F|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC68(?:\uD83C\uDFFF\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFE])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83E\uDD1D\u200D\uD83D\uDC68(?:\uD83C[\uDFFC-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D)?\uD83D\uDC68|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67]))|\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D[\uDC68\uDC69])\u200D(?:\uD83D[\uDC66\uDC67])|[\u2695\u2696\u2708]\uFE0F|\uD83D[\uDC66\uDC67]|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708])\uFE0F|\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\u200D(?:\uD83E\uDD1D\u200D\uD83E\uDDD1|\uD83C[\uDF3E\uDF73\uDF7C\uDF84\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69(?:\u200D(?:\u2764\uFE0F\u200D(?:\uD83D\uDC8B\u200D(?:\uD83D[\uDC68\uDC69])|\uD83D[\uDC68\uDC69])|\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFF\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFE\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFD\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFC\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD])|\uD83C\uDFFB\u200D(?:\uD83C[\uDF3E\uDF73\uDF7C\uDF93\uDFA4\uDFA8\uDFEB\uDFED]|\uD83D[\uDCBB\uDCBC\uDD27\uDD2C\uDE80\uDE92]|\uD83E[\uDDAF-\uDDB3\uDDBC\uDDBD]))|\uD83D\uDC69\uD83C\uDFFF\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFE])|\uD83D\uDC69\uD83C\uDFFE\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB-\uDFFD\uDFFF])|\uD83D\uDC69\uD83C\uDFFD\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFC\uDFFE\uDFFF])|\uD83D\uDC69\uD83C\uDFFC\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFB\uDFFD-\uDFFF])|\uD83D\uDC69\uD83C\uDFFB\u200D\uD83E\uDD1D\u200D(?:\uD83D[\uDC68\uDC69])(?:\uD83C[\uDFFC-\uDFFF])|\uD83D\uDC69\u200D\uD83D\uDC66\u200D\uD83D\uDC66|\uD83D\uDC69\u200D\uD83D\uDC69\u200D(?:\uD83D[\uDC66\uDC67])|(?:\uD83D\uDC41\uFE0F\u200D\uD83D\uDDE8|\uD83D\uDC69(?:\uD83C\uDFFF\u200D[\u2695\u2696\u2708]|\uD83C\uDFFE\u200D[\u2695\u2696\u2708]|\uD83C\uDFFD\u200D[\u2695\u2696\u2708]|\uD83C\uDFFC\u200D[\u2695\u2696\u2708]|\uD83C\uDFFB\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83C\uDFF3\uFE0F\u200D\u26A7|\uD83E\uDDD1(?:(?:\uD83C[\uDFFB-\uDFFF])\u200D[\u2695\u2696\u2708]|\u200D[\u2695\u2696\u2708])|\uD83D\uDC3B\u200D\u2744|(?:(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF])\u200D[\u2640\u2642]|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])\u200D[\u2640\u2642]|\uD83C\uDFF4\u200D\u2620|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])\u200D[\u2640\u2642]|[\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u2328\u23CF\u23ED-\u23EF\u23F1\u23F2\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB\u25FC\u2600-\u2604\u260E\u2611\u2618\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u2692\u2694-\u2697\u2699\u269B\u269C\u26A0\u26A7\u26B0\u26B1\u26C8\u26CF\u26D1\u26D3\u26E9\u26F0\u26F1\u26F4\u26F7\u26F8\u2702\u2708\u2709\u270F\u2712\u2714\u2716\u271D\u2721\u2733\u2734\u2744\u2747\u2763\u2764\u27A1\u2934\u2935\u2B05-\u2B07\u3030\u303D\u3297\u3299]|\uD83C[\uDD70\uDD71\uDD7E\uDD7F\uDE02\uDE37\uDF21\uDF24-\uDF2C\uDF36\uDF7D\uDF96\uDF97\uDF99-\uDF9B\uDF9E\uDF9F\uDFCD\uDFCE\uDFD4-\uDFDF\uDFF5\uDFF7]|\uD83D[\uDC3F\uDCFD\uDD49\uDD4A\uDD6F\uDD70\uDD73\uDD76-\uDD79\uDD87\uDD8A-\uDD8D\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA\uDECB\uDECD-\uDECF\uDEE0-\uDEE5\uDEE9\uDEF0\uDEF3])\uFE0F|\uD83D\uDC69\u200D\uD83D\uDC67\u200D(?:\uD83D[\uDC66\uDC67])|\uD83C\uDFF3\uFE0F\u200D\uD83C\uDF08|\uD83D\uDC69\u200D\uD83D\uDC67|\uD83D\uDC69\u200D\uD83D\uDC66|\uD83D\uDC15\u200D\uD83E\uDDBA|\uD83D\uDC69(?:\uD83C\uDFFF|\uD83C\uDFFE|\uD83C\uDFFD|\uD83C\uDFFC|\uD83C\uDFFB)?|\uD83C\uDDFD\uD83C\uDDF0|\uD83C\uDDF6\uD83C\uDDE6|\uD83C\uDDF4\uD83C\uDDF2|\uD83D\uDC08\u200D\u2B1B|\uD83D\uDC41\uFE0F|\uD83C\uDFF3\uFE0F|\uD83E\uDDD1(?:\uD83C[\uDFFB-\uDFFF])?|\uD83C\uDDFF(?:\uD83C[\uDDE6\uDDF2\uDDFC])|\uD83C\uDDFE(?:\uD83C[\uDDEA\uDDF9])|\uD83C\uDDFC(?:\uD83C[\uDDEB\uDDF8])|\uD83C\uDDFB(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDEE\uDDF3\uDDFA])|\uD83C\uDDFA(?:\uD83C[\uDDE6\uDDEC\uDDF2\uDDF3\uDDF8\uDDFE\uDDFF])|\uD83C\uDDF9(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDED\uDDEF-\uDDF4\uDDF7\uDDF9\uDDFB\uDDFC\uDDFF])|\uD83C\uDDF8(?:\uD83C[\uDDE6-\uDDEA\uDDEC-\uDDF4\uDDF7-\uDDF9\uDDFB\uDDFD-\uDDFF])|\uD83C\uDDF7(?:\uD83C[\uDDEA\uDDF4\uDDF8\uDDFA\uDDFC])|\uD83C\uDDF5(?:\uD83C[\uDDE6\uDDEA-\uDDED\uDDF0-\uDDF3\uDDF7-\uDDF9\uDDFC\uDDFE])|\uD83C\uDDF3(?:\uD83C[\uDDE6\uDDE8\uDDEA-\uDDEC\uDDEE\uDDF1\uDDF4\uDDF5\uDDF7\uDDFA\uDDFF])|\uD83C\uDDF2(?:\uD83C[\uDDE6\uDDE8-\uDDED\uDDF0-\uDDFF])|\uD83C\uDDF1(?:\uD83C[\uDDE6-\uDDE8\uDDEE\uDDF0\uDDF7-\uDDFB\uDDFE])|\uD83C\uDDF0(?:\uD83C[\uDDEA\uDDEC-\uDDEE\uDDF2\uDDF3\uDDF5\uDDF7\uDDFC\uDDFE\uDDFF])|\uD83C\uDDEF(?:\uD83C[\uDDEA\uDDF2\uDDF4\uDDF5])|\uD83C\uDDEE(?:\uD83C[\uDDE8-\uDDEA\uDDF1-\uDDF4\uDDF6-\uDDF9])|\uD83C\uDDED(?:\uD83C[\uDDF0\uDDF2\uDDF3\uDDF7\uDDF9\uDDFA])|\uD83C\uDDEC(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEE\uDDF1-\uDDF3\uDDF5-\uDDFA\uDDFC\uDDFE])|\uD83C\uDDEB(?:\uD83C[\uDDEE-\uDDF0\uDDF2\uDDF4\uDDF7])|\uD83C\uDDEA(?:\uD83C[\uDDE6\uDDE8\uDDEA\uDDEC\uDDED\uDDF7-\uDDFA])|\uD83C\uDDE9(?:\uD83C[\uDDEA\uDDEC\uDDEF\uDDF0\uDDF2\uDDF4\uDDFF])|\uD83C\uDDE8(?:\uD83C[\uDDE6\uDDE8\uDDE9\uDDEB-\uDDEE\uDDF0-\uDDF5\uDDF7\uDDFA-\uDDFF])|\uD83C\uDDE7(?:\uD83C[\uDDE6\uDDE7\uDDE9-\uDDEF\uDDF1-\uDDF4\uDDF6-\uDDF9\uDDFB\uDDFC\uDDFE\uDDFF])|\uD83C\uDDE6(?:\uD83C[\uDDE8-\uDDEC\uDDEE\uDDF1\uDDF2\uDDF4\uDDF6-\uDDFA\uDDFC\uDDFD\uDDFF])|[#\*0-9]\uFE0F\u20E3|(?:\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD])(?:\uD83C[\uDFFB-\uDFFF])|(?:\u26F9|\uD83C[\uDFCB\uDFCC]|\uD83D\uDD75)(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|\uD83C\uDFF4|(?:[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5])(?:\uD83C[\uDFFB-\uDFFF])|(?:[\u261D\u270C\u270D]|\uD83D[\uDD74\uDD90])(?:\uFE0F|\uD83C[\uDFFB-\uDFFF])|[\u270A\u270B]|\uD83C[\uDF85\uDFC2\uDFC7]|\uD83D[\uDC08\uDC15\uDC3B\uDC42\uDC43\uDC46-\uDC50\uDC66\uDC67\uDC6B-\uDC6D\uDC72\uDC74-\uDC76\uDC78\uDC7C\uDC83\uDC85\uDCAA\uDD7A\uDD95\uDD96\uDE4C\uDE4F\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1C\uDD1E\uDD1F\uDD30-\uDD34\uDD36\uDD77\uDDB5\uDDB6\uDDBB\uDDD2-\uDDD5]|\uD83C[\uDFC3\uDFC4\uDFCA]|\uD83D[\uDC6E\uDC70\uDC71\uDC73\uDC77\uDC81\uDC82\uDC86\uDC87\uDE45-\uDE47\uDE4B\uDE4D\uDE4E\uDEA3\uDEB4-\uDEB6]|\uD83E[\uDD26\uDD35\uDD37-\uDD39\uDD3D\uDD3E\uDDB8\uDDB9\uDDCD-\uDDCF\uDDD6-\uDDDD]|\uD83D\uDC6F|\uD83E[\uDD3C\uDDDE\uDDDF]|[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF84\uDF86-\uDF93\uDFA0-\uDFC1\uDFC5\uDFC6\uDFC8\uDFC9\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC07\uDC09-\uDC14\uDC16-\uDC3A\uDC3C-\uDC3E\uDC40\uDC44\uDC45\uDC51-\uDC65\uDC6A\uDC79-\uDC7B\uDC7D-\uDC80\uDC84\uDC88-\uDCA9\uDCAB-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDDA4\uDDFB-\uDE44\uDE48-\uDE4A\uDE80-\uDEA2\uDEA4-\uDEB3\uDEB7-\uDEBF\uDEC1-\uDEC5\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0D\uDD0E\uDD10-\uDD17\uDD1D\uDD20-\uDD25\uDD27-\uDD2F\uDD3A\uDD3F-\uDD45\uDD47-\uDD76\uDD78\uDD7A-\uDDB4\uDDB7\uDDBA\uDDBC-\uDDCB\uDDD0\uDDE0-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6]|(?:[\u231A\u231B\u23E9-\u23EC\u23F0\u23F3\u25FD\u25FE\u2614\u2615\u2648-\u2653\u267F\u2693\u26A1\u26AA\u26AB\u26BD\u26BE\u26C4\u26C5\u26CE\u26D4\u26EA\u26F2\u26F3\u26F5\u26FA\u26FD\u2705\u270A\u270B\u2728\u274C\u274E\u2753-\u2755\u2757\u2795-\u2797\u27B0\u27BF\u2B1B\u2B1C\u2B50\u2B55]|\uD83C[\uDC04\uDCCF\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE1A\uDE2F\uDE32-\uDE36\uDE38-\uDE3A\uDE50\uDE51\uDF00-\uDF20\uDF2D-\uDF35\uDF37-\uDF7C\uDF7E-\uDF93\uDFA0-\uDFCA\uDFCF-\uDFD3\uDFE0-\uDFF0\uDFF4\uDFF8-\uDFFF]|\uD83D[\uDC00-\uDC3E\uDC40\uDC42-\uDCFC\uDCFF-\uDD3D\uDD4B-\uDD4E\uDD50-\uDD67\uDD7A\uDD95\uDD96\uDDA4\uDDFB-\uDE4F\uDE80-\uDEC5\uDECC\uDED0-\uDED2\uDED5-\uDED7\uDEEB\uDEEC\uDEF4-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])|(?:[#\*0-9\xA9\xAE\u203C\u2049\u2122\u2139\u2194-\u2199\u21A9\u21AA\u231A\u231B\u2328\u23CF\u23E9-\u23F3\u23F8-\u23FA\u24C2\u25AA\u25AB\u25B6\u25C0\u25FB-\u25FE\u2600-\u2604\u260E\u2611\u2614\u2615\u2618\u261D\u2620\u2622\u2623\u2626\u262A\u262E\u262F\u2638-\u263A\u2640\u2642\u2648-\u2653\u265F\u2660\u2663\u2665\u2666\u2668\u267B\u267E\u267F\u2692-\u2697\u2699\u269B\u269C\u26A0\u26A1\u26A7\u26AA\u26AB\u26B0\u26B1\u26BD\u26BE\u26C4\u26C5\u26C8\u26CE\u26CF\u26D1\u26D3\u26D4\u26E9\u26EA\u26F0-\u26F5\u26F7-\u26FA\u26FD\u2702\u2705\u2708-\u270D\u270F\u2712\u2714\u2716\u271D\u2721\u2728\u2733\u2734\u2744\u2747\u274C\u274E\u2753-\u2755\u2757\u2763\u2764\u2795-\u2797\u27A1\u27B0\u27BF\u2934\u2935\u2B05-\u2B07\u2B1B\u2B1C\u2B50\u2B55\u3030\u303D\u3297\u3299]|\uD83C[\uDC04\uDCCF\uDD70\uDD71\uDD7E\uDD7F\uDD8E\uDD91-\uDD9A\uDDE6-\uDDFF\uDE01\uDE02\uDE1A\uDE2F\uDE32-\uDE3A\uDE50\uDE51\uDF00-\uDF21\uDF24-\uDF93\uDF96\uDF97\uDF99-\uDF9B\uDF9E-\uDFF0\uDFF3-\uDFF5\uDFF7-\uDFFF]|\uD83D[\uDC00-\uDCFD\uDCFF-\uDD3D\uDD49-\uDD4E\uDD50-\uDD67\uDD6F\uDD70\uDD73-\uDD7A\uDD87\uDD8A-\uDD8D\uDD90\uDD95\uDD96\uDDA4\uDDA5\uDDA8\uDDB1\uDDB2\uDDBC\uDDC2-\uDDC4\uDDD1-\uDDD3\uDDDC-\uDDDE\uDDE1\uDDE3\uDDE8\uDDEF\uDDF3\uDDFA-\uDE4F\uDE80-\uDEC5\uDECB-\uDED2\uDED5-\uDED7\uDEE0-\uDEE5\uDEE9\uDEEB\uDEEC\uDEF0\uDEF3-\uDEFC\uDFE0-\uDFEB]|\uD83E[\uDD0C-\uDD3A\uDD3C-\uDD45\uDD47-\uDD78\uDD7A-\uDDCB\uDDCD-\uDDFF\uDE70-\uDE74\uDE78-\uDE7A\uDE80-\uDE86\uDE90-\uDEA8\uDEB0-\uDEB6\uDEC0-\uDEC2\uDED0-\uDED6])\uFE0F|(?:[\u261D\u26F9\u270A-\u270D]|\uD83C[\uDF85\uDFC2-\uDFC4\uDFC7\uDFCA-\uDFCC]|\uD83D[\uDC42\uDC43\uDC46-\uDC50\uDC66-\uDC78\uDC7C\uDC81-\uDC83\uDC85-\uDC87\uDC8F\uDC91\uDCAA\uDD74\uDD75\uDD7A\uDD90\uDD95\uDD96\uDE45-\uDE47\uDE4B-\uDE4F\uDEA3\uDEB4-\uDEB6\uDEC0\uDECC]|\uD83E[\uDD0C\uDD0F\uDD18-\uDD1F\uDD26\uDD30-\uDD39\uDD3C-\uDD3E\uDD77\uDDB5\uDDB6\uDDB8\uDDB9\uDDBB\uDDCD-\uDDCF\uDDD1-\uDDDD])/';

  double _taxPercent = 0;
  bool _isCashOnDeliveryActive;
  bool _isDigitalPaymentActive;
  bool _isLoggedIn;
  List<CartModel> _cartList;
  bool _isWalletActive;
  int Final_index = 0;

  @override
  void initState() {
    super.initState();
    Get.find<OrderController>().clearPrevData();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn) {
      if (Get.find<UserController>().userInfoModel == null) {
        Get.find<UserController>().getUserInfo();
      }
      if (Get.find<LocationController>().addressList == null) {
        Get.find<LocationController>().getAddressList();
      }
      _isCashOnDeliveryActive =
          Get.find<SplashController>().configModel.cashOnDelivery;
      _isDigitalPaymentActive =
          Get.find<SplashController>().configModel.digitalPayment;
      _cartList = [];
      widget.fromCart
          ? _cartList.addAll(Get.find<CartController>().cartList)
          : _cartList.addAll(widget.cartList);
      Get.find<StoreController>().initCheckoutData(_cartList[0].item.storeId);
      _isWalletActive =
          Get.find<SplashController>().configModel.customerWalletStatus == 1;
      Get.find<OrderController>().updateTips(-1, notify: false);
      Get.find<OrderController>().addTips(0.0);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _streetNumberController.dispose();
    _houseController.dispose();
    _floorController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Module _module =
        Get.find<SplashController>().configModel.moduleConfig.module;
    bool showVeg = false;
    try {
      int moduleId = Get.find<StoreController>().store != null
          ? Get.find<StoreController>().store.moduleId
          : 0;
      if (Get.find<SplashController>().moduleList != null) {
        Get.find<SplashController>().moduleList.forEach((storeCategory) => {
              if (storeCategory.id == moduleId)
                {
                  if (storeCategory.moduleType == 'food' ||
                      storeCategory.moduleType == 'Food')
                    {showVeg = true}
                }
            });
      }
    } catch (e) {}
    return Scaffold(
      appBar: CustomAppBar(title: 'checkout'.tr),
      endDrawer: MenuDrawer(),
      body: _isLoggedIn
          ? GetBuilder<LocationController>(builder: (locationController) {
              return GetBuilder<StoreController>(builder: (storeController) {
                List<DropdownMenuItem<int>> _addressList = [];
                _addressList.add(DropdownMenuItem<int>(
                    value: -1,
                    child: SizedBox(
                      width: context.width > Dimensions.WEB_MAX_WIDTH
                          ? Dimensions.WEB_MAX_WIDTH - 50
                          : context.width - 50,
                      child: AddressWidget(
                        address:
                            Get.find<LocationController>().getUserAddress(),
                        fromAddress: false,
                        fromCheckout: true,
                      ),
                    )));
                if (locationController.addressList != null &&
                    storeController.store != null) {
                  for (int index = 0;
                      index < locationController.addressList.length;
                      index++) {
                    if (locationController.addressList[index].zoneIds
                        .contains(storeController.store.zoneId)) {
                      _addressList.add(DropdownMenuItem<int>(
                          value: index,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).dividerColor,
                            ),
                            child: SizedBox(
                              height: 120,
                              width: context.width > Dimensions.WEB_MAX_WIDTH
                                  ? Dimensions.WEB_MAX_WIDTH - 50
                                  : context.width - 50,
                              child: AddressWidget(
                                address: locationController.addressList[index],
                                fromAddress: false,
                                fromCheckout: true,
                              ),
                            ),
                          )));
                    }
                  }
                }

                bool _todayClosed = false;
                bool _tomorrowClosed = false;
                if (storeController.store != null) {
                  _todayClosed = storeController.isStoreClosed(
                      true,
                      storeController.store.active,
                      storeController.store.schedules);
                  _tomorrowClosed = storeController.isStoreClosed(
                      false,
                      storeController.store.active,
                      storeController.store.schedules);
                  _taxPercent = storeController.store.tax;
                }
                return GetBuilder<CouponController>(
                    builder: (couponController) {
                  return GetBuilder<OrderController>(
                      builder: (orderController) {
                    double _deliveryCharge = -1;
                    double _charge = -1;
                    if (storeController.store != null &&
                        storeController.store.selfDeliverySystem == 1) {
                      _deliveryCharge = storeController.store.deliveryCharge;
                      _charge = storeController.store.deliveryCharge;
                    } else if (storeController.store != null &&
                        orderController.distance != null &&
                        orderController.distance != -1) {
                      _deliveryCharge = orderController.distance *
                          Get.find<SplashController>()
                              .configModel
                              .perKmShippingCharge;
                      _charge = orderController.distance *
                          Get.find<SplashController>()
                              .configModel
                              .perKmShippingCharge;
                      if (_deliveryCharge <
                          Get.find<SplashController>()
                              .configModel
                              .minimumShippingCharge) {
                        _deliveryCharge = Get.find<SplashController>()
                            .configModel
                            .minimumShippingCharge;
                        _charge = Get.find<SplashController>()
                            .configModel
                            .minimumShippingCharge;
                      }
                    } else if (locationController.addressList != null &&
                        locationController.addressList.length > 0) {
                      try {
                        orderController.getDistanceInKM(
                            LatLng(
                              double.parse(
                                  locationController.addressList[0].latitude),
                              double.parse(
                                  locationController.addressList[0].longitude),
                            ),
                            LatLng(double.parse(storeController.store.latitude),
                                double.parse(storeController.store.longitude)),
                            "[]");
                      } catch (e) {}
                    }

                    double _price = 0;
                    double _discount = 0;
                    double _couponDiscount = couponController.discount;
                    double _tax = 0;
                    double _addOns = 0;
                    double _subTotal = 0;
                    double _orderAmount = 0;
                    if (storeController.store != null) {
                      _cartList.forEach((cartModel) {
                        List<AddOns> _addOnList = [];
                        cartModel.addOnIds.forEach((addOnId) {
                          for (AddOns addOns in cartModel.item.addOns) {
                            if (addOns.id == addOnId.id) {
                              _addOnList.add(addOns);
                              break;
                            }
                          }
                        });

                        for (int index = 0;
                            index < _addOnList.length;
                            index++) {
                          _addOns = _addOns +
                              (_addOnList[index].price *
                                  cartModel.addOnIds[index].quantity);
                        }
                        _price =
                            _price + (cartModel.price * cartModel.quantity);
                        double _dis = (storeController.store.discount != null &&
                                DateConverter.isAvailable(
                                    storeController.store.discount.startTime,
                                    storeController.store.discount.endTime))
                            ? storeController.store.discount.discount
                            : cartModel.item.discount;
                        String _disType = (storeController.store.discount !=
                                    null &&
                                DateConverter.isAvailable(
                                    storeController.store.discount.startTime,
                                    storeController.store.discount.endTime))
                            ? 'percent'
                            : cartModel.item.discountType;
                        _discount = _discount +
                            ((cartModel.price -
                                    PriceConverter.convertWithDiscount(
                                        cartModel.price, _dis, _disType)) *
                                cartModel.quantity);
                      });
                      if (storeController.store != null &&
                          storeController.store.discount != null) {
                        if (storeController.store.discount.maxDiscount != 0 &&
                            storeController.store.discount.maxDiscount <
                                _discount) {
                          _discount =
                              storeController.store.discount.maxDiscount;
                        }
                        if (storeController.store.discount.minPurchase != 0 &&
                            storeController.store.discount.minPurchase >
                                (_price + _addOns)) {
                          _discount = 0;
                        }
                      }
                      _subTotal = _price + _addOns;
                      _orderAmount =
                          (_price - _discount) + _addOns - _couponDiscount;

                      if (orderController.orderType == 'take_away' ||
                          (storeController.store.freeDelivery &&
                              Get.find<SplashController>()
                                      .configModel
                                      .freeDeliveryOver !=
                                  null &&
                              _orderAmount >=
                                  Get.find<SplashController>()
                                      .configModel
                                      .freeDeliveryOver) ||
                          couponController.freeDelivery) {
                        _deliveryCharge = 0;
                      }
                    }

                    _tax = PriceConverter.calculation(
                        _orderAmount, _taxPercent, 'percent', 1);
                    double _total = _subTotal +
                        _deliveryCharge -
                        _discount -
                        _couponDiscount +
                        _tax +
                        orderController.tips;

                    return (/*orderController.distance != null &&*/ locationController
                                .addressList !=
                            null)
                        ? Column(
                            children: [
                              Expanded(
                                  child: Scrollbar(
                                      child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
                                child: FooterView(
                                    child: SizedBox(
                                  width: Dimensions.WEB_MAX_WIDTH,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Order type
                                        Text('delivery_option'.tr,
                                            style: robotoMedium),
                                        storeController.store != null && storeController.store.delivery!=null &&
                                                storeController.store.delivery
                                            ? DeliveryOptionButton(
                                                value: 'delivery',
                                                title: 'home_delivery'.tr,
                                                charge: _charge,
                                                isFree: (storeController.store
                                                                .freeDelivery &&
                                                            Get.find<SplashController>()
                                                                    .configModel
                                                                    .freeDeliveryOver !=
                                                                null &&
                                                            _orderAmount >=
                                                                Get.find<
                                                                        SplashController>()
                                                                    .configModel
                                                                    .freeDeliveryOver ||
                                                        couponController
                                                            .freeDelivery)
                                                    ? true
                                                    : false,
                                              )
                                            : SizedBox(),
                                        showVeg &&
                                                storeController.store != null &&
                                                storeController.store.takeAway
                                            ? DeliveryOptionButton(
                                                value: 'take_away',
                                                title: 'take_away'.tr,
                                                charge: _deliveryCharge,
                                                isFree: true,
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE),

                                        orderController.orderType != 'take_away'
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text('deliver_to'.tr,
                                                              style:
                                                                  robotoMedium),
                                                          TextButton.icon(
                                                            onPressed:
                                                                () async {
                                                              var _address = await Get.toNamed(
                                                                  RouteHelper.getAddAddressRoute(
                                                                      true,
                                                                      storeController
                                                                          .store
                                                                          .zoneId));
                                                              if (_address !=
                                                                  null) {
                                                                if (storeController
                                                                        .store
                                                                        .selfDeliverySystem ==
                                                                    0) {

                                                                  orderController.getDistanceInKM(
                                                                      LatLng(
                                                                          double.parse(_address
                                                                              .latitude),
                                                                          double.parse(_address
                                                                              .longitude)),
                                                                      LatLng(
                                                                          double.parse(storeController
                                                                              .store
                                                                              .latitude),
                                                                          double.parse(storeController
                                                                              .store
                                                                              .longitude)),
                                                                      "[]");
                                                                }

                                                                _addressController.text=_address.address ??
                                                                    '';
                                                                _streetNumberController
                                                                        .text =
                                                                    _address.streetNumber ??
                                                                        '';
                                                                _houseController
                                                                        .text =
                                                                    _address.house ??
                                                                        '';
                                                                _floorController
                                                                        .text =
                                                                    _address.floor ??
                                                                        '';
                                                              }
                                                            },
                                                            icon: Icon(
                                                                Icons.add,
                                                                size: 20),
                                                            label: Text(
                                                                'add'.tr,
                                                                style: robotoMedium
                                                                    .copyWith(
                                                                        fontSize:
                                                                            Dimensions.fontSizeSmall)),
                                                          ),
                                                        ]),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),

                                                      // dropdown below..
                                                      child:

                                                          /* DropdownButton(
                                                        value: orderController
                                                            .addressIndex,
                                                        dropdownColor:
                                                        Theme.of(context).hintColor,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                        ),
                                                      */ /*  dropdownColor: Colors.white,*/ /*

                                                        isExpanded: true,
                                                        items: _addressList !=
                                                                    null &&
                                                                _addressList
                                                                        .length >
                                                                    0
                                                            ? _addressList
                                                            : 0,
                                                        itemHeight:
                                                            ResponsiveHelper
                                                                    .isMobile(
                                                                        context)
                                                                ? 70
                                                                : 85,
                                                        elevation: 0,
                                                        iconSize: _addressList
                                                                    .length > 1
                                                            ? 30
                                                            : 0,
                                                        underline: SizedBox(),
                                                        onChanged: (int index) {
                                                          if (storeController
                                                                  .store
                                                                  .selfDeliverySystem ==
                                                              0) {
                                                            orderController
                                                                .getDistanceInKM(
                                                                    LatLng(
                                                                      double.parse(index ==
                                                                              -1
                                                                          ? locationController
                                                                              .getUserAddress()
                                                                              .latitude
                                                                          : locationController
                                                                              .addressList[index]
                                                                              .latitude),
                                                                      double.parse(index ==
                                                                              -1
                                                                          ? locationController
                                                                              .getUserAddress()
                                                                              .longitude
                                                                          : locationController
                                                                              .addressList[index]
                                                                              .longitude),
                                                                    ),
                                                                    LatLng(
                                                                        double.parse(storeController
                                                                            .store
                                                                            .latitude),
                                                                        double.parse(storeController
                                                                            .store
                                                                            .longitude)),
                                                                    "[]");
                                                          }
                                                          orderController
                                                              .setAddressIndex(
                                                                  index);
                                                          _streetNumberController
                                                              .text = index ==
                                                                  -1
                                                              ? locationController
                                                                      .getUserAddress()
                                                                      .streetNumber ??
                                                                  ''
                                                              : locationController
                                                                      .addressList[
                                                                          index]
                                                                      .streetNumber ??
                                                                  '';
                                                          _houseController
                                                              .text = index ==
                                                                  -1
                                                              ? locationController
                                                                      .getUserAddress()
                                                                      .house ??
                                                                  ''
                                                              : locationController
                                                                      .addressList[
                                                                          index]
                                                                      .house ??
                                                                  '';
                                                          _floorController
                                                              .text = index ==
                                                                  -1
                                                              ? locationController
                                                                      .getUserAddress()
                                                                      .floor ??
                                                                  ''
                                                              : locationController
                                                                      .addressList[
                                                                          index]
                                                                      .floor ??
                                                                  '';
                                                        },
                                                      ),*/

                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (Get.find<
                                                                    AuthController>()
                                                                .isLoggedIn()) {
                                                              Get.dialog(
                                                                  AddressDialog(
                                                                onTap:
                                                                    (AddressModel
                                                                        address) {
                                                                  if (storeController
                                                                          .store
                                                                          .selfDeliverySystem ==
                                                                      0) {
                                                                    orderController.getDistanceInKM(
                                                                        LatLng(
                                                                          double.parse(
                                                                              address.latitude),
                                                                          double.parse(
                                                                              address.longitude),
                                                                        ),
                                                                        LatLng(double.parse(storeController.store.latitude), double.parse(storeController.store.longitude)),
                                                                        "[]");


                                                                  }
                                                                  /* orderController
                                                                  .setAddressIndex(
                                                                  index);
                                                              _streetNumberController
                                                                  .text = index ==
                                                                  -1
                                                                  ? locationController
                                                                  .getUserAddress()
                                                                  .streetNumber ??
                                                                  ''
                                                                  : locationController
                                                                  .addressList[
                                                              index]
                                                                  .streetNumber ??
                                                                  '';
                                                              _houseController
                                                                  .text = index ==
                                                                  -1
                                                                  ? locationController
                                                                  .getUserAddress()
                                                                  .house ??
                                                                  ''
                                                                  : locationController
                                                                  .addressList[
                                                              index]
                                                                  .house ??
                                                                  '';
                                                              _floorController
                                                                  .text = index ==
                                                                  -1
                                                                  ? locationController
                                                                  .getUserAddress()
                                                                  .floor ??
                                                                  ''
                                                                  : locationController
                                                                  .addressList[
                                                              index]
                                                                  .floor ??
                                                                  '';*/
                                                                },
                                                                index1: (int
                                                                    index) {
                                                                  Final_index =
                                                                      index;
                                                                  print("_address>>>"+Final_index.toString());

                                                                },
                                                                /*(AddressModel address) {
                                                                    widget.streetController.text =
                                                                        address.streetNumber ?? '';
                                                                    widget.houseController.text =
                                                                        address.house ?? '';
                                                                    widget.floorController.text =
                                                                        address.floor ?? '';
                                                                  }*/
                                                              ));
                                                            } else {
                                                              showCustomSnackBar(
                                                                  'you_are_not_logged_in'
                                                                      .tr);
                                                            }
                                                          },
                                                          child: SizedBox(
                                                              height: locationController
                                                                              .addressList !=
                                                                          null &&
                                                                      locationController
                                                                              .addressList
                                                                              .length >
                                                                          0
                                                                  ? 80
                                                                  : 0,
                                                              /* width: context.width > Dimensions.WEB_MAX_WIDTH
                                                              ? Dimensions.WEB_MAX_WIDTH - 50
                                                              : context.width - 50,*/
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        Dimensions
                                                                            .PADDING_SIZE_SMALL),
                                                                child: (locationController.addressList !=
                                                                            null &&
                                                                        locationController.addressList.length >
                                                                            0
                                                                    ? AddressWidget(
                                                                        address: locationController.addressList != null &&
                                                                                locationController.addressList.length > 0
                                                                            ? locationController.addressList[Final_index]
                                                                            : null,
                                                                        fromAddress:
                                                                            false,
                                                                        fromCheckout:
                                                                            true,
                                                                      )
                                                                    : SizedBox()),
                                                              )),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE),
                                                    Text(
                                                      'street_number'.tr,
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor),
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    MyTextField(
                                                      hintText:
                                                          'street_number'.tr,
                                                      inputType: TextInputType
                                                          .streetAddress,
                                                      focusNode: _streetNode,
                                                      nextFocus: _houseNode,
                                                      controller:
                                                          _streetNumberController,
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE),
                                                    Text(
                                                      'house'.tr +
                                                          ' / ' +
                                                          'floor'.tr +
                                                          ' ' +
                                                          'number'.tr,
                                                      style: robotoRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          color: Theme.of(
                                                                  context)
                                                              .disabledColor),
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: MyTextField(
                                                            hintText:
                                                                'house'.tr,
                                                            inputType:
                                                                TextInputType
                                                                    .text,
                                                            focusNode:
                                                                _houseNode,
                                                            nextFocus:
                                                                _floorNode,
                                                            controller:
                                                                _houseController,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        Expanded(
                                                          child: MyTextField(
                                                            hintText:
                                                                'floor'.tr,
                                                            inputType:
                                                                TextInputType
                                                                    .text,
                                                            focusNode:
                                                                _floorNode,
                                                            inputAction:
                                                                TextInputAction
                                                                    .done,
                                                            controller:
                                                                _floorController,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE),
                                                  ])
                                            : SizedBox(),

                                        // Time Slot
                                        storeController.store != null && storeController
                                            .store.scheduleOrder !=null &&
                                                storeController
                                                    .store.scheduleOrder
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                    Text('preference_time'.tr,
                                                        style: robotoMedium),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    SizedBox(
                                                      height: 50,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        itemCount: 2,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return SlotWidget(
                                                            title: index == 0
                                                                ? 'today'.tr
                                                                : 'tomorrow'.tr,
                                                            isSelected:
                                                                orderController
                                                                        .selectedDateSlot ==
                                                                    index,
                                                            onTap: () => orderController
                                                                .updateDateSlot(
                                                                    index,
                                                                    storeController
                                                                        .store
                                                                        .orderPlaceToScheduleInterval),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    SizedBox(
                                                      height: 50,
                                                      child: ((orderController
                                                                          .selectedDateSlot ==
                                                                      0 &&
                                                                  _todayClosed) ||
                                                              (orderController
                                                                          .selectedDateSlot ==
                                                                      1 &&
                                                                  _tomorrowClosed))
                                                          ? Center(
                                                              child: Text(_module
                                                                      .showRestaurantText
                                                                  ? 'restaurant_is_closed'
                                                                      .tr
                                                                  : 'store_is_closed'
                                                                      .tr))
                                                          : orderController
                                                                      .timeSlots !=
                                                                  null
                                                              ? orderController
                                                                          .timeSlots
                                                                          .length >
                                                                      0
                                                                  ? ListView
                                                                      .builder(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          BouncingScrollPhysics(),
                                                                      itemCount: orderController
                                                                          .timeSlots
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        return SlotWidget(
                                                                          title: (index == 0 && orderController.selectedDateSlot == 0 && storeController.isStoreOpenNow(storeController.store.active, storeController.store.schedules) && (_module.orderPlaceToScheduleInterval ? storeController.store.orderPlaceToScheduleInterval == 0 : true))
                                                                              ? 'now'.tr
                                                                              : '${DateConverter.dateToTimeOnly(orderController.timeSlots[index].startTime)} '
                                                                                  '- ${DateConverter.dateToTimeOnly(orderController.timeSlots[index].endTime)}',
                                                                          isSelected:
                                                                              orderController.selectedTimeSlot == index,
                                                                          onTap: () =>
                                                                              orderController.updateTimeSlot(index),
                                                                        );
                                                                      },
                                                                    )
                                                                  : Center(
                                                                      child:
                                                                          Text('no_slot_available'.tr))
                                                              : Center(child: CircularProgressIndicator()),
                                                    ),
                                                    SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_LARGE),
                                                  ])
                                            : SizedBox(),

                                        // Coupon
                                        GetBuilder<CouponController>(
                                          builder: (couponController) {
                                            return Row(children: [
                                              Expanded(
                                                child: SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller:
                                                        _couponController,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .deny(RegExp(
                                                              regexToRemoveEmoji))
                                                    ],
                                                    //   inputFormatters: [FilteringTextInputFormatter.deny(RegExp(regexToRemoveEmoji))],
                                                    keyboardType:
                                                        TextInputType.text,
                                                    style: robotoRegular.copyWith(
                                                        height: ResponsiveHelper
                                                                .isMobile(
                                                                    context)
                                                            ? null
                                                            : 2),
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'enter_promo_code'.tr,
                                                      hintStyle: robotoRegular
                                                          .copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .hintColor),
                                                      isDense: true,
                                                      filled: true,
                                                      enabled: couponController
                                                              .discount ==
                                                          0,
                                                      fillColor:
                                                          Theme.of(context)
                                                              .cardColor,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .horizontal(
                                                          left: Radius.circular(
                                                              Get.find<LocalizationController>()
                                                                      .isLtr
                                                                  ? 10
                                                                  : 0),
                                                          right: Radius.circular(
                                                              Get.find<LocalizationController>()
                                                                      .isLtr
                                                                  ? 0
                                                                  : 10),
                                                        ),
                                                        borderSide:
                                                            BorderSide.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  String _couponCode =
                                                      _couponController.text
                                                          .trim();
                                                  if (couponController
                                                              .discount <
                                                          1 &&
                                                      !couponController
                                                          .freeDelivery) {
                                                    if (_couponCode
                                                            .isNotEmpty &&
                                                        !couponController
                                                            .isLoading) {
                                                      couponController
                                                          .applyCoupon(
                                                              _couponCode,
                                                              (_price -
                                                                      _discount) +
                                                                  _addOns,
                                                              _deliveryCharge,
                                                              storeController
                                                                  .store.id)
                                                          .then((discount) {
                                                        if (discount > 0) {
                                                          showCustomSnackBar(
                                                            '${'you_got_discount_of'.tr} ${PriceConverter.convertPrice(discount)}',
                                                            isError: false,
                                                          );
                                                        }
                                                      });
                                                    } else if (_couponCode
                                                        .isEmpty) {
                                                      showCustomSnackBar(
                                                          'enter_a_coupon_code'
                                                              .tr);
                                                    }
                                                  } else {
                                                    couponController
                                                        .removeCouponData(true);
                                                  }
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 100,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.grey[
                                                              Get.isDarkMode
                                                                  ? 800
                                                                  : 200],
                                                          spreadRadius: 1,
                                                          blurRadius: 5)
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.horizontal(
                                                      left: Radius.circular(
                                                          Get.find<LocalizationController>()
                                                                  .isLtr
                                                              ? 0
                                                              : 10),
                                                      right: Radius.circular(
                                                          Get.find<LocalizationController>()
                                                                  .isLtr
                                                              ? 10
                                                              : 0),
                                                    ),
                                                  ),
                                                  child: (couponController
                                                                  .discount <=
                                                              0 &&
                                                          !couponController
                                                              .freeDelivery)
                                                      ? !couponController
                                                              .isLoading
                                                          ? Text(
                                                              'apply'.tr,
                                                              style: robotoMedium.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .cardColor),
                                                            )
                                                          : CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .white))
                                                      : Icon(Icons.clear,
                                                          color: Colors.white),
                                                ),
                                              ),
                                            ]);
                                          },
                                        ),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE),

                                        (orderController.orderType !=
                                                    'take_away' &&
                                                Get.find<SplashController>()
                                                        .configModel
                                                        .dmTipsStatus ==
                                                    1)
                                            ? Container(
                                                color:
                                                    Theme.of(context).cardColor,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: Dimensions
                                                        .PADDING_SIZE_LARGE,
                                                    horizontal: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          'delivery_man_tips'
                                                              .tr,
                                                          style: robotoMedium),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_SMALL),
                                                      Container(
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .cardColor,
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                  .RADIUS_SMALL),
                                                          border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        child: TextField(
                                                          controller:
                                                              _tipController,
                                                          onChanged:
                                                              (String value) {
                                                            if (value
                                                                .isNotEmpty) {
                                                              orderController
                                                                  .addTips(double
                                                                      .parse(
                                                                          value));
                                                            } else {
                                                              orderController
                                                                  .addTips(0.0);
                                                            }
                                                          },
                                                          maxLength: 10,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    r'[0-9.]'))
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                'enter_amount'
                                                                    .tr,
                                                            counterText: '',
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .RADIUS_SMALL),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .PADDING_SIZE_DEFAULT),
                                                      SizedBox(
                                                        height: 55,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          shrinkWrap: true,
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          itemCount:
                                                              AppConstants
                                                                  .tips.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return TipsWidget(
                                                              title: AppConstants
                                                                  .tips[index]
                                                                  .toString(),
                                                              isSelected:
                                                                  orderController
                                                                          .selectedTips ==
                                                                      index,
                                                              onTap: () {
                                                                orderController
                                                                    .updateTips(
                                                                        index);
                                                                orderController.addTips(
                                                                    AppConstants
                                                                        .tips[
                                                                            index]
                                                                        .toDouble());
                                                                _tipController
                                                                        .text =
                                                                    orderController
                                                                        .tips
                                                                        .toString();
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ]),
                                              )
                                            : SizedBox.shrink(),
                                        SizedBox(
                                            height: (orderController
                                                            .orderType !=
                                                        'take_away' &&
                                                    Get.find<SplashController>()
                                                            .configModel
                                                            .dmTipsStatus ==
                                                        1)
                                                ? Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL
                                                : 0),

                                        Text('choose_payment_method'.tr,
                                            style: robotoMedium),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        _isWalletActive
                                            ? PaymentButton(
                                                icon: Images.wallet,
                                                title: 'wallet_payment'.tr,
                                                subtitle:
                                                    'pay_from_your_existing_balance'
                                                        .tr,
                                                isSelected: orderController
                                                        .paymentMethodIndex ==
                                                    2,
                                                onTap: () => orderController
                                                    .setPaymentMethod(2),
                                              )
                                            : SizedBox(),
                                        _isCashOnDeliveryActive
                                            ? PaymentButton(
                                                icon: Images.cash_on_delivery,
                                                title: 'cash_on_delivery'.tr,
                                                subtitle:
                                                    'pay_your_payment_after_getting_item'
                                                        .tr,
                                                isSelected: orderController
                                                        .paymentMethodIndex ==
                                                    0,
                                                onTap: () => orderController
                                                    .setPaymentMethod(0),
                                              )
                                            : SizedBox(),
                                        _isDigitalPaymentActive
                                            ? PaymentButton(
                                                icon: Images.digital_payment,
                                                title: 'digital_payment'.tr,
                                                subtitle:
                                                    'faster_and_safe_way'.tr,
                                                isSelected: orderController
                                                        .paymentMethodIndex ==
                                                    1,
                                                onTap: () => orderController
                                                    .setPaymentMethod(1),
                                              )
                                            : SizedBox(),

                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE),

                                        CustomTextField(
                                          controller: _noteController,
                                          hintText: 'additional_note'.tr,
                                          maxLines: 3,
                                          inputType: TextInputType.multiline,
                                          inputAction: TextInputAction.newline,
                                          capitalization:
                                              TextCapitalization.sentences,
                                        ),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_LARGE),

                                        Get.find<SplashController>()
                                                .configModel
                                                .moduleConfig
                                                .module
                                                .orderAttachment
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text('prescription'.tr,
                                                        style: robotoMedium),
                                                    SizedBox(
                                                        width: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    Text(
                                                      '(${'max_size_2_mb'.tr})',
                                                      style: robotoRegular
                                                          .copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeExtraSmall,
                                                        color: Theme.of(context)
                                                            .errorColor,
                                                      ),
                                                    ),
                                                  ]),
                                                  SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  ImagePickerWidget(
                                                    image: '',
                                                    rawFile: orderController
                                                        .rawAttachment,
                                                    onTap: () => orderController
                                                        .pickImage(),
                                                  ),
                                                ],
                                              )
                                            : SizedBox(),

                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  _module.addOn
                                                      ? 'subtotal'.tr
                                                      : 'item_price'.tr,
                                                  style: robotoMedium),
                                              Text(
                                                  PriceConverter.convertPrice(
                                                      _subTotal),
                                                  style: robotoMedium),
                                            ]),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('discount'.tr,
                                                  style: robotoRegular),
                                              Text(
                                                  '(-) ${PriceConverter.convertPrice(_discount)}',
                                                  style: robotoRegular),
                                            ]),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        (couponController.discount > 0 ||
                                                couponController.freeDelivery)
                                            ? Column(children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('coupon_discount'.tr,
                                                          style: robotoRegular),
                                                      (couponController
                                                                      .coupon !=
                                                                  null &&
                                                              couponController
                                                                      .coupon
                                                                      .couponType ==
                                                                  'free_delivery')
                                                          ? Text(
                                                              'free_delivery'
                                                                  .tr,
                                                              style: robotoRegular.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            )
                                                          : Text(
                                                              '(-) ${PriceConverter.convertPrice(couponController.discount)}',
                                                              style:
                                                                  robotoRegular,
                                                            ),
                                                    ]),
                                                SizedBox(
                                                    height: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                              ])
                                            : SizedBox(),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('vat_tax'.tr,
                                                  style: robotoRegular),
                                              Text(
                                                  '(+) ${PriceConverter.convertPrice(_tax)}',
                                                  style: robotoRegular),
                                            ]),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL),

                                        (Get.find<SplashController>()
                                                    .configModel
                                                    .dmTipsStatus ==
                                                1)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('delivery_man_tips'.tr,
                                                      style: robotoRegular),
                                                  Text(
                                                      '(+) ${PriceConverter.convertPrice(orderController.tips)}',
                                                      style: robotoRegular),
                                                ],
                                              )
                                            : SizedBox.shrink(),
                                        SizedBox(
                                            height: Get.find<SplashController>()
                                                        .configModel
                                                        .dmTipsStatus ==
                                                    1
                                                ? Dimensions.PADDING_SIZE_SMALL
                                                : 0.0),

                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('delivery_fee'.tr,
                                                  style: robotoRegular),
                                              _deliveryCharge == -1
                                                  ? Text(
                                                      'calculating'.tr,
                                                      style: robotoRegular
                                                          .copyWith(
                                                              color:
                                                                  Colors.red),
                                                    )
                                                  : (_deliveryCharge == 0 ||
                                                          (couponController
                                                                      .coupon !=
                                                                  null &&
                                                              couponController
                                                                      .coupon
                                                                      .couponType ==
                                                                  'free_delivery'))
                                                      ? Text(
                                                          'free'.tr,
                                                          style: robotoRegular.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )
                                                      : Text(
                                                          '(+) ${PriceConverter.convertPrice(_deliveryCharge)}',
                                                          style: robotoRegular,
                                                        ),
                                            ]),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          child: Divider(
                                              thickness: 1,
                                              color: Theme.of(context)
                                                  .hintColor
                                                  .withOpacity(0.5)),
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'total_amount'.tr,
                                                style: robotoMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Text(
                                                PriceConverter.convertPrice(
                                                    _total),
                                                style: robotoMedium.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ]),

                                        ResponsiveHelper.isDesktop(context)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: Dimensions
                                                        .PADDING_SIZE_LARGE),
                                                child: _orderPlaceButton(
                                                  orderController,
                                                  storeController,
                                                  locationController,
                                                  _todayClosed,
                                                  _tomorrowClosed,
                                                  _orderAmount,
                                                  _deliveryCharge,
                                                  _tax,
                                                  _discount,
                                                  _total,
                                                ))
                                            : SizedBox(),
                                      ]),
                                )),
                              ))),
                              (_charge != -1
                                  ? ResponsiveHelper.isDesktop(context)
                                      ? SizedBox()
                                      : _orderPlaceButton(
                                          orderController,
                                          storeController,
                                          locationController,
                                          _todayClosed,
                                          _tomorrowClosed,
                                          _orderAmount,
                                          _deliveryCharge,
                                          _tax,
                                          _discount,
                                          _total,
                                        )
                                  : SizedBox()),
                            ],
                          )
                        : Center(child: CircularProgressIndicator());
                  });
                });
              });
            })
          : NotLoggedInScreen(),
    );
  }

  void _callback(bool isSuccess, String message, String orderID) async {
    if (isSuccess) {
      if (widget.fromCart) {
        Get.find<CartController>().clearCartList();
      }
      Get.find<OrderController>().stopLoader();
      HomeScreen.loadData(true);
      if (_isCashOnDeliveryActive &&
          Get.find<OrderController>().paymentMethodIndex == 1) {
        if (GetPlatform.isWeb) {
          Get.back();
          String hostname = html.window.location.hostname;
          String protocol = html.window.location.protocol;
          String selectedUrl =
              '${AppConstants.BASE_URL}/payment-mobile?order_id=$orderID&customer_id=${Get.find<UserController>().userInfoModel.id}&&callback=$protocol//$hostname${RouteHelper.orderSuccess}?id=$orderID&status=';
          html.window.open(selectedUrl, "_self");
        } else {
          Get.offNamed(RouteHelper.getPaymentRoute(
            orderID,
            Get.find<UserController>().userInfoModel.id,
            Get.find<OrderController>().orderType,
          ));
        }
      } else {
        Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID));
      }
      Get.find<OrderController>().clearPrevData();
      Get.find<CouponController>().removeCouponData(false);
      Get.find<OrderController>().updateTips(-1, notify: false);
    } else {
      showCustomSnackBar(message);
    }
  }

  Widget _orderPlaceButton(
      OrderController orderController,
      StoreController storeController,
      LocationController locationController,
      bool todayClosed,
      bool tomorrowClosed,
      double orderAmount,
      double deliveryCharge,
      double tax,
      double discount,
      double total) {
    return Container(
      width: Dimensions.WEB_MAX_WIDTH,
      alignment: Alignment.center,
      padding: ResponsiveHelper.isDesktop(context)
          ? null
          : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: /*!orderController.isLoading ?*/
          CustomButton(
              buttonText: 'confirm_order'.tr,
              onPressed: () {
                bool checkStoreIsOnlyFood = false;
                try {
                  int moduleId = Get.find<StoreController>().store != null
                      ? Get.find<StoreController>().store.moduleId
                      : 0;
                  if (Get.find<SplashController>().moduleList != null) {
                    Get.find<SplashController>()
                        .moduleList
                        .forEach((storeCategory) => {
                              if (storeCategory.id == moduleId)
                                {
                                  if (storeCategory.moduleType == 'food' ||
                                      storeCategory.moduleType == 'Food')
                                    {checkStoreIsOnlyFood = true}
                                }
                            });
                  }
                } catch (e) {}

                bool _isAvailable = true;
                DateTime _scheduleStartDate = DateTime.now();
                DateTime _scheduleEndDate = DateTime.now();

                if (orderController.timeSlots == null ||
                    orderController.timeSlots.length == 0) {
                  _isAvailable = false;
                } else {
                  DateTime _date = orderController.selectedDateSlot == 0
                      ? DateTime.now()
                      : DateTime.now().add(Duration(days: 1));
                  DateTime _startTime = orderController
                      .timeSlots[orderController.selectedTimeSlot].startTime;
                  DateTime _endTime = orderController
                      .timeSlots[orderController.selectedTimeSlot].endTime;
                  _scheduleStartDate = DateTime(_date.year, _date.month,
                      _date.day, _startTime.hour, _startTime.minute + 1);
                  _scheduleEndDate = DateTime(_date.year, _date.month,
                      _date.day, _endTime.hour, _endTime.minute + 1);
                  for (CartModel cart in _cartList) {
                    if (!DateConverter.isAvailable(
                          cart.item.availableTimeStarts,
                          cart.item.availableTimeEnds,
                          time: storeController.store.scheduleOrder
                              ? _scheduleStartDate
                              : null,
                        ) &&
                        !DateConverter.isAvailable(
                          cart.item.availableTimeStarts,
                          cart.item.availableTimeEnds,
                          time: storeController.store.scheduleOrder
                              ? _scheduleEndDate
                              : null,
                        )) {
                      _isAvailable = false;
                      break;
                    }
                  }
                }
                if (!_isCashOnDeliveryActive &&
                    !_isDigitalPaymentActive &&
                    !_isWalletActive) {
                  showCustomSnackBar('no_payment_method_is_enabled'.tr);
                } else if (orderAmount < storeController.store.minimumOrder) {
                  showCustomSnackBar(
                      '${'minimum_order_amount_is'.tr} ${storeController.store.minimumOrder}');
                } else if (checkStoreIsOnlyFood &&
                        (orderController.selectedDateSlot == 0 &&
                            todayClosed) ||
                    (orderController.selectedDateSlot == 1 && tomorrowClosed)) {
                  showCustomSnackBar(Get.find<SplashController>()
                          .configModel
                          .moduleConfig
                          .module
                          .showRestaurantText
                      ? 'restaurant_is_closed'.tr
                      : 'store_is_closed'.tr);
                } else if (checkStoreIsOnlyFood &&
                    (orderController.timeSlots == null ||
                        orderController.timeSlots.length == 0)) {

                  if (storeController.store.scheduleOrder) {
                    showCustomSnackBar('select_a_time'.tr);
                  } else {
                    showCustomSnackBar(Get.find<SplashController>()
                            .configModel
                            .moduleConfig
                            .module
                            .showRestaurantText
                        ? 'restaurant_is_closed'.tr
                        : 'store_is_closed'.tr);
                  }
                } else if (checkStoreIsOnlyFood && !_isAvailable) {
                  showCustomSnackBar(
                      'one_or_more_products_are_not_available_for_this_selected_time'
                          .tr);
                } else if (orderController.orderType != 'take_away' &&
                    orderController.distance == -1 &&
                    deliveryCharge == -1) {
                  showCustomSnackBar('delivery_fee_not_set_yet'.tr);
                } else {
                  List<Cart> carts = [];
                  for (int index = 0; index < _cartList.length; index++) {
                    CartModel cart = _cartList[index];
                    List<int> _addOnIdList = [];
                    List<int> _addOnQtyList = [];
                    cart.addOnIds.forEach((addOn) {
                      _addOnIdList.add(addOn.id);
                      _addOnQtyList.add(addOn.quantity);
                    });
                    carts.add(Cart(
                      cart.isCampaign ? null : cart.item.id,
                      cart.isCampaign ? cart.item.id : null,
                      cart.discountedPrice.toString(),
                      '',
                      cart.variation,
                      cart.quantity,
                      _addOnIdList,
                      cart.addOns,
                      _addOnQtyList,
                    ));
                  }
                  AddressModel _address;
                  if (locationController.addressList != null &&
                      locationController.addressList.length > 0) {
                   if(orderController.addressIndex == -1){
                     if(Final_index==0){
                     _address =Get.find<LocationController>().getUserAddress();}
                     else {
                       _address = locationController.addressList[Final_index];
                     }
                   }else {
                     _address = locationController.addressList[orderController.addressIndex];
                   }
                   /* _address = orderController.addressIndex == -1
                        ? Get.find<LocationController>().getUserAddress()
                        : locationController
                            .addressList[orderController.addressIndex];*/
                    print("index>>" + _address.address.toString());
                    orderController.placeOrder(
                        PlaceOrderBody(
                          cart: carts,
                          couponDiscountAmount:
                          Get
                              .find<CouponController>()
                              .discount,
                         /* distance: orderController.distance,*/
                          scheduleAt: !storeController.store.scheduleOrder
                              ? null
                              : (orderController.selectedDateSlot == 0 &&
                              orderController.selectedTimeSlot == 0)
                              ? null
                              : DateConverter.dateToDateAndTime(
                              _scheduleEndDate),
                          orderAmount: total,
                          orderNote: _noteController.text,
                          orderType: orderController.orderType,
                          paymentMethod: orderController.paymentMethodIndex == 0
                              ? 'cash_on_delivery'
                              : orderController.paymentMethodIndex == 1
                              ? 'digital_payment'
                              : 'wallet',
                          couponCode: (Get
                              .find<CouponController>()
                              .discount >
                              0 ||
                              (Get
                                  .find<CouponController>()
                                  .coupon != null &&
                                  Get
                                      .find<CouponController>()
                                      .freeDelivery))
                              ? Get
                              .find<CouponController>()
                              .coupon
                              .code
                              : null,
                          storeId: _cartList[0].item.storeId,
                          address: _address.address,
                          latitude: _address.latitude,
                          longitude: _address.longitude,
                          addressType: _address.addressType,
                          contactPersonName: _address.contactPersonName ??
                              '${Get
                                  .find<UserController>()
                                  .userInfoModel
                                  .fName} '
                                  '${Get
                                  .find<UserController>()
                                  .userInfoModel
                                  .lName}',
                          contactPersonNumber: _address.contactPersonNumber ??
                              Get
                                  .find<UserController>()
                                  .userInfoModel
                                  .phone,
                          streetNumber: _streetNumberController.text.trim() ??
                              '',
                          house: _houseController.text.trim(),
                          floor: _floorController.text.trim(),
                          discountAmount: discount,
                          taxAmount: tax,
                          receiverDetails: null,
                          parcelCategoryId: null,
                          chargePayer: null,
                          dmTips: _tipController.text.trim(),
                        ),
                        _callback);
                  } else {
                    showCustomSnackBar('Please Delivery Address !'.tr);
                  }
                }
              }) /*: Center(child: CircularProgressIndicator())*/,
    );
  }

  void showCustomDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController streetController = TextEditingController();
    TextEditingController houseController = TextEditingController();
    TextEditingController floorController = TextEditingController();

    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Container(
            height: 600,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  child: Column(children: [
                    Column(children: [
                      Center(
                          child: Text('receiver_information'.tr,
                              style: robotoMedium)),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    ]),
                    Column(children: [
                      Center(
                          child: Text('destination_information'.tr,
                              style: robotoMedium)),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      TextFieldShadow(
                        child: MyTextField(
                          hintText: "${'street_number'.tr} (${'optional'.tr})",
                          inputType: TextInputType.streetAddress,
                          focusNode: _streetNode,
                          nextFocus: _houseNode,
                          inputAction: TextInputAction.done,
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
                              inputAction: TextInputAction.done,
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
                  ]),
                ),
              ),
              color: Color(0xFF303030),
            ),
          ),
        );
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
}
