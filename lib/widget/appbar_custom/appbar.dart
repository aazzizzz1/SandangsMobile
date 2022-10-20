import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';

class AppBarApps extends StatelessWidget with PreferredSizeWidget{
  const AppBarApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Image.asset(
        'lib/assets/images/textlogo.png',
        width: 130,
        height: 130,
      ),
      automaticallyImplyLeading: false,
      actions: [
        Center(
          child: IconButton(
            icon  : Icon(
              Icons.shopping_cart,
              size: 25,
              color: secondaryColor,
            ),
            onPressed: (){},
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
