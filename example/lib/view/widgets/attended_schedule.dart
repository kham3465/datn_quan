
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class AttendedSchedule extends StatelessWidget {
  final String nameTeacher;
  final List<String> time;
  final String school;
  final String classMn;
  final int check;
  final String address;
  final checkRequest;
    final String? confirm;
  final String count;
  final String? report;
  const AttendedSchedule(
      {super.key,
      this.report,
      this.confirm,
      required this.checkRequest,
      required this.nameTeacher,
      required this.time,
      required this.school,
      required this.classMn,
      required this.address,
      required this.check,
      required this.count});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.grey2, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("[PHÂN CÔNG LỊCH DẠY]",
              style: AppFonts.quicksand900(16, AppColors.black1)),
          SizedBox(height: 4),
          Text(checkRequest?"Người nhận: ":"Người gửi: " + nameTeacher ?? "",
              style: AppFonts.quicksand600(16, AppColors.grey4)),
          SizedBox(height: 12),
          CustomDashedDivider(),
          SizedBox(height: 12),
          Row(
            children: [
              Image.asset(AppImages.school2, width: 20, height: 20),
              SizedBox(
                width: 6,
              ),
              Text("Trường: " + school,
                  style: AppFonts.quicksandMedium500(16, AppColors.black1)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Image.asset(AppImages.class2, width: 20, height: 20),
              SizedBox(
                width: 6,
              ),
              Text("Lớp: " + classMn ?? "",
                  style: AppFonts.quicksandMedium500(16, AppColors.black1)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Image.asset(AppImages.location2, width: 20, height: 20),
              SizedBox(
                width: 6,
              ),
              Text("Địa chỉ: " + address ?? "",
                  style: AppFonts.quicksandMedium500(16, AppColors.black1)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Image.asset(AppImages.countSt, width: 20, height: 20),
              SizedBox(
                width: 6,
              ),
              Text("Sĩ số: " + count ?? "",
                  style: AppFonts.quicksandMedium500(16, AppColors.black1)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Image.asset(AppImages.schedule_teacher, width: 20, height: 20),
              SizedBox(
                width: 6,
              ),
              Text("Lịch dạy: ",
                  style: AppFonts.quicksandMedium500(16, AppColors.black1)),
            ],
          ),
          SizedBox(height: 8),
          Wrap(
            direction: Axis.horizontal,
            runSpacing: 12,
            spacing: 12,
            children: List.generate(
                time.length,
                (index) => Container(
                    width: 160,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
                    child: Row(children: [
                      Image.asset(AppImages.clock,
                          color: Colors.black, width: 16, height: 16),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        time[index] ?? "T4: 07:00 - 8:00",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ]))),
          ),
          SizedBox(
            height: 12,
          ),
          if (check == 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [Container(
                    decoration: BoxDecoration(
                        color: AppColors.pink1,
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text("Từ chối",
                        style: AppFonts.quicksandMedium500(14, AppColors.white)),
                  ),
                  SizedBox(width:8),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.green5,
                            borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text("Xác nhận",
                            style: AppFonts.quicksandMedium500(14, AppColors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            )
            else if(check==2)
            Container()
            else if(check==3)
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(report??"Lý do tôi bận",style:AppFonts.quicksand600(14, AppColors.black3)),
              ],
            )
            else if(check==4)
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Xác nhận ngày: "+confirm!),
              ],
            )
        ],
      ),
    );
  }
}

class CustomDashedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 5.0;
        final dashHeight = 1.0;
        final dashCount = (constraints.maxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: AppColors.grey3),
              ),
            );
          }),
        );
      },
    );
  }
}