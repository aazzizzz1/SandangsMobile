import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:sandangs/widget/slideview/image_list.dart';

class SlideView extends StatelessWidget {
  const SlideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        enlargeCenterPage: true,
      ),
      items: imgList.map((item) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Stack(
            children: [
              Image.asset(
                item,
                fit: BoxFit.cover,
                width: 1000,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0,
                      horizontal: 20.0
                  ),
                ),
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }
}
