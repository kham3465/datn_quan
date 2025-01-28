
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/widgets/header_post_diary.dart';

class PostStudyScreen extends StatelessWidget {
  final String? avatar;
  final String? name;
  final String? date;
  final String? content;
  final bool? isDetail;
  final List<String>? images;
  final List<String>? names;
  final void Function()? onTapPost;
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;
  final void Function()? onTapHide;
  final void Function()? pushDetail;
  final void Function()? onTapImages;
  const PostStudyScreen(
      {super.key,
      this.avatar,
      this.name,
      this.date,
      this.content,
      this.images,
      this.names,
      this.onTapPost,
      this.isDetail,
      this.onTapEdit,
      this.onTapDelete,
      this.onTapHide,
      this.pushDetail,
      this.onTapImages});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pushDetail,
      child: Column(
        children: [
          (isDetail != true)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: 6,
                  color: const Color(0xffE4E4EB),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderPostWidget(
                  avatar: avatar ?? "",
                  name: name ?? "",
                  date: date ?? "",
                  names: names ?? [],

                  // lastIcon: InkWell(onTap: () {}),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          content ?? "",
                          style: AppFonts.quicksand600(14, AppColors.dark1),
                        ),
                      ),
                    ],
                  ),
                ),
                (images?.length == 1)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          AppImages.demoDiary,
                          fit: BoxFit.fill,
                        ))
                    : (images!.length == 2)
                        ? Row(
                            children: [
                              Expanded(
                                  child: Image.asset(
                                height: 200,
                                images?[0] ?? "",
                                fit: BoxFit.contain,
                              )),
                              Expanded(
                                  child: Image.asset(
                                height: 200,
                                images?[1] ?? "",
                                fit: BoxFit.contain,
                              ))
                            ],
                          )
                        : (images!.length >= 3)
                            ? InkWell(
                                onTap: onTapImages ?? () {},
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Image.asset(
                                      height: 200,
                                      images?[0] ?? "",
                                      fit: BoxFit.contain,
                                    )),
                                    Expanded(
                                        child: Stack(
                                      children: [
                                        Image.asset(
                                          height: 200,
                                          images?[1] ?? "",
                                          fit: BoxFit.fill,
                                          color:
                                              AppColors.dark0.withOpacity(0.4),
                                          colorBlendMode: BlendMode.srcATop,
                                        ),
                                        Positioned(
                                          top: 0,
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          child: Center(
                                              child: Text(
                                            "+ ${images!.length - 2}",
                                            style: AppFonts.quicksand900(
                                              50,
                                              AppColors.white,
                                            ),
                                          )),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              )
                            : const SizedBox.shrink()
              ],
            ),
          )
        ],
      ),
    );
  }
}
