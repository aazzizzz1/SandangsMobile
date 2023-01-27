import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandangs/pages/cart_screen.dart';
import 'package:sandangs/widget/provider/cart_provider.dart';

class AppBarBack extends StatelessWidget with PreferredSizeWidget{
  const AppBarBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var keranjang = Provider.of<KeranjangProv>(context, listen: true);
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
          child: keranjang.jumlah > 0 ? Badge(
              badgeColor: Colors.orange,
              animationType: BadgeAnimationType.slide,
              borderSide: BorderSide(color: Colors.white),
              badgeContent: Text(
                // listKeranjang.length.toString(),
                keranjang.jumlah.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              position: BadgePosition.topEnd(top: 0, end: 13),
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
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen()
                  ),
                );
              },
            ),
          ): ElevatedButton(
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
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartScreen()
                ),
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
