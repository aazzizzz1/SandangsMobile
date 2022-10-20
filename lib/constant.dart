import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

Color secondaryColor = fromCssColor('#0F70B7');
Color thirdColor = fromCssColor('#1F3979');
Color primaryColor = fromCssColor('#0587E0');
Color greyCustom = const Color(0xd8e0e0e0);
Color layer = fromCssColor('#DDF1FF');
Color subtittle = fromCssColor('#434343');
Color darkButton = const Color.fromRGBO(30, 58, 121, 1);
Color lightButton = const Color.fromRGBO(13, 166, 224, 1);
Color orangePrice = fromCssColor('#D97E37');
Color blackColor = const Color(0xff000000);



TextStyle titleVerticalCardTextStyle = TextStyle(
  color: blackColor,
  fontWeight: FontWeight.w500,
  fontSize: 15,
);
TextStyle subtitleVerticalCardTextStyle = TextStyle(
  color: blackColor,
  fontWeight: FontWeight.w300,
  fontSize: 12,
);

const buttonCard = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromRGBO(13, 166, 224, 1),Color.fromRGBO(30, 58, 121, 1)],
);

TextStyle hargaCard = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  fontFamily: 'Poppins',
  color : orangePrice,
);

TextStyle tittleLight = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w600,
  fontSize: 20,
  fontFamily: 'Poppins',
);
TextStyle tittleDark = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.w600,
  fontSize: 20,
  fontFamily: 'Poppins',
);

TextStyle subTittle = TextStyle(
  color: subtittle,
  fontWeight: FontWeight.w600,
  fontSize: 20,
  fontFamily: 'Poppins',
);
TextStyle nameCard = TextStyle(
  color: subtittle,
  fontWeight: FontWeight.w600,
  fontSize: 14,
);
TextStyle ratingCard = TextStyle(
  color: subtittle,
  fontWeight: FontWeight.w400,
  fontSize: 13,
);
TextStyle bioCard = TextStyle(
  color: subtittle,
  fontWeight: FontWeight.w400,
  fontSize: 12,
);

InputDecoration customFormInputUsername = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: secondaryColor),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: secondaryColor, width: 2),
  ),
  labelText: "Username",
  labelStyle: TextStyle(
      color: secondaryColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
  ),
);

InputDecoration customFormInputEmail = InputDecoration(
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: secondaryColor),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: secondaryColor, width: 2),
  ),
  labelText: "Email",
  labelStyle: TextStyle(
    color: secondaryColor,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  ),
);