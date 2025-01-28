import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/widgets/loading_widget.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseState<Screen extends BaseScreen> extends State<Screen> {
  // abstract functions
  Widget buildBody(BuildContext context);

  // other functions and Variable
  Widget buildHeader() => Container(); //header of screen
  bool showButtonSupport() => false; //header of screen

  bool blankPage() => false; // true: use function only

  bool fixSizeHeader() =>
      false; // true: màn hình có kiểu header dài, content phía dưới dè lên header

  Color setMainBackgroundColor() => Colors.white;

  Color setStatusBarColor() => AppColors.transparent; // Android only

  void setThemeStatusBar() =>
      setStatusBarStyle(StyleOfStatusBarContent(StatusBarStyle.dark));

  void setStatusBarStyle(StyleOfStatusBarContent styleOfStatusBarContent) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: styleOfStatusBarContent.androidStyle,
        statusBarBrightness: styleOfStatusBarContent.iosStyle));
  } // light or dark

  void afterFirstLayout(BuildContext context) =>
      () {}; // hàm gọi 1 lần duy nhất sau khi build widget lần đầu

  bool _isLoading = false;
  Timer? timerLoading;

  showLoading() {
    if (timerLoading != null) timerLoading?.cancel();
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
    }

    timerLoading = Timer(const Duration(seconds: 30), hideLoading);
  }

  hideLoading() {
    if (timerLoading != null) timerLoading?.cancel();
    if (_isLoading) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    setThemeStatusBar();
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  @override
  void dispose() {
    super.dispose();
  }

  // build UI

  buildLoading() {
    return _isLoading ? const LoadingWidget() : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        blankPage()
            ? Positioned.fill(
                child: buildBody(context)) // nhận context của cả widget
            : Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: setMainBackgroundColor(),
                body: Builder(
                  builder: (context) => Container(
                    color: setMainBackgroundColor(),
                    child: (fixSizeHeader()
                        ? Stack(
                            children: <Widget>[
                              Container(child: buildHeader()),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ((MediaQuery.of(context).size.width /
                                                15) *
                                            3.2) +
                                        (MediaQuery.of(context).padding.top > 24
                                            ? 15
                                            : 0)),
                                child: buildBody(
                                    context), // nhận context của Scaffold không phải của cả widget
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              buildHeader(),
                              Expanded(
                                child: buildBody(context),
                              ),
                            ],
                          )),
                  ),
                ),
              ),
        buildLoading(),
      ],
    );
  }
}

class StyleOfStatusBarContent {
  Brightness? androidStyle;
  Brightness? iosStyle;

  StyleOfStatusBarContent(StatusBarStyle statusBarStyle) {
    switch (statusBarStyle) {
      case StatusBarStyle.dark:
        androidStyle = Brightness.dark;
        iosStyle = Brightness.light;
        break;
      case StatusBarStyle.light:
        androidStyle = Brightness.light;
        iosStyle = Brightness.dark;
        break;
    }
  }
}

enum StatusBarStyle {
  dark,
  light,
}
