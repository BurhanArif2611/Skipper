import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sixam_mart/util/styles.dart';

import '../../util/app_constants.dart';
import '../../util/dimensions.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String text;
  final String buttonText;
  final String cancelButtonText;
  final Function cancelOnPress;
  final Function onPress;

  static void presentError(BuildContext context, String error) {
    showDialog(
        context: context,
        builder: (context) =>
            CommonDialog(
              title: AppConstants.DIALOG_ERROR_TITLE,
              text: error ?? "",
            ));
  }

  static void info(BuildContext context, String error, {Function onPress}) {
    showDialog(
        context: context,
        builder: (context) =>
            CommonDialog(
                title: AppConstants.APP_NAME,
                text: error ?? "",
                onPress: onPress));
  }

  static void confirm(BuildContext context, String message,
      {Function onPress}) {
    showDialog(
        context: context,
        builder: (context) =>
            CommonDialog(
                title: AppConstants.APP_NAME,
                cancelButtonText: AppConstants.CANCEL_BUTTON_TITLE,
                text: message,
                onPress: onPress));
  } static void share(BuildContext context, String message,
      {Function onPress}) {
    Share.share(
        '' + message);
  }

  const CommonDialog({Key key,
    this.title,
    this.text = '',
    this.onPress,
    this.cancelOnPress,
    this.buttonText,
    this.cancelButtonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: title != null ? Text(title ?? '') : null,
        content: Text(text),
        actions: <Widget>[
          if (cancelButtonText != null)
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).maybePop();
                if (cancelOnPress != null) cancelOnPress();
              },
              child: Text(
                cancelButtonText,
                style:  robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeSmall),
              ),
            ),
          CupertinoButton(
            onPressed: () {
              Navigator.of(context).maybePop();
              if (onPress != null) onPress();
            },
            child: Text(
                buttonText ?? AppConstants.DIALOG_POSITIVE_BUTTON,
                style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeSmall) ,
            ),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: title != null ? Text(title ?? '') : null,
        content: Text(
          text,
          style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeSmall),
        ),
        actions: <Widget>[
          if (cancelButtonText != null)
            TextButton(
              onPressed: () {
                Navigator.of(context).maybePop();
                if (cancelOnPress != null) cancelOnPress();
              },
              child: Text(
                cancelButtonText,
                style:robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeSmall),
              ),
            ),
          TextButton(
            onPressed: () {
              Navigator.of(context).maybePop();
              if (onPress != null) onPress();
            },
            child: Text(
              buttonText ?? AppConstants.DIALOG_POSITIVE_BUTTON,
              style: robotoMedium.copyWith(color: Theme.of(context).hintColor,fontSize: Dimensions.fontSizeSmall),
            ),
          ),
        ],
      );
    }
  }
}
