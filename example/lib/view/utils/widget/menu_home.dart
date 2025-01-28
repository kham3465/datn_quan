
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/utils/fonts/app_font.dart';
import 'package:flutter_background_geolocation_example/view/utils/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    this.image,
    this.itemText,
    this.ontap,
    this.isChecked = false,
  });

  final String? image;
  final String? itemText;
  final Function()? ontap;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.22,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        20.0), // Chỉ định độ cong của viền
                    child: Image.network(
                      image ?? "",
                      fit: BoxFit.fitHeight,
                    ), // Thay thế URL_ảnh bằng đường dẫn ảnh của bạn
                  ),
                ),
                isChecked
                    ? Positioned(
                        right: -5,
                        top: -5,
                        child: Image.asset(
                          AppImages.icCheckGreen,
                          height: 25,
                          width: 25,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              itemText!,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.dark1,
                fontFamily: AppFonts.sfProRegular,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.visible,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget shimmerMenu({required double width, required double height}) {
  return Shimmer.fromColors(
    period: const Duration(milliseconds: 400),
    baseColor: AppColors.hintTextColor.withOpacity(0.2),
    highlightColor: AppColors.white.withOpacity(0.5),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.hintTextColor,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
