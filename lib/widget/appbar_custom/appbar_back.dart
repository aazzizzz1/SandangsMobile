import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';

class AppBarBack extends StatelessWidget with PreferredSizeWidget{
  const AppBarBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Stack(
        children: <Widget>[
          ElevatedButton(
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 25,
            ),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(5),
              primary: Colors.black38,
              onPrimary: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      actions: [
        Center(
          child: ElevatedButton(
            child: Icon(
              Icons.shopping_cart,
              size: 25,
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(5),
              primary: Colors.black38,
              onPrimary: Colors.white,
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
