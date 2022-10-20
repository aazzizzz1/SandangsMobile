import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String? icon;
  final String? text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            child: SvgPicture.asset(icon!),
          ),
          const SizedBox(height: 10),
          Text(
            text!,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
