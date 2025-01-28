
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    this.controllerSearch,
    this.onChanged,
    this.hintText,
    this.onFieldSubmitted,
    this.onTap,
    this.hideFilter = false,
  });
  final String? hintText;
  final dynamic Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool? hideFilter;
  final TextEditingController? controllerSearch;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFD1D6DA),
                width: 1,
              ),
            ),
            child: TextFormField(
              onChanged: onChanged,
              controller: controllerSearch,
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText ?? "Tìm kiếm học sinh",
                hintStyle: AppFonts.quicksandMedium500(
                  16,
                  AppColors.grey200,
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Image.asset(
                    AppImages.iconSearch,
                    height: 20,
                    width: 20,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ),
        // const SizedBox(width: 10),
        hideFilter == true
            ? const SizedBox.shrink()
            : Container(
                margin: const EdgeInsets.only(left: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.iconFilter,
                      width: 20,
                      height: 20,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    const Text(
                      "Lọc",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
      ],
    );
  }
}
