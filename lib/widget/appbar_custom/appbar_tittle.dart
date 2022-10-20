import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';

class AppBarTittle extends StatelessWidget with PreferredSizeWidget{
  const AppBarTittle({Key? key}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: secondaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        color: Colors.white,
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      title: Image.asset(
        'lib/assets/images/sandangsWhite.png',
        width: 130,
        height: 130,
      ),
      actions: [
        Center(
          child: IconButton(
            icon  : Icon(
              Icons.shopping_cart,
              size: 25,
              color: Colors.white,
            ),
            onPressed: (){},
          ),
        )
      ],
    );

  }
}
