
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class CardAttendance extends StatefulWidget {
  final bool? isShowAvatar;
  final bool? isBoder;
  final String? avatar;
  final String? content;
  final bool? isPadding;
  const CardAttendance({
    super.key,
    this.isShowAvatar = false,
    this.isBoder = true,
    this.avatar,
    this.content,
    this.isPadding = true,
  });

  @override
  State<CardAttendance> createState() => _CardAttendanceState();
}

class _CardAttendanceState extends State<CardAttendance> {
  bool isCheck = false;
  // bool isShowAvatar = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 15, horizontal: widget.isPadding==true ? 15 : 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.isBoder == true
                ? const Color.fromARGB(255, 237, 236, 236)
                : Colors.white.withOpacity(0.8),
            width: widget.isBoder == true ? 1 : 0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.isShowAvatar == true
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        widget.avatar ?? AppImages.avaterStudents,
                        width: 36,
                        height: 36,
                      ),
                    )
                  : const SizedBox.shrink(),
              Text(
                widget.content ?? "Nguyễn An Tường Anh",
                style: AppFonts.quicksandMedium500(
                  14,
                  AppColors.grey500,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isCheck = !isCheck;
              });
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isCheck ? AppThemes.kPrimary : const Color(0xffffffff),
                border: const Border.fromBorderSide(
                  BorderSide(
                    width: 1.5,
                    color: AppThemes.kPrimary,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: const Icon(
                Icons.check,
                size: 12,
                color: Color(0xffffffff),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
