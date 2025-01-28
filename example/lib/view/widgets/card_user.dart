
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class CardUser extends StatelessWidget {
  final String? icon;
  final String? content;
  final Function()? onTap;
  const CardUser({
    super.key,
    this.icon,
    this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon ?? AppImages.iconWorkBoard,
            width: 40,
            height: 40,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 15,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.5,
                    color: Color.fromARGB(255, 234, 233, 233),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      content ?? "Bảng công",
                      style: AppFonts.quicksandSemi600(
                        16,
                        AppColors.grey500,
                      ),
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
            ),
          ),
        ],
      ),
    );
  }
}
