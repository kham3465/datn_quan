
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/widgets/avatar_profile_widget.dart';

class HeaderPostWidget extends StatelessWidget {
  final String? name;
  final String? date;
  final Widget? lastIcon;
  final double? sizeAvatar;
  final String? avatar;
  final List<String>? names;

  const HeaderPostWidget(
      {super.key,
      this.name,
      this.date,
      this.lastIcon,
      this.sizeAvatar,
      this.avatar,
      this.names});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AvatarProfileWidget(
                  size: sizeAvatar,
                  imageUrl: avatar,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                name ?? "NPC",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: AppFonts.quicksand700(
                                  14,
                                  AppColors.grey500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        (date == null)
                            ? const SizedBox.shrink()
                            : Text(date ?? "",
                                style: AppFonts.quicksandMedium500(
                                    12, AppColors.grey300))
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                (lastIcon == null) ? const SizedBox.shrink() : lastIcon!
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(44, 4, 18, 0),
              // child: ((names?.length ?? 0) > 3)
              //     ?
              child: Wrap(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Tới: ",
                          style: AppFonts.quicksandMedium500(
                            14,
                            AppColors.grey400,
                          ),
                        ),
                        for (var i = 0; i < 3 && i < (names?.length ?? 0); i++)
                          TextSpan(
                            text: "${names![i]}, ",
                            style: AppFonts.quicksandMedium500(
                              14,
                              AppColors.grey400,
                            ),
                          ),
                        if ((names?.length ?? 0) >= 3)
                          TextSpan(
                            text: "và ",
                            style: AppFonts.quicksandMedium500(
                              14,
                              AppColors.grey400,
                            ),
                          ),
                        if ((names?.length ?? 0) >= 3)
                          TextSpan(
                            text: "+${(names!.length - 3)} người khác",
                            // style: AppFonts.quicksandMedium500(
                            //   14,
                            //   AppColors.grey400,
                            // ),
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.grey400,
                                decorationThickness: 1.5,
                                color: AppColors.grey400,
                                fontSize: 14),
                          ),
                      ],
                    ),
                  ),
                  // Text(
                  //   "Tới: ${names![0]}, ${names![1]}, ${names![2]}",
                  //   overflow: TextOverflow.visible,
                  //   maxLines: null,
                  // ),
                  // TextButton(
                  //     onPressed: () {},
                  //     child: Text(
                  //         "và +${(names?.length ?? 0) - 3} người khác"))
                ],
              ),
              // : (names?.length == 1)
              //     ? Text("Tới: ${names![0]}")
              //     : (names?.length == 2)
              //         ? Text("Tới: ${names![0]}, ${names![1]}")
              //         : (name?.length == 3)
              //             ? Text(
              //                 "Tới: ${names![0]}, ${names![1]}, ${names![2]}")
              //             : const SizedBox.shrink()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(44, 6, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: AppColors.foundationRed500),
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Text(
                  "Muộn 7 giờ",
                  style: AppFonts.quicksandSemi600(
                    12,
                    AppColors.foundationRedRed500,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
