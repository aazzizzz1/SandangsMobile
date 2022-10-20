import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';

class AppBarTittleCustom extends StatelessWidget with PreferredSizeWidget{
  const AppBarTittleCustom({Key? key, required this.tittle}) : super(key: key);
  final String tittle;

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
      title: Text(
        tittle,
        style: tittleLight,
      ),
    );

  }
}
