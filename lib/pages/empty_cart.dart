import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: secondaryColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Keranjang',
            style: tittleDark,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('lib/assets/images/empty-cart.png'),
            ),
          ),
        ),
        Text(
          'Your Cart Is Empty',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: secondaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Sepertinya anda belum menambahkan produk ke keranjang anda',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}