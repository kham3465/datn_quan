
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';


class SimpleCheckbox extends StatefulWidget {
  SimpleCheckbox({
    Key? key,
    required this.isChecked,
    this.text,
    this.isCheckBoxRight = true,
    this.textStyle,
    this.widget,
    this.isWidget = false,
    this.onlyCheckBox = false,
    this.onTap,
  }) : super(key: key);
  bool isChecked;
  final String? text;
  final bool isCheckBoxRight;
  final TextStyle? textStyle;
  final Widget? widget;
  bool isWidget;
  final bool onlyCheckBox;
  final Function()? onTap;

  @override
  State<SimpleCheckbox> createState() => _SimpleCheckboxState();
}

class _SimpleCheckboxState extends State<SimpleCheckbox> {
  @override
  Widget build(BuildContext context) {
    return widget.onlyCheckBox
        ? InkWell(
            onTap: widget.onTap,
            child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: widget.isChecked
                      ? AppThemes.red0
                      : const Color(0xffffffff),
                  border: Border.fromBorderSide(
                    BorderSide(
                      width: 1.5,
                      color: widget.isChecked
                          ? AppThemes.red0
                          : const Color(0xff8f90a6),
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.check,
                  size: 12,
                  color: Color(0xffffffff),
                )),
          )
        : !widget.isCheckBoxRight
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: widget.onTap,
                      child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: widget.isChecked
                                ? AppThemes.red0
                                : const Color(0xffffffff),
                            border: Border.fromBorderSide(
                              BorderSide(
                                width: 1.5,
                                color: widget.isChecked
                                    ? AppThemes.red0
                                    : const Color(0xff8f90a6),
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.check,
                            size: 12,
                            color: Color(0xffffffff),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  !widget.isWidget
                      ? Flexible(
                          flex: 9,
                          child: Text(
                            widget.text ?? "",
                            style: widget.textStyle ??
                                AppFonts.normalBold(
                                  14,
                                  AppThemes.gray,
                                ),
                          ),
                        )
                      : Flexible(flex: 5, child: widget.widget!)
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      widget.text ?? "",
                      textAlign: TextAlign.left,
                      style: widget.textStyle ??
                          AppFonts.bold(
                            18,
                            AppThemes.dark1,
                          ).copyWith(height: 23 / 18),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: widget.onTap,
                        child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: widget.isChecked
                                  ? AppThemes.red0
                                  : const Color(0xffffffff),
                              border: Border.fromBorderSide(
                                BorderSide(
                                  width: 1.5,
                                  color: widget.isChecked
                                      ? AppThemes.red0
                                      : const Color(0xff8f90a6),
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 12,
                              color: Color(0xffffffff),
                            )),
                      ),
                    ),
                  ),
                ],
              );
  }
}
