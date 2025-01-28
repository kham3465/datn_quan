
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/widgets/row_in_card_item.dart';
import 'package:flutter_background_geolocation_example/view/widgets/simple_checkbox.dart';

class CardProductCheck extends StatelessWidget {
  const CardProductCheck({
    super.key,
    required this.listData,
    required this.numberCard,
    required this.onPressed,
    this.haveIcon = false,
    this.noCheckBox = false,
    this.isCheck = false,
    this.onTapCheckBox,
    this.onTapEdit,
    this.onTapDelete,
  });

  final List<Map> listData;
  final int numberCard;
  final bool noCheckBox;
  final Function() onPressed;
  final bool haveIcon;
  final bool? isCheck;
  final Function()? onTapCheckBox;
  final Function()? onTapEdit;
  final Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12, right: 20, left: 20, top: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff606170).withOpacity(0.16),
                offset: const Offset(0, 16),
                blurRadius: 24,
                spreadRadius: 0),
            BoxShadow(
                color: const Color(0xff28293D).withOpacity(0.04),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 2),
            child: noCheckBox
                ? Text("${numberCard + 1}",
                    style: AppFonts.normalBold(
                      14,
                      AppThemes.dark1,
                    ))
                : SimpleCheckbox(
                    isChecked: isCheck == true ? true : false,
                    onTap: onTapCheckBox,
                    text: "${numberCard + 1}",
                    textStyle: AppFonts.normalBold(14, AppThemes.dark1)
                        .copyWith(height: 26 / 14),
                  ),
          ),
          InkWell(
            onTap: onPressed,
            child: Column(
              children: listData
                  .map((e) => RowInCardProduct(
                        titleRight: e["titleRight"] ?? "".toString(),
                        titleLeft: e["titleLeft"] ?? "",
                        widgetRight:
                            e["widgetRight"] ?? const SizedBox.shrink(),
                        isWidget: e["isWidget"] ?? false,
                        isFinal: e["isFinal"] ?? false,
                        isTextBlue: e["isTextBlue"] ?? false,
                        isStatus: e["isStatus"] ?? false,
                        isTextRed: e["isTextRed"] ?? false,
                      ))
                  .toList(),
            ),
          ),
          haveIcon
              ? Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(
                    right: 16,
                    left: 16,
                    top: 24,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: onTapEdit,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppThemes.blue4,
                          ),
                          child: Center(
                              child: Image.asset(
                            AppImages.iconPenRed,
                            height: 24,
                            width: 24,
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      InkWell(
                        onTap: onTapDelete,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppThemes.blue4,
                          ),
                          child: Center(
                              child: Image.asset(
                            AppImages.iconTrashGrey,
                            height: 24,
                            width: 24,
                            color: AppThemes.red0,
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
