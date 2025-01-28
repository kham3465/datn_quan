
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_dimens.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/touch_able_widgets.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_button.dart';

class NormalDialog extends StatelessWidget {
  final String? title,
      description,
      description2,
      text1stButton,
      text2ndButton,
      image;
  final Function()? onPress1stButton, onPress2ndButton;
  final bool? isTwoButton;
  final bool? showBtnClose;
  final bool? hideBtnBottom;
  final bool? leftTitle;
  final TextAlign? descriptionTextAlign;
  final Widget? widgetDescription;
  final Widget? customImage;
  final TextStyle? styleTitle;
  final bool? noDivider;
  final bool? dismiss;
  final TextStyle? styleDescription;
  final String? imageClose;
  final Color? color1;
  final Color? color2;
  final Color? colorText1;
  final Color? colorText2;
  final Function()? onPressedClose;
  final Function(void Function())? setStateCallback;

  const NormalDialog({
    super.key,
    this.title,
    this.description,
    this.description2,
    this.text1stButton,
    this.text2ndButton,
    this.onPress1stButton,
    this.onPress2ndButton,
    this.isTwoButton,
    this.image,
    this.descriptionTextAlign,
    this.widgetDescription,
    this.showBtnClose,
    this.hideBtnBottom,
    this.leftTitle,
    this.customImage,
    this.styleTitle,
    this.noDivider,
    this.styleDescription,
    this.imageClose,
    this.onPressedClose,
    this.dismiss,
    this.color1,
    this.color2,
    this.colorText1,
    this.colorText2,
    this.setStateCallback,
  });

  closePopup(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<bool> onWillPop() {
    return Future.value(dismiss ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(AppDimens.spaceMedium),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: AppThemes.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      (image != null
                          ? Container(
                              margin: const EdgeInsets.only(
                                  bottom: AppDimens.spaceMedium),
                              child: Image.asset(
                                image!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            )
                          : Container()),
                      customImage ?? const SizedBox.shrink(),
                      customImage != null
                          ? const SizedBox(height: AppDimens.spaceMedium)
                          : const SizedBox.shrink(),
                      // Align(
                      //   alignment: leftTitle == true
                      //       ? Alignment.centerLeft
                      //       : Alignment.center,
                      //   child: Text(
                      //     title ?? "Thông báo",
                      //     textAlign: leftTitle == true
                      //         ? TextAlign.left
                      //         : TextAlign.center,
                      //     style: styleTitle ?? AppFonts.regular(),
                      //   ),
                      // ),
                      // noDivider == false
                      //     ? const SizedBox.shrink()
                      //     : Container(
                      //         margin: const EdgeInsets.only(top: 12),
                      //         height: 1,
                      //         width: MediaQuery.of(context).size.width,
                      //         color: AppThemes.dark4,
                      //       ),
                      ((description == null || description == "")
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  bottom: ((description2 == null ||
                                          description2 == "")
                                      ? 20
                                      : 10)),
                              child: Text(
                                description ?? '',
                                textAlign:
                                    descriptionTextAlign ?? TextAlign.center,
                                style: styleDescription ??
                                    AppFonts.regular(14, AppThemes.gray),
                              ),
                            )),
                      (widgetDescription ?? Container()),
                      ((description2 == null || description2 == "")
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                description2 ?? '',
                                textAlign:
                                    descriptionTextAlign ?? TextAlign.center,
                                style: AppFonts.regular(14, AppThemes.red0),
                              ),
                            )),
                      hideBtnBottom == true
                          ? const SizedBox.shrink()
                          : Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: SimpleButton(
                                    colorButton: AppColors.primary50,
                                    onPressed: onPress1stButton ??
                                        () {
                                          closePopup(context);
                                        },
                                    isButtonWhite:
                                        isTwoButton == true ? true : false,
                                    titleButton: text1stButton ?? "Hủy",
                                    colorTextButton: colorText1,
                                  ),
                                  // child: TouchableWidget(
                                  //     height: 50,
                                  //     padding: const EdgeInsets.all(0),
                                  //     decoration: BoxDecoration(
                                  //         color: isTwoButton == true
                                  //             ? AppThemes.buttonLight
                                  //             : AppThemes.red0,
                                  //         borderRadius:
                                  //             BorderRadius.circular(12)),
                                  //     onPressed: onPress1stButton ??
                                  //         () {
                                  //           closePopup(context);
                                  //         },
                                  //     child: NormalText(
                                  //       text1stButton ?? "Thoát",
                                  //       maxLines: 1,
                                  //       style: buttonTextStyle(
                                  //           color: isTwoButton == true
                                  //               ? AppThemes.black
                                  //               : AppThemes.white),
                                  //     )),
                                ),
                                (isTwoButton == true
                                    ? Container(
                                        width: 10,
                                      )
                                    : Container()),
                                (isTwoButton == true
                                    ? Expanded(
                                        flex: 1,
                                        child: SimpleButton(
                                          color: color2,
                                          onPressed: onPress2ndButton ??
                                              () {
                                                closePopup(context);
                                              },
                                          titleButton: text2ndButton ?? "OK",
                                          colorTextButton: colorText2,
                                        ),
                                        // child: TouchableWidget(
                                        //     height: 50,
                                        //     padding: const EdgeInsets.all(0),
                                        //     decoration: BoxDecoration(
                                        //       color: AppThemes.red0,
                                        //       borderRadius:
                                        //           BorderRadius.circular(6),
                                        //     ),
                                        //     onPressed: onPress2ndButton ??
                                        //         () {
                                        //           closePopup(context);
                                        //         },
                                        //     child: NormalText(
                                        //       text2ndButton ?? "OK",
                                        //       maxLines: 1,
                                        //       style: buttonTextStyle(
                                        //           color: AppThemes.white),
                                        //     )),
                                      )
                                    : Container()),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              (showBtnClose == true
                  ? Positioned(
                      top: 5,
                      right: 10,
                      child: TouchableWidget(
                        onPressed: onPressedClose ?? () => closePopup(context),
                        child: Image.asset(
                          imageClose ?? AppImages.iconCloseCircle,
                          width: AppDimens.spaceMediumLarge,
                          height: AppDimens.spaceMediumLarge,
                          fit: BoxFit.contain,
                          color: AppThemes.dark3,
                        ),
                      ),
                    )
                  : Positioned(top: 10, right: 10, child: Container()))
            ],
          ),
        ));
  }
}

TextStyle buttonTextStyle({color, fontSize}) {
  return AppFonts.regular(
      fontSize ?? AppDimens.textSizeXLarge, color ?? AppThemes.white);
}
