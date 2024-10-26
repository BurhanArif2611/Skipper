import 'package:flutter/material.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final IconData icon;
  final Color disable;
  CustomButton({this.onPressed, @required this.buttonText, this.transparent = false, this.margin, this.width, this.height,
    this.fontSize, this.radius = Dimensions.RADIUS_SMALL, this.icon, this.disable});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Your action here
        onPressed();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        // Prevent shadow on button
        elevation: MaterialStateProperty.all(0),
        // Overlay color for button's splash effect
        overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) return Colors.transparent;
            return null; // Defer to the widget's default.
          },
        ),
      ),
      child: Ink(
        decoration:transparent
            ? null : BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8CA0A), Color(0xFFFFE166),Color(0xFFDCB822),Color(0xFFFFE166),],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Container(
            height: height != null ? height : 50,
          constraints: BoxConstraints(minWidth: 88, minHeight: 36),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          alignment: Alignment.center,
          child: Text(
            buttonText ??'',
            textAlign: TextAlign.center,
            style: robotoBlack.copyWith(
          color: transparent ? Theme.of(context).primaryColor : Theme.of(context).hintColor,
        fontSize: fontSize != null ? fontSize : Dimensions.fontSizeLarge,
      ),
          ),
        ),
      ),
    );

    /*final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null ? Theme.of(context).disabledColor : transparent
          ? Colors.transparent : Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width : Dimensions.WEB_MAX_WIDTH, height != null ? height : 50),
      padding: EdgeInsets.zero,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),

      ),
    );
    return Center(child: SizedBox(width: width != null ? width : Dimensions.WEB_MAX_WIDTH, child: Padding(
      padding: margin == null ? EdgeInsets.all(0) : margin,
      child: TextButton(
        onPressed: onPressed,
        style: _flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null ? Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Icon(icon, color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
          ) : SizedBox(),
          Text(buttonText ??'', textAlign: TextAlign.center, style: robotoBold.copyWith(
            color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
            fontSize: fontSize != null ? fontSize : Dimensions.fontSizeLarge,
          )),
        ]),
      ),
    )));*/
  }
}
