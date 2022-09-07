import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../controller/cart_controller.dart';
import '../../../../util/styles.dart';

class BottomNavItem extends StatelessWidget {
  final IconData iconData;
  final Function onTap;
  final bool isSelected;
  final bool countVisible;
  BottomNavItem({@required this.iconData, this.onTap, this.isSelected = false, this.countVisible});

  @override
  Widget build(BuildContext context) {
     double size=25;
     bool fromStore=false;
    return
      Expanded(
      child: Stack(clipBehavior: Clip.none,alignment: Alignment.center, children: [
        IconButton(
        icon: Icon(iconData, color: isSelected ? Theme.of(context).primaryColor : Colors.grey, size: 25),
        onPressed: onTap,
      ),
        (countVisible?
        GetBuilder<CartController>(builder: (cartController) {
        return cartController.cartList.length > 0 ? Positioned(
          top: 5, right: 20,
          child:
          Container(
            height: size < 20 ? 10 : size/2, width: size < 20 ? 10 : size/2, alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle, color: fromStore ? Theme.of(context).cardColor : Theme.of(context).primaryColor,
              border: Border.all(width: size < 20 ? 0.7 : 1, color: fromStore ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
            ),
            child: Text(
              cartController.cartList.length.toString(),
              style: robotoRegular.copyWith(
                fontSize: size < 20 ? size/3 : size/3.8,
                color: fromStore ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
              ),
            ),
          ),
        ) : SizedBox();
      }):Text("")),
  ]),
    );
  }
}
