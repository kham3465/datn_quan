import 'package:flutter/cupertino.dart';

class AppColors {
  //new
  static const grey500 = Color(0xFF222528);
  static const grey200 = Color(0xFFD1D6DA);
  static const grey300 = Color(0xFF8C9398);
  static const grey400 = Color(0xFF5B6064);
  static const grey700 = Color.fromARGB(255, 1, 1, 1);
  static const grey100 = Color.fromARGB(255, 243, 243, 243);

  static const primary700 = Color(0xFF2171B4);
  static const primary10 = Color(0xFFECF6FF);
  static const primary50 = Color(0xFFD8ECFF);
  static const senmatic100 = Color(0xFFFFF5DD);
  static const primary600 = Color(0xFF2B91E6);
  static const purple500 = Color(0xFFC0A9FF);
  static const cyan500 = Color(0xFF00C7A3);
  // static const primary50 = Color.fromRGBO(216, 236, 255, 1);
  //test
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
  static const textHeaderBlack = Color(0xff191919);
  static const primary = Color(0xFFEE0033);
  static const primarChange = Color(0xFF3E7BFA);
  static const bodyTextColor = Color(0xFF191919);
  static const textBlack = Color(0xff000000);
  static const white = Color(0xFFFFFFFF);
  static const transparent = Color(0x00000000);
  static const primarySubtle = Color(0xFFCCDDFF);
  static const textTexTField = Color(0xFF1f1f39);
  static const themeWeak = Color(0xFF999999);

  //dart
  static const dark0 = Color(0xFF1C1C28);
  static const dark1 = Color(0xFF28293D);
  static const dark2 = Color(0xFF555770);
  static const dark3 = Color(0xFF8F90A6);
  static const grey50 = Color(0xFF666680);
  static const dark4 = Color(0xFF8E90A5);
  static const dark5 = Color.fromRGBO(140, 140, 140, 1);

  //light
  static const light0 = Color(0xFFE4E4EB);
  static const light1 = Color(0xFFEBEBF0);
  static const light2 = Color(0xFFF2F2F5);
  static const light4 = Color(0xFFFFFFFF);
  static const lighter = Color(0xff6698FA);

  //red
  static const red1 = Color(0xffFF3B3B);
  static const red4 = Color(0xffFFE5E5);

  //gradient
  static const gradient = LinearGradient(
      colors: [Color(0xff00CFDE), Color(0xff05A660)],
      stops: [0.0695, 0.9305],
      transform: GradientRotation(-75));

  static const redGradient = LinearGradient(
      colors: [Color(0xffFF6363), Color(0xffE51844)],
      stops: [0.0695, 0.9305],
      transform: GradientRotation(-75));

  // text blue color
  static const hintTextColor = Color(0xFF8F90A6);
  static const List<Color> colorBackgroundApp = [
    Color(0xff73DFE7),
    Color(0xff0063F7)
  ];
  static const List<Color> linearBackGroundHome = [
    Color(0xff6AC2FC),
    Color(0xff497EFE)
  ];

  //gray
  static const placeholder = Color(0xff888888);
  static const greyScale = Color(0xff4E4E61);

  // blue
  static const blue2 = Color(0xFF5B8DEF);
  static const blue3 = Color.fromRGBO(229, 240, 255, 1);
  static const blue4 = Color.fromRGBO(227, 255, 241, 1);
  static const blue5 = Color.fromRGBO(62, 123, 250, 1);
  static const blue6 = Color.fromRGBO(91, 141, 239, 1);
  static const blue7 = Color.fromRGBO(0, 99, 247, 1);
  static const blue8 = Color.fromRGBO(208, 235, 255, 1);

  static const blue9 = Color.fromRGBO(31, 146, 241, 1);
    static const blue10 = Color.fromRGBO(47, 159, 253, 1);
    static const blue12 = Color.fromRGBO(74, 172, 255, 1);
  //
  static const yellow = Color.fromRGBO(255, 201, 105, 1);
  //green
  static const green = Color(0xFF05A660);
  static const green1 = Color.fromRGBO(5, 166, 96, 1);
  static const green5 = Color.fromRGBO(163, 220, 42, 1);
  // Secondary Color
  static const secondaryColor = Color(0xFF3E7BFA);
  static const secondaryColor1 = Color(0xFFCCDCFF);

  //Gradient Color
  static const gradientColor = Color(0xFF2B9BF6);

  //shadow Color (khi show dialog, bottom sheet)
  static const shadowColor = Color.fromARGB(60, 0, 0, 0);

  // Support Color
  static const backgroundLight = Color(0xFFF2F2F2);

  // static const backgroundDark = Color(0xFFEBF2FF);

  static const grey1 = Color.fromRGBO(244, 248, 255, 1);
  
  static const grey2 = Color.fromRGBO(247, 247, 247, 1);
   static const grey3 = Color.fromRGBO(209, 214, 218, 1);
      static const grey4 = Color.fromRGBO(91, 96, 100, 1);
       static const grey5 = Color.fromRGBO(209, 214, 218, 1);
  //black Text Color

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

  //dark

  static const light3 = Color(0xFFFAFAFC);

  static const light6 = Color(0xFFEAEBEF);
  static const light5 = Color.fromRGBO(240, 255, 255, 1);

  //yellow
  static const yellow1 = Color(0xffFFCC00);
  static const yellow2 = Color(0xFFFDDD48);
    static const yellow3 = Color.fromRGBO(242, 197, 0, 1);


  //red
  static const red0 = Color(0xFFE53535);

  static const red2 = Color(0xFFEE0033);

  static const red5 = Color.fromRGBO(238, 0, 51, 1);
  //green
  static const green0 = Color(0xff05A660);

  static const green2 = Color(0xFF41BF5E);
  static const green3 = Color(0xFF05A560);
  static const greenbtn = Color.fromARGB(65, 192, 95, 1);

  //blue
  static const blue1 = Color(0xff0063F7);

  //orange
  static const orange1 = Color(0xffFF8800);
  static const orange2 = Color(0xFFE63535);

  //violet
  static const violet1 = Color(0xFF6600CC);
  //color divider
  static const divider = Color.fromRGBO(242, 242, 242, 1);
  //black
  static const black1 = Color.fromRGBO(0, 0, 0, 1);
    static const black2 = Color.fromRGBO(34, 37, 40, 1);
       static const black3 = Color.fromRGBO(140, 147, 152, 1);
  // diary screen

  static const formComment = Color.fromRGBO(247, 247, 247, 1);
  static const bgLayout = Color.fromRGBO(208, 235, 255, 1);
  static const btnImg = Color.fromRGBO(236, 246, 255, 1);
  static const btnTaskSquare = Color.fromRGBO(255, 249, 235, 1);
  static const foundationRed500 = Color.fromRGBO(255, 223, 218, 1);
  static const foundationRedRed500 = Color.fromRGBO(255, 100, 77, 1);

  //black
 //pink 
    static const pink1 = Color.fromRGBO(255, 223, 218, 1);
}
