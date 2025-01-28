
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';

class MyWidget extends StatefulWidget {
  final String? tittle;
  const MyWidget({super.key, this.tittle});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
    );
  }
}
