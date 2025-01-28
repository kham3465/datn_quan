
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/widgets/status_widget.dart';

class RowInCardProduct extends StatelessWidget {
  const RowInCardProduct({
    super.key,
    this.titleLeft,
    this.titleRight,
    this.isFinal = false,
    this.isTextBlue = false,
    this.isStatus = false,
    this.maxLines,
    this.isTextRed = false,
    this.isWidget = false,
    this.widgetRight,
    this.colorLeft,
    this.colorRight,
    this.padding,
    this.flex,
    this.cross,
  });
  final String? titleLeft;
  final String? titleRight;
  final bool isFinal;
  final bool isTextBlue;
  final bool isStatus;
  final int? maxLines;
  final bool isTextRed;
  final bool isWidget;
  final Widget? widgetRight;
  final Color? colorLeft;
  final Color? colorRight;
  final EdgeInsetsGeometry? padding;
  final int? flex;
  final CrossAxisAlignment? cross;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.only(
              right: 20, left: 20, top: 22, bottom: isFinal ? 22 : 0),
      child: Row(
        crossAxisAlignment: cross ?? CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "${titleLeft ?? "Mã vạch"}:",
              maxLines: maxLines,
              textAlign: TextAlign.left,
              style:
                  AppFonts.regular(14, colorLeft ?? AppThemes.dark3).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
          Expanded(
            flex: flex ?? 1,
            child: !isWidget
                ? !isStatus
                    ? Text(
                        titleRight ?? "",
                        maxLines: maxLines,
                        textAlign: TextAlign.right,
                        style: AppFonts.normalBold(
                          14,
                          isTextRed
                              ? AppThemes.red0
                              : isTextBlue
                                  ? AppThemes.kPrimary
                                  : AppThemes.dark1,
                        ).copyWith(
                          height: 18 / 14,
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerRight,
                        child: StatusWidget(title: titleRight ?? "Hoàn thành"),
                      )
                : Container(
                    alignment: Alignment.centerRight, child: widgetRight!),
          )
        ],
      ),
    );
  }
}
