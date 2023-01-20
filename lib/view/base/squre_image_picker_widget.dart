import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sixam_mart/view/base/custom_image.dart';

class SqureImagePickerWidget extends StatelessWidget {
  final Uint8List rawFile;
  final String image;
  final Function onTap;
  SqureImagePickerWidget({@required this.rawFile, @required this.image, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    print("image??"+image);
    print("image??"+rawFile.toString());

    return Center(child: Stack(children: [
      ClipOval(child: rawFile != null ? Image.memory(
        rawFile, width: 100, height: 100, fit: BoxFit.fill,
      ) : CustomImage(image: image, height: 100, width: 100)),

      Positioned(
        bottom: 0, right: 0, top: 0, left: 0,
        child: InkWell(
          onTap: onTap,
          child: Container(

            child: Container(
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
              ),

            ),
          ),
        ),
      ),
    ]));
  }
}
