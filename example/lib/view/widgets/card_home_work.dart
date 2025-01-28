
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class CardHomeWork extends StatelessWidget {
  final Function()? onTap;
  const CardHomeWork({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color.fromARGB(255, 233, 233, 233),
            style: BorderStyle.solid,
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "[BÀI TẬP PHẦN KÍCH THƯỚC]",
                        style: AppFonts.quicksand700(
                          16,
                          AppColors.grey500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Gửi phụ huynh các bé, hôm nay các bé học về số đếm. Có bài tập về nhà, cha m...",
                        style: AppFonts.quicksandMedium500(
                          14,
                          AppColors.grey500,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: onTap ?? () {},
                  child: Image.asset(
                    AppImages.iconGoto,
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                "08:00 10/04/2023",
                style: AppFonts.quicksandMedium500(
                  14,
                  AppColors.grey300,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
