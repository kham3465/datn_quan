
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class HvoBigWidget extends StatelessWidget {
  final Widget? child;
  final Widget? header;
  final Widget? body;
  final Widget? floatingActionButton;
  const HvoBigWidget(
      {super.key,
      this.child,
      this.header,
      this.body,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bgHeader),
            fit: BoxFit.cover,
          ),
        ),
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
