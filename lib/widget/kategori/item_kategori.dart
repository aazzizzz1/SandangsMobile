import 'package:flutter/material.dart';

class ItemKategori extends StatelessWidget {
  ItemKategori({
    required this.nama,
    required this.img,
  });

  String nama;
  String img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      img,
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              nama,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
