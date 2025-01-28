
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';

class HvoLayoutWidget extends StatelessWidget {
  const HvoLayoutWidget({
    super.key,
    this.child,
    this.header,
    this.body,
    this.floatingActionButton,
  });
  final Widget? child;
  final Widget? header;
  final Widget? body;

  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue8,
      body: Container(
        child: child ??
            Column(
              children: [
                header != null ? header! : const SizedBox.shrink(),
                body != null ? body! : const SizedBox.shrink(),
              ],
            ),
      ),
      floatingActionButton: floatingActionButton ?? const SizedBox.shrink(),
    );
  }
}
