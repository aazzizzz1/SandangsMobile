import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/pages/cart_screen.dart';
import 'package:sandangs/widget/provider/cart_provider.dart';
import 'package:badges/badges.dart';

class AppBarApps extends StatefulWidget with PreferredSizeWidget{
  const AppBarApps({Key? key,}) : super(key: key);

  @override
  State<AppBarApps> createState() => _AppBarAppsState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarAppsState extends State<AppBarApps> {
  @override
  Widget build(BuildContext context) {
    var keranjang = Provider.of<KeranjangProv>(context, listen: true);
    keranjang.jumlahplus();

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
          child: keranjang.jumlah > 0 ? Badge(
            badgeColor: Colors.orange,
            animationType: BadgeAnimationType.slide,
            borderSide: BorderSide(color: Colors.white),
            badgeContent: Text(
              keranjang.jumlah.toString(),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            position: BadgePosition.topEnd(top: 0, end: 5),
            child: IconButton(
              icon  : Icon(
                Icons.shopping_cart,
                size: 25,
                color: secondaryColor,
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
          ) : IconButton(
            icon  : Icon(
              Icons.shopping_cart,
              size: 25,
              color: secondaryColor,
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
}
