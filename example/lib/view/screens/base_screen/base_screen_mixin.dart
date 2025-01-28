
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/dimen_scales.dart';
import 'package:flutter_background_geolocation_example/view/widgets/header_button.dart';
import 'base_screen.dart';

mixin BaseScreenMixin<Page extends BaseScreen> on BaseState<Page> {
  // abstract functions

  // other functions and Variable

  Widget? buildHeaderExtend() => null;

  Widget? buildCustomTitle() => null;

  String setTitle() => '';

  Widget? buildLeftWidget() => null;

  Widget? buildRightWidget() => null;

  Widget? buildRightWidgetStack() => null;

  TextAlign? setTextAlignTitle() => null;

  TextStyle? setTextStyleTitle() => null;

  Widget? buildHeaderContent() =>
      null; // khác null: bỏ qua toàn bộ nội dung khác (buildLeftWidget, buildRightWidget...)

  int setFlexRightWidget() => 1;

  double? setHeaderContentHeight() => null;

  double? setSizeHeaderBackground() => null;

  Color? setHeaderBackgroundColor() => null;

  Color? setColorRightWidget() => null;

  Color? setColorLeftWidget() => null;

  Widget? setHeaderBackgroundImage() => null;

  List<BoxShadow>? buildShadowHeader() => null;

  setOnPressLeftButton() {
    Navigator.pop(context, true);
  }

  setOnPressRightButton() => null;

  // build UI

  @override
  Widget buildHeader() {
    double? addSizeHeight = MediaQuery.of(context).padding.top > 24
        ? DimensScale.getInstance(context)?.verticalScale(5)
        : 0; // tăng size cho các màn hình có thanh trạng thái lớn (VD: Iphone X)
    double heightHeader = (setSizeHeaderBackground() ??
            DimensScale.getInstance(context)?.verticalScale(80))! +
        addSizeHeight!;
    double heightHeaderContent =
        DimensScale.getInstance(context)!.verticalScale(80) -
            MediaQuery.of(context).padding.top +
            addSizeHeight;

    return Stack(children: <Widget>[
      setHeaderBackgroundColor() == null
          ? Image.asset(
              AppImages.backgroundHome,
              width: MediaQuery.of(context).size.width,
              height: heightHeader,
              fit: BoxFit.fill,
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: heightHeader,
              decoration: BoxDecoration(
                color: setHeaderBackgroundColor() ?? AppThemes.red0,
                border: Border.all(
                    width: 0,
                    color: setHeaderBackgroundColor() ?? AppThemes.red0),
              ),
            ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: heightHeader,
        alignment: Alignment.bottomCenter,
        // decoration: BoxDecoration(
        //     border: Border.all(
        //         width: 0, color: setHeaderBackgroundColor() ?? AppThemes.red0),
        //     boxShadow: [
        //       BoxShadow(
        //         offset: const Offset(0, 4),
        //         blurRadius: 16,
        //         spreadRadius: 0,
        //         color: AppThemes.white.withOpacity(0.12),
        //       )
        //     ]),
        child: Stack(children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: heightHeader - MediaQuery.of(context).padding.top,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: setHeaderContentHeight() ?? heightHeaderContent,
                  padding: const EdgeInsets.only(top: 10),
                  child: buildHeaderContent() ??
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: buildLeftWidget() ??
                                HeaderButton(
                                  iconColor:
                                      setColorLeftWidget() ?? Colors.white,
                                  icon: AppImages.iconArrowLeft,
                                  onPressed: setOnPressLeftButton,
                                  iconHeight: DimensScale.getInstance(context)
                                      ?.verticalScale(18),
                                  iconWidth: DimensScale.getInstance(context)
                                      ?.scale(9),
                                ),
                          ),
                          Expanded(
                            flex: 4,
                            child: buildCustomTitle() ??
                                Text(
                                  setTitle(),
                                  textAlign:
                                      setTextAlignTitle() ?? TextAlign.center,
                                  style: setTextStyleTitle() ??
                                      AppFonts.normalBold(
                                        18,
                                        Colors.white,
                                      ),
                                ),
                          ),
                          Expanded(
                            flex: setFlexRightWidget(),
                            child: InkWell(
                              onTap: setOnPressRightButton,
                              child: buildRightWidget() ??
                                  Image.asset(
                                    AppImages.iconTick,
                                    width: 15,
                                    height: 12,
                                    fit: BoxFit.fitHeight,
                                    color:
                                        setColorRightWidget() ?? Colors.white,
                                  ),
                            ),
                          )
                        ],
                      ),
                ),
                Expanded(flex: 1, child: buildHeaderExtend() ?? Container())
              ],
            ),
          ),
        ]),
      ),
      buildRightWidgetStack() != null
          ? Positioned(
              right: 0,
              top: MediaQuery.of(context).padding.top,
              child: Container(
                height: heightHeaderContent,
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: buildRightWidgetStack(),
              ),
            )
          : const SizedBox.shrink(),
    ]);
  }
}
