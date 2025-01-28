

import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';

class CardRateScale extends StatefulWidget {
  final String? content;
  const CardRateScale({Key? key, this.content}) : super(key: key);

  @override
  _CardRateScaleState createState() => _CardRateScaleState();
}

const imagePath = "lib/res/images/";

class card_image {
  static const icon1 = "${imagePath}1.png";
  static const icon2 = "${imagePath}2.png";
  static const icon3 = "${imagePath}3.png";
  static const icon4 = "${imagePath}4.png";

  static const List<String> imageList = [icon1, icon2, icon3, icon4];
}

class _CardRateScaleState extends State<CardRateScale> {
  int? selected;
  static const imagePath = "lib/res/images/";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.backgroundLight,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width * 0.4,
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.content ?? "Hình dạng",
              style: AppFonts.quicksandSemi600(
                14,
                AppColors.grey500,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = index;
                    });
                  },
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: selected == index
                          ? AppColors.blue5
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Image.asset(
                        card_image.imageList[index],
                        width: 32,
                        height: 32,
                        color: selected == index
                            ? Colors.white
                            : AppColors.grey500,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
