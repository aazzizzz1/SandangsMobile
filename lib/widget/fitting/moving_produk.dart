import 'package:flutter/material.dart';
// import 'package:sandangs/widget/fitting/container_product.dart';

class MovingProduk extends StatefulWidget {
  MovingProduk({
    Key? key,
    required this.busana,
    required this.offset,
    required this.scale,
  }) : super(key: key);

  final String busana;
  Offset offset;
  double scale;

  @override
  State<MovingProduk> createState() => _MovingProdukState();
}

class _MovingProdukState extends State<MovingProduk> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: widget.scale,
        width: widget.scale,
        child: Image.asset(
          widget.busana,
        ),
      ),
      onPanUpdate: (details) {
        setState(() {
          widget.offset = Offset(
            widget.offset.dx + details.delta.dx,
            widget.offset.dy + details.delta.dy,
          );
        });
      },
    );
  }
}
