
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/widgets/card_rate_scale.dart';

class CardRankingStudent extends StatelessWidget {
  final Function()? onTap;
  final String name;

  const CardRankingStudent({
    Key? key,
    this.onTap,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              name,
              style: AppFonts.quicksand700(
                18,
                AppColors.grey500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white, // Màu nền trắng
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.white, // Màu viền trắng
                style: BorderStyle.solid,
                width: 1.0,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardRateScale(content: "BTVN"),
                CardRateScale(content: "Nề nếp"),
                CardRateScale(content: "Tích cực phát biểu"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
