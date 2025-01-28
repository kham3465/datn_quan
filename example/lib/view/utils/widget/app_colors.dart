import 'package:flutter/material.dart';

class AppColors {
  static const Map<int, Color> colorMaterialMap = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  // Primary Color
  static const primary = Color(0xFF00B3FF);

  // Secondary Color
  static const secondaryColor = Color(0xFFFFEE60);

  //Gradient Color
  static const gradientColor = Color(0xFF2B9BF6);

  //shadow Color (khi show dialog, bottom sheet)
  static const shadowColor = Color.fromARGB(60, 0, 0, 0);

  // Support Color
  static const backgroundLight = Color(0xFFF2F2F2);

  // static const backgroundDark = Color(0xFFEBF2FF);
  static const placeholder = Color(0xFFE8EDF3);
  static const transparent = Color(0x00000000);
  static const white = Color(0xffffffff);
  static const backGroundComic = Color(0xffF6F9FF);

  //black Text Color
  // header text color
  static const headerTextBlack = Color(0xFF1C1C28);

  // text TextField
  static const textTexTField = Color(0xFF1f1f39);

  //text black Color
  static const textBlack = Color(0xFF28293D);

  //title text Colors
  static const titleTextColor = Color(0xFF555770);

  // text title TextField
  static const textTitleTexTField = Color(0xFF858597);

  // text blue color
  static const hintTextColor = Color(0xFF8F90A6);

  // text hint
  static const textHint = Color(0xFF98a1af);

  //shadow blue
  static const shadowBlue = BoxShadow(
      color: Color(0xFF1489F1),
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(0.0, 6.0));

  //shadow Grey
  static const shadowGrey = BoxShadow(
      color: Color(0xFFDDDDDD),
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(0.0, 6.0));


  //shadow yellow
  static const shadowYellow = BoxShadow(
      color: Color(0xffFEDC26),
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(0.0, 6.0));

  // other textColor
  //text title blue
  static const textTitleBlueColor = Color(0xFF3E7BFA);

  //text content blue
  static const textContentBlueColor = Color(0xFF2667FA);

  //text purple
  static const textPurple = Color(0xFFAC5DD9);

  //text red
  static const textRed = Color(0xFFC84912);

  //text red Fresh
  static const textRedFresh = Color(0xFFff3b3b);

  //text red title
  static const textRedTitle = Color(0xFFe53535);

  //text green
  static const textGreen = Color(0xFF05A660);

  //text orange
  static const textOrange = Color(0xFFE57A00);

  //text Neon
  static const textNeon = Color(0xFF00B7C4);

  //text content Brown
  static const textContentBrown = Color(0xFFAF5D00);

  //text title Brown
  static const textTitleBrown = Color(0xFFC06A51);

  //border color
  static const borderTextField = Color(0xFFC7C9D9);

  //line color
  static const horizontalLine = Color(0xffE4E4EB);

  //background comment
  static const backgroundComment = Color(0xffF2F2F5);

  //dark
  static const dark0 = Color(0xff1C1C28);
  static const dark1 = Color(0xff28293D);
  static const dark2 = Color(0xff555770);
  static const dark3 = Color(0xFF8F90A6);
  static const dark4 = Color(0xFFC7C9D9);
}
