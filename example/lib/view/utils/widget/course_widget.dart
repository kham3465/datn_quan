
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/utils/fonts/app_font.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_colors.dart';

// ignore: must_be_immutable
class CourseWidget extends StatelessWidget {
  CourseWidget(
      {super.key,
        required this.image,
        required this.courseName,
        this.onTap,
        this.isDetail,
        this.nameTeacher,
        this.classType});

  String image;
  String courseName;
  String? nameTeacher;
  String? classType;
  Function()? onTap;
  bool? isDetail;
  Color? textColors;
  Color? backgroundColors;

  Color? statusTextColors() {
    switch (classType) {
      case "Lớp Online 1 -1":
        textColors = AppColors.primary;
        break;
      case "Lớp Online 1 -2":
        textColors = AppColors.textOrange;
        break;
      case "Lớp Online 1 -3":
        textColors = AppColors.textPurple;
        break;
    }
    return textColors;
  }

  Color? statusBgColors() {
    switch (classType) {
      case "Lớp Online 1 -1":
        backgroundColors = Color(0xffCCDDFF);
        break;
      case "Lớp Online 1 -2":
        backgroundColors = Color(0xffFFF8E5);
        break;
      case "Lớp Online 1 -3":
        backgroundColors = Color(0xffFFE5FF);
        break;
    }
    return backgroundColors;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 295,
        margin: EdgeInsets.only(top: 15),
        width: MediaQuery.of(context).size.width * 0.43,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 203,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment(0, 0))),
            ),
            SizedBox(height: 3,),
            Text(
              courseName,
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: 16,
                  fontFamily: AppFonts.sfProMedium,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible),
            ),
            isDetail == true
                ? Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Text(
                      nameTeacher!,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: AppColors.hintTextColor,
                          fontSize: 14,
                          fontFamily: AppFonts.sfProLight),
                    ),
                  ),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: statusBgColors()),
                    child: Text(
                      classType!,
                      style: TextStyle(
                          color: statusTextColors(),
                          fontFamily: AppFonts.sfProRegular,
                          fontSize: 12),
                    ),
                  )
                ],
              ),
            )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
