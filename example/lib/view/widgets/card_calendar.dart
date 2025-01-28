
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class CardCalendar extends StatelessWidget {
  final Function()? onTap;
  final String? tittle;
  final bool? isTwoButton;
  final String? nameClass;
  final bool? hideNameSchool;
  final Function()? button1;
  final String? nameSchool;
  final bool? hideSizeLesson;

  const CardCalendar({
    super.key,
    this.onTap,
    this.isTwoButton = false,
    this.button1,
    this.tittle,
    this.nameClass,
    this.nameSchool,
    this.hideNameSchool = false,
    this.hideSizeLesson = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              tittle ?? "8:00 - 8h30",
              style: AppFonts.quicksand700(
                16,
                AppColors.grey500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 233, 233, 233),
                style: BorderStyle.solid,
                width: 1.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.bookBlue,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameClass ?? "Lớp: AB01",
                        style: AppFonts.quicksand700(
                          16,
                          AppColors.grey500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      hideNameSchool == true
                          ? const SizedBox()
                          : Text(
                              nameSchool ?? "Trường mầm non Nắng Vàng - NV01",
                              style: AppFonts.quicksandMedium500(
                                12,
                                AppColors.grey500,
                              ),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "Cấp độ: 2",
                            style: AppFonts.quicksandMedium500(
                              14,
                              AppColors.grey500,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Bài: Kích thước",
                            style: AppFonts.quicksandMedium500(
                              14,
                              AppColors.grey500,
                            ),
                          ),
                        ],
                      ),
                      isTwoButton == true
                          ? Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary10,
                                      borderRadius: BorderRadius.circular(1000),
                                    ),
                                    child: Text(
                                      "Đã diễn ra",
                                      style: AppFonts.quicksandSemi600(
                                        12,
                                        const Color(0xFF2F9FFD),
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   width: 120,
                                  // ),
                                  InkWell(
                                    onTap: button1 ?? () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 12),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xFF4AACFF),
                                            Color(0xFF1F92F1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Điểm danh",
                                        style: AppFonts.quicksandSemi600(
                                          14,
                                          Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                isTwoButton == true
                    ? const SizedBox.shrink()
                    : InkWell(
                        onTap: onTap ?? () {},
                        child: Image.asset(
                          AppImages.iconGoto,
                          width: 30,
                          height: 30,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
