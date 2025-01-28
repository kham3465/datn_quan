
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class CardChat extends StatefulWidget {
  final String? name;
  final String? description;
  final String? date;
  const CardChat({
    super.key, this.name, this.description, this.date,
  });

  @override
  State<CardChat> createState() => _CardChatState();
}

class _CardChatState extends State<CardChat> {
  bool isCheck = false;
  // bool isShowAvatar = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.iconDefaultSchool,
                width: 60,
                height: 60,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tàu : ${widget.name?? ""}",
                      style: AppFonts.quicksandSemi600(
                        16,
                        AppColors.grey500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "",
                      style: AppFonts.quicksandSemi600(
                        16,
                        AppColors.grey500,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "You: Chào cả lớp !",
                          style: AppFonts.quicksandMedium500(
                            14,
                            AppColors.grey500,
                          ),
                        ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        Text(
                          "9:40 AM ",
                          style: AppFonts.quicksandMedium500(
                            14,
                            AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
