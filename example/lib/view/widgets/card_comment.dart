
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';

import '../res/images/app_images.dart';

class CardComment extends StatelessWidget {
  final String? content;
  const CardComment({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppImages.iconPen,
          width: 20,
          height: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            content ??
                "Con ngoan và luôn cố gắng trong học tập. Tuy nhiên cần ôn tập thêm kiến thức ",
            style: AppFonts.quicksandMedium500(
              16,
              AppColors.grey500,
            ),
          ),
        )
      ],
    );
  }
}
