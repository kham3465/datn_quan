
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/touch_able_widgets.dart';

class ItemSetting extends StatelessWidget {
  const ItemSetting({
    super.key,
    this.image,
    this.title,
    this.isFinall = false,
    required this.onPressed,
    this.isSale = false,
    this.fit,
    this.padding,
  });
  final String? image;
  final String? title;
  final bool isFinall;
  final Function() onPressed;
  final bool isSale;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
      padding: padding ?? const EdgeInsets.all(0),
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              image ?? AppImages.iconAccount,
                              height: 45,
                              width: 45,
                              fit: fit ?? BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          title ?? "Khách hàng",
                          style: AppFonts.regular(16, AppThemes.dark1),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: !isSale
                        ? Image.asset(
                            AppImages.iconArrowRight,
                            width: 6,
                            height: 13,
                            fit: BoxFit.fill,
                          )
                        : const SizedBox.shrink(),
                  ),
                )
              ],
            ),
            isFinall
                ? Container(
                    margin: const EdgeInsets.only(top: 16),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 16),
                    height: 1,
                    color: const Color(0xffEBEBF0),
                    width: !isSale
                        ? MediaQuery.of(context).size.width - 40
                        : MediaQuery.of(context).size.width - 48,
                  )
          ],
        ),
      ),
    );
  }
}
