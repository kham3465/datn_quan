
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';

class StatusWidget extends StatelessWidget {
  StatusWidget({
    super.key,
    required this.title,
    this.widget,
  });

  final String title;
  Widget? widget;

  Widget? statusWidget() {
    switch (title) {
      case "Hoàn thành":
        widget = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppThemes.green4,
              border: Border.all(
                width: 1,
                color: AppThemes.green0,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Hoàn thành",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(14, AppThemes.green0).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
        );
        break;
      case "Đã hoàn thành":
        widget = Text(
          "Đã hoàn thành",
          textAlign: TextAlign.center,
          style: AppFonts.normalBold(14, AppThemes.green0).copyWith(
            height: 16 / 14,
          ),
        );
        break;
      case "Đã trả":
        widget = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppThemes.green4,
              border: Border.all(
                width: 1,
                color: AppThemes.green0,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Đã trả",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(14, AppThemes.green0).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
        );
        break;
      case "Đang vẫn chuyển":
        widget = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppThemes.orange4,
              border: Border.all(
                width: 1,
                color: AppThemes.orange0,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Đang vẫn chuyển",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(14, AppThemes.orange0).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
        );
        break;
      case "Đang hoạt động":
        widget = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppThemes.green4,
              border: Border.all(
                width: 1,
                color: AppThemes.green0,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Đang hoạt động",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(14, AppThemes.green0).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
        );
        break;
      case "Kích hoạt":
        widget = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppThemes.green4,
              border: Border.all(
                width: 1,
                color: AppThemes.green0,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Kích hoạt",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(14, AppThemes.green0).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
        );
        break;
      case "Chưa áp dụng":
        widget = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppThemes.light2,
              border: Border.all(
                width: 1,
                color: AppThemes.dark3,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Chưa áp dụng",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(14, AppThemes.dark3).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
        );
        break;
      case "Đã kết thúc":
        widget = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppThemes.light2,
              border: Border.all(
                width: 1,
                color: AppThemes.dark3,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Đã kết thúc",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(14, AppThemes.dark3).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
        );
        break;
      case "Lưu tạm":
        widget = Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppThemes.light2,
              border: Border.all(
                width: 1,
                color: AppThemes.dark3,
              )),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "Lưu tạm",
              textAlign: TextAlign.center,
              style: AppFonts.normalBold(14, AppThemes.dark3).copyWith(
                height: 16 / 14,
              ),
            ),
          ),
        );
        break;
      default:
        widget = const SizedBox.shrink();
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return statusWidget() ?? const SizedBox.shrink();
  }
}
