import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';

class BottomAppbarDetailProduk extends StatelessWidget {
  const BottomAppbarDetailProduk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BottomAppBar(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0,3),
                blurRadius: 3,
                spreadRadius: 3,
              )
            ]
        ),
        height: size.height*0.07,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width*0.18,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: secondaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.accessibility_outlined,
                    color: secondaryColor,
                  ),
                  iconSize: 25,
                  onPressed: (){},
                ),
              ),
              Container(
                width: size.width*0.18,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal:5,vertical: 5),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  iconSize: 25,
                  onPressed: (){},
                ),
              ),
              Container(
                width: size.width*0.5,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal:5,vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: orangePrice,
                ),
                child: TextButton(
                  onPressed: (){},
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
