
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_colors.dart';


class AppFonts {
  static const String sfProBold = 'SF-Pro-Rounded-Bold';
  static const String sfProLight = 'SF-Pro-Rounded-Light';
  static const String sfProMedium = 'SF-Pro-Rounded-Medium';
  static const String sfProRegular = 'SF-Pro-Rounded-Regular';
  static const String montserrat = 'Montserrat';
  static const String lobster = 'Lobster';
  static const String zcoolXiaoWei = 'ZCOOLXiaoWei-Regular';
  static const String nunito = 'Nunito';
  static const String simSun = 'simSun';

  static TextStyle titleText(
          [double fontSize = 20, Color color = AppColors.textBlack]) =>
      TextStyle(
        fontFamily: sfProMedium,
        fontSize: fontSize,
        color: color,
      );
  static const String nunitoItalic = 'Nunito-Italic';
}
