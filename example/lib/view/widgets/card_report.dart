
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class CardReport extends StatelessWidget {
  final Function()? onTap;
  final String? tittle1;
  final String? content1;
  final String? tittle2;
  final String? content2;
  final String? title3;
  final String? content3;
  const CardReport({
    super.key,
    this.onTap,
    this.tittle1,
    this.content1,
    this.tittle2,
    this.content2,
    this.title3,
    this.content3,
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
                        tittle1 ?? "Đến: Nguyễn Lan Anh",
                        style: AppFonts.quicksand700(
                          16,
                          AppColors.grey500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: tittle2 ?? 'Điểm: ',
                              style: AppFonts.quicksand700(
                                16,
                                AppColors.grey500,
                              ),
                            ),
                            TextSpan(
                              text: content2 ?? '19/20',
                              style: AppFonts.quicksandMedium500(
                                16,
                                AppColors.grey500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title3 ?? 'Nhận xét: ',
                    style: AppFonts.quicksand700(
                      16,
                      AppColors.grey500,
                    ),
                  ),
                  TextSpan(
                    text: content3 ??
                        'Bé ngoan, chăm chỉ phát biểu trên lớp. Tuy nhiên cần tập trung hơn n...',
                    style: AppFonts.quicksandMedium500(
                      16,
                      AppColors.grey500,
                    ),
                  ),
                ],
              ),
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
