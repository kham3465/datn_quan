
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';

class HeaderButton extends StatelessWidget {
  final String? icon;
  final Function()? onPressed;
  final Widget? childWidget;
  final double? iconWidth;
  final double? iconHeight;
  final bool? mini;
  final Color? iconColor;
  final Color? backgroundColor;

  const HeaderButton({
    super.key,
    this.onPressed,
    this.icon,
    this.childWidget,
    this.iconWidth,
    this.iconHeight,
    this.mini,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: mini ?? false,
      heroTag: null,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      backgroundColor: backgroundColor ?? AppThemes.transparent,
      onPressed: onPressed,
      child: Container(
        child: icon == null
            ? childWidget
            : Image.asset(
                icon!,
                color: iconColor,
                width: iconWidth,
                height: iconHeight,
              ),
      ),
    );
  }
}
