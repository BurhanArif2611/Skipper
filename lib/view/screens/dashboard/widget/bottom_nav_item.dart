import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class BottomNavItem extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  final bool isSelected;
  final bool countVisible;
  final String title;
  final String ImagePath;

  BottomNavItem(
      {@required this.iconData,
      this.onTap,
      this.isSelected = false,
      this.countVisible,
      this.title,
      this.ImagePath
      });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {onTap();},

        child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
        /*IconButton(
          icon: Icon(iconData,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              size: 25),
          onPressed: onTap,
        ),*/
        Image.asset(ImagePath, color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            height: 30, width: 30),
        Text(title,style: robotoRegular.copyWith(color: isSelected ? Theme.of(context).primaryColor : Colors.grey)),
      ]),
    ));
  }
}
