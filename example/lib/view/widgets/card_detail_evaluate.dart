
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/widgets/item_detail.dart';

class CardEvaluateDetail extends StatelessWidget {
  const CardEvaluateDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA1A1A1).withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chi tiết đánh giá",
            style: AppFonts.quicksand700(
              18,
              AppColors.grey500,
            ),
          ),
          const ItemsDetail(),
          const ItemsDetail(),
          const ItemsDetail(),
          const ItemsDetail(),
          const ItemsDetail(),
        ],
      ),
    );
  }
}
