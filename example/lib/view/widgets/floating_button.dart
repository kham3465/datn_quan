
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class SimpleFloatingActionButton extends StatelessWidget {
  const SimpleFloatingActionButton(
      {super.key, this.onPressed, this.tittle, this.colors});
  final Function()? onPressed;
  final String? tittle;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              colors ?? const Color(0xFF4AACFF),
              colors ?? const Color(0xFF1F92F1),
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImages.iconAdd,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              tittle ?? "Tạo báo cáo",
              style: AppFonts.quicksandSemi600(
                16,
                Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
