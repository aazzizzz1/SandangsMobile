import 'package:flutter/material.dart';

class ZoomProduk extends StatefulWidget {
  ZoomProduk({
    Key? key,
    required this.initialScale,
    required this.scaleFactor,
    required this.busana,
  }) : super(key: key);

  double initialScale;
  double scaleFactor;
  String busana;

  @override
  State<ZoomProduk> createState() => _ZoomProdukState();
}

class _ZoomProdukState extends State<ZoomProduk> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.scaleFactor,
        height: widget.scaleFactor,
        child: Image.asset(
          widget.busana,
        ),
      ),
      onScaleStart: (details){
        widget.initialScale = widget.scaleFactor;
      },
      onScaleUpdate: (details){
        setState(() {
          widget.scaleFactor = widget.initialScale * details.scale;
        });
      },
    );
  }
}
