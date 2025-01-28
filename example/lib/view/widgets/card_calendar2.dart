
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class CardCalendar2 extends StatelessWidget {
  final Function()? onTap;
  final String? tittle;
  final bool? isTwoButton;
  final bool? checkYellow;
  final String? nameClass;
  final bool? hideNameSchool;
  final Function()? button1;
  final String? nameSchool;
  const CardCalendar2({
    super.key,
    this.onTap,
    this.checkYellow,
    this.isTwoButton = false,
    this.button1,
    this.tittle,
    this.nameClass,
    this.nameSchool,
    this.hideNameSchool = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              tittle ?? "8:00 - 8h30",
              style: const TextStyle(
                fontFamily: "Quicksand",
                fontSize: 16,
                fontWeight: FontWeight.w700,
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
                  width: 30,
                  height: 30,
                  color:checkYellow==true?AppColors.yellow3:AppColors.blue10
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
                        style: const TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      hideNameSchool == true
                          ? const SizedBox.shrink()
                          : Text(
                              nameSchool ?? "Trường mầm non Nắng Vàng - NV01",
                              style: const TextStyle(
                                fontFamily: "Quicksand",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Row(
                        children: [
                          Text(
                            "Cấp độ: 2",
                            style: TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Bài: Kích thước",
                            style: TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      isTwoButton == true
                          ? Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary10,
                                      borderRadius: BorderRadius.circular(1000),
                                    ),
                                    child: const Text(
                                      "Đã diễn ra",
                                      style: TextStyle(
                                        fontFamily: "Quicksand",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 120,
                                  ),
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
                                      child: const Text(
                                        "Điểm danh",
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()
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