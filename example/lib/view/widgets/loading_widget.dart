
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   constraints: const BoxConstraints.expand(),
    //   color: AppThemes.black.withOpacity(0.6),
    //   child: const Center(
    //       child: SpinKitFadingCircle(
    //     color: Colors.white,
    //     size: 50,
    //   )),
    // );
    return Container(
      constraints: const BoxConstraints.expand(),
      color: AppThemes.black.withOpacity(0.6),
      child: Center(
          child: Stack(
        children: [
          const SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary600,
              )),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AppImages.logoLoading),
          )),
        ],
      )),
    );
  }
}
