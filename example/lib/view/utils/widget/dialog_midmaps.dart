
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/utils/fonts/app_font.dart';
import 'package:flutter_background_geolocation_example/view/utils/images/app_images.dart';
import 'package:flutter_background_geolocation_example/view/utils/widget/app_colors.dart';

class DialogMindMap extends StatefulWidget {
   DialogMindMap({super.key, this.ontap, this.image, this.pinyin, this.word, this.mean});
final Function()? ontap;
final String? image;
final String? pinyin;
final String? word;
final String? mean;

  @override
  State<DialogMindMap> createState() => _DialogMindMapState();
}

class _DialogMindMapState extends State<DialogMindMap> {
  bool shouldCloseDialog = true;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          if (shouldCloseDialog) {
            Navigator.of(context).popUntil((route) => route.isFirst);  // Đóng Dialog khi người dùng nhấn vào khoảng không gian trống
          }
        },
        child: Center(
          child: Container(
              width: MediaQuery.of(context).size.width * (237 / 812),
              height: MediaQuery.of(context).size.height * (100 / 375),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: MediaQuery.of(context).size.width * (72 / 812),
                      height: MediaQuery.of(context).size.height * (84 / 375),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(image: NetworkImage("https://api.hcchineseadmin.com/api/resource/image/thumbnail/${widget.image??"6542398107997c452a25d8fe"}"), fit: BoxFit.fill)
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.pinyin??"pinyin",
                            maxLines: 1,
                            style: TextStyle(
                                color: AppColors.hintTextColor,
                                fontSize: 14,
                                fontFamily: AppFonts.sfProLight),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.word??"từ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.dark0,
                                    fontFamily: AppFonts.sfProMedium,
                                 fontWeight: FontWeight.w600),
                              ),
                              Container(
                                height: 24,
                                width: 24,
                                child: InkWell(
                                  onTap: widget.ontap,
                                  child: Image.asset(
                                    AppImages.icVolumeMock,
                                    color: AppColors.primary,
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.mean??"nghĩa",
                            maxLines: 1,
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontFamily: AppFonts.sfProRegular),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
