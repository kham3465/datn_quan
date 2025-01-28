
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/widgets/hvo_big_widget.dart';

class HvoTemplateWidget extends StatelessWidget {
  final String? icon;
  final String? textHeader;
  final String? textButton;
  final Function()? onTap;
  final Widget? body;
  final bool? isButtonRight;
  final Widget? buttonFooter;
  final bool? isButtonFooter;

  const HvoTemplateWidget({
    super.key,
    this.icon,
    this.textHeader,
    this.textButton,
    this.onTap,
    this.body,
    this.buttonFooter,
    this.isButtonFooter = false,
    this.isButtonRight = true,
  });

  @override
  Widget build(BuildContext context) {
    return HvoBigWidget(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        icon ?? AppImages.iconClose,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      textHeader ?? "Tạo bài tập",
                      style: AppFonts.quicksand700(
                        20,
                        AppColors.grey500,
                      ),
                    ),
                  ],
                ),
                isButtonRight == true
                    ? InkWell(
                        onTap: onTap ?? () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF4AACFF),
                                Color(0xFF1F92F1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            textButton ?? "Gửi",
                            style: AppFonts.quicksandSemi600(
                              14,
                              Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: body ??
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Nhập nội dung...',
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
            ),
          ),
          buttonFooter ??
              Container(
                color: Colors.white.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary10,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: AppColors.primary600,
                      ),
                      Text(" Ảnh/Video")
                    ],
                  ),
                ),
              )
        ],
      ),
    );
  }
}
