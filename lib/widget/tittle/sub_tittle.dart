import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';

class SubTittle extends StatelessWidget{
  const SubTittle({Key? key,required this.sub}) : super(key: key);
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right : 15, top: 20,bottom: 10),
      child: Text(
        sub,
        style: subTittle,
      ),
    );
  }
}
