
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class ItemsDetail extends StatelessWidget {
  final String? content;
  const ItemsDetail({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          AppImages.iconSun,
          width: 20,
          height: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          content ?? "Hình dạng: 3 điểm",
          style: AppFonts.quicksandMedium500(
            16,
            AppColors.grey500,
          ),
        )
      ],
    );
  }
}
