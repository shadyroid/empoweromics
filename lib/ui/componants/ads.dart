import 'package:carousel_slider/carousel_slider.dart';
import 'package:empoweromics/data/models/beans/ad.dart';
import 'package:empoweromics/utils/app_colors.dart';
import 'package:empoweromics/utils/app_sizes.dart';
import 'package:flutter/material.dart';

class Ads extends StatefulWidget {
  final List<Ad> ads;

  Ads(this.ads);

  @override
  State<StatefulWidget> createState() {
    return _AdsState();
  }
}

class _AdsState extends State<Ads> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 2.3,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: widget.ads
            .map((item) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child:
                    Image.network(item.link, fit: BoxFit.cover, width: 1000.0)))
            .toList(),
      ),
      SizedBox(
        height: AppSizes.h0_01,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.ads.asMap().entries.map((entry) {
          return GestureDetector(
            child: Container(
              width: _current == entry.key ? 30.0 : 10.0,
              height: _current == entry.key ? 6.0 : 10.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: ShapeDecoration(
                  color: _current == entry.key
                      ? AppColors.colorPrimary
                      : AppColors.colorAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  )),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
