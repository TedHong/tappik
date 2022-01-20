import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FullscreenSlider extends StatelessWidget {
  List<String> _imgList = [];

  FullscreenSlider(itemList, {Key? key}) : super(key: key){
    _imgList = itemList;
  }
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: false,
              scrollDirection : Axis.vertical,
            ),
            items: _imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        height: height,
                      )),
                    ))
                .toList(),
          );
        },
      );
  }
}