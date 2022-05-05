import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/common/app_images.dart';

class BannerHome extends StatefulWidget {
  const BannerHome({Key? key}) : super(key: key);

  @override
  State<BannerHome> createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  int _current = 0;

  var listBanner = [AppImages.banner, AppImages.banner, AppImages.banner];

  void _onChangePage(int index, CarouselPageChangedReason reason) {
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100 / 812 * MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.zero,
            child: CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  onPageChanged: _onChangePage),
              items: listBanner.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            i,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: (100 / 812) * MediaQuery.of(context).size.height,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(listBanner.length, (int index) {
            return buildDot(index: index);
          }),
        ),
      ],
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(right: 5),
      height: 5,
      width: _current == index ? 14 : 5,
      decoration: BoxDecoration(
          color: _current == index
              ? Theme.of(context).primaryColor
              : AppColors.dot,
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
