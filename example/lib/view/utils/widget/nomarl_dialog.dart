
import 'package:flutter/material.dart';

import 'package:flutter_background_geolocation_example/view/app_theme/app_dimens.dart';
import 'package:flutter_background_geolocation_example/view/utils/fonts/app_font.dart';
import 'package:flutter_background_geolocation_example/view/utils/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/normal_text.dart';
import 'package:flutter_background_geolocation_example/view/widgets/touchable_widget.dart';

class NormalDialog extends StatelessWidget {
  final String? title, description, description2, text1stButton, text2ndButton, image;
  final void Function()? onPress1stButton, onPress2ndButton;
  final bool? isTwoButton;
  final bool? showBtnClose;
  final bool? showBtnCloseCircle;
  final bool? hideBtnBottom;
  final bool? leftTitle;
  final bool? titleBold;
  final bool? canScroll;
  final bool? dialogDismiss;
  final TextAlign? descriptionTextAlign;
  final Widget? widgetDescription;
  final Widget? customImage;
  final Color? titleColor;
  final bool noTitle;
  final Color? colorDescription;
  final bool isButton1White;
  final bool? isNoti;

  const NormalDialog(
      {super.key,
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
      this.titleColor,
      this.titleBold,
      this.showBtnCloseCircle,
      this.canScroll,
      this.dialogDismiss,
      this.noTitle = false,
      this.colorDescription,
      this.isButton1White = false,
      this.isNoti = false});

  closePopup(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<bool> onWillPop() {
    return Future.value(dialogDismiss ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Dialog(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(AppDimens.spaceMedium),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppColors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    (image != null
                        ? Container(
                            margin: const EdgeInsets.only(bottom: AppDimens.spaceMedium),
                            child: Image.asset(
                              image!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container()),
                    customImage ?? const SizedBox.shrink(),
                    customImage != null ? const SizedBox(height: AppDimens.spaceMedium) : const SizedBox.shrink(),
                    if(isNoti==true)
                      Align(alignment:Alignment.centerRight,
                          child: IconButton(onPressed: ()=>closePopup(context), icon: Icon(Icons.clear))),

                        Align(
                          alignment: leftTitle == true ? Alignment.centerLeft : Alignment.center,
                          child: noTitle
                              ? null
                              : Text(
                                  title ?? "Thông báo",
                                  textAlign: leftTitle == true ? TextAlign.left : TextAlign.center,
                                  style: (titleBold == true)
                                      ? const TextStyle(
                                          fontFamily: AppFonts.sfProBold,
                                          fontSize: AppDimens.textSizeMedium,
                                          color: AppColors.headerTextBlack)
                                      : TextStyle(
                                          fontFamily: AppFonts.sfProRegular,
                                          fontSize: AppDimens.textSizeSmall,
                                          color: titleColor ?? AppColors.headerTextBlack),
                                ),
                        ),

                    const SizedBox(
                      height: 15,
                    ),
                    ((description == null || description == "")
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: ((description2 == null || description2 == "") ? 20 : 10)),
                            child: Text(
                              description ?? '',
                              textAlign: descriptionTextAlign ?? TextAlign.center,
                              style: TextStyle(
                                  fontFamily: AppFonts.sfProRegular,
                                  fontSize: AppDimens.textSizeSmall,
                                  color: colorDescription ?? AppColors.hintTextColor),
                            ),
                          )),
                    (widgetDescription != null)
                        ? (canScroll == true)
                            ? Flexible(child: widgetDescription!)
                            : widgetDescription!
                        : const SizedBox.shrink(),
                    ((description2 == null || description2 == "")
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              description2 ?? '',
                              textAlign: descriptionTextAlign ?? TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: AppFonts.sfProRegular,
                                  fontSize: AppDimens.textSizeSmall,
                                  color: AppColors.textRed),
                            ),
                          )),
                    hideBtnBottom == true
                        ? const SizedBox.shrink()
                        : Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: TouchableWidget(
                                    height: 50,
                                    padding: const EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        color: isTwoButton == true
                                            ? (isButton1White ? Colors.white : AppColors.secondaryColor)
                                            : AppColors.primary,
                                        borderRadius: BorderRadius.circular(20),
                                        border: isButton1White
                                            ? Border.all(width: 1, color: const Color(0xffDDDDDD))
                                            : null,
                                        boxShadow: [
                                          isTwoButton == true
                                              ? (isButton1White ? AppColors.shadowGrey : AppColors.shadowYellow)
                                              : AppColors.shadowBlue
                                        ]),
                                    onPressed: onPress1stButton ??
                                        () {
                                          closePopup(context);
                                        },
                                    child: NormalText(
                                      text1stButton ?? "Thoát",
                                      maxLines: 1,
                                      style: buttonTextStyle(
                                          color: isTwoButton == true
                                              ? (isButton1White ? AppColors.primary : AppColors.textContentBrown)
                                              : AppColors.white),
                                    )),
                              ),
                              (isTwoButton == true
                                  ? Container(
                                      width: 10,
                                    )
                                  : Container()),
                              (isTwoButton == true
                                  ? Expanded(
                                      flex: 1,
                                      child: TouchableWidget(
                                          height: 50,
                                          padding: const EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: const [AppColors.shadowBlue]),
                                          onPressed: onPress2ndButton ??
                                              () {
                                                closePopup(context);
                                              },
                                          child: NormalText(
                                            text2ndButton ?? "OK",
                                            maxLines: 1,
                                            style: buttonTextStyle(color: AppColors.white),
                                          )),
                                    )
                                  : Container()),
                            ],
                          ),
                  ],
                ),
              ),
              (showBtnClose == true
                  ? Positioned(
                      top: 10,
                      right: 10,
                      child: TouchableWidget(
                        onPressed: () => closePopup(context),
                        padding: (showBtnCloseCircle == true) ? const EdgeInsets.all(4) : null,
                        child: (showBtnCloseCircle == true)
                            ? Image.asset(
                                AppImages.iconCloseCircle,
                                width: AppDimens.iconLarge,
                                height: AppDimens.iconLarge,
                                color: const Color(0xff8F90A6),
                              )
                            : Image.asset(
                                AppImages.icClose,
                                width: AppDimens.iconXSmall,
                                height: AppDimens.iconXSmall,
                                fit: BoxFit.contain,
                                color: AppColors.textBlack,
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
  return TextStyle(
    fontSize: fontSize ?? AppDimens.textSizeXLarge,
    fontFamily: AppFonts.sfProMedium,
    color: color ?? AppColors.white,
  );
}
