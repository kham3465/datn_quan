
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/touch_able_widgets.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key,
    this.titleButton,
    this.color,
    required this.onPressed,
    this.haveIcon = false,
    this.isButtonWhite = false,
    this.width,
    this.colorButton,
    this.colorTextButton,
  });
  final String? titleButton;
  final Color? color;
  final Color? colorTextButton;
  final Color? colorButton;
  final Function() onPressed;
  final bool haveIcon;
  final bool isButtonWhite;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: colorButton ?? AppThemes.kPrimary,
            // border: isButtonWhite
            //     ? Border.all(width: 1, color: AppThemes.kPrimary)
            //     : haveIcon
            //         ? Border.all(width: 1, color: AppThemes.kPrimary)
            //         : Border.all(width: 2.5, color: AppThemes.kPrimary),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11),
          child: !haveIcon
              ? Text(
                  titleButton ?? "Tạo đơn và giao hàng",
                  textAlign: TextAlign.center,
                  style: AppFonts.quicksandSemi600(
                      16, colorTextButton ?? Colors.white),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Image.asset(
                        AppImages.iconSave,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        titleButton ?? "Lưu tạm",
                        textAlign: TextAlign.center,
                        style: AppFonts.quicksandSemi600(
                          16,
                          colorTextButton ?? Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
