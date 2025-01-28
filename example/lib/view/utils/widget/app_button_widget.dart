
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_dimens.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/touch_able_widgets.dart';


// ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.width,
      this.height,
      this.isYellow,
      this.haveIcon = false,
      this.fontFamily});

  final Function() onTap;
  final String title;
  final double? width;
  final double? height;
  final bool? isYellow;
  final bool haveIcon;
  String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
      padding: const EdgeInsets.all(0),
      onPressed: onTap,
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.width * 0.16,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                isYellow == true ? AppColors.secondaryColor : AppColors.primary,
            boxShadow: [
              isYellow == true ? AppColors.shadowYellow : AppColors.shadowBlue
            ]),
        alignment: Alignment.center,
        child: haveIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 5,
                    child: Text(
                      title,
                      style: TextStyle(
                          color: isYellow == true
                              ? AppColors.textContentBrown
                              : Colors.white,
                          fontFamily: fontFamily,
                          fontSize: AppDimens.textSizeXLarge20),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Flexible(
                    child: Image.asset(
                      AppImages.iconArrowRight,
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            : Text(
                title,
                style: TextStyle(
                    color: isYellow == true
                        ? AppColors.textContentBrown
                        : Colors.white,
                    fontFamily: fontFamily,
                    fontSize: AppDimens.textSizeXLarge20),
              ),
      ),
    );
  }
}
