
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';

class CardWorkBoard extends StatelessWidget {
  const CardWorkBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '14h-15h\n',
                      style: AppFonts.quicksandMedium500(
                        12,
                        AppColors.grey500,
                      ),
                    ),
                    TextSpan(
                      text: '13/10/2023\n',
                      style: AppFonts.quicksandMedium500(
                        12,
                        AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Teddy 01",
                style: AppFonts.quicksandMedium500(
                  12,
                  AppColors.grey500,
                ),
              ),
              Text(
                "Mầm non Ban Mai",
                style: AppFonts.quicksandMedium500(
                  12,
                  AppColors.grey500,
                ),
              ),
              Text(
                "Dạy thay",
                style: AppFonts.quicksandMedium500(
                  12,
                  AppColors.grey500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
