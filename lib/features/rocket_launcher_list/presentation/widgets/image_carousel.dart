import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          // Image Carousel
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: 216,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        SizedBox(
          height: 12,
        ),
        AnimatedSmoothIndicator(
          // Indicator for Image Page
          activeIndex: _current,
          count: imgList.length,
          effect: CustomizableEffect(
            dotDecoration: DotDecoration(
              color: Colors.black,
              width: 8,
              height: 8,
              borderRadius: BorderRadius.circular(5),
              dotBorder: DotBorder(color: Colors.white, padding: 2, width: 1.5),
            ),
            activeDotDecoration: DotDecoration(
                width: 15,
                height: 15,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}
