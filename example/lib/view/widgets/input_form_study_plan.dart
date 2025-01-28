import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/widgets/calendar_date_picker.dart';

class InputFormStudyPlan extends StatefulWidget {
  InputFormStudyPlan({
    super.key,
    required this.tittle,
    this.onTap,
    this.onChanged,
    required this.labelText,
    this.isCalendar = false,
  });

  final String labelText;
  final String tittle;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool isCalendar;

  @override
  State<InputFormStudyPlan> createState() => _InputFormStudyPlanState();
}

class _InputFormStudyPlanState extends State<InputFormStudyPlan> {
  Future<DateTime?> showCustomCalendar(
      BuildContext context, DateTime initialDate) async {
    DateTime? pickedDate;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
// Loại bỏ header
              content: SizedBox(
                width: 400,
                child: CalendarDatePickerCustom(
                  initialDate: initialDate,
                  firstDate: DateTime(DateTime.now().year - 10),
                  lastDate: DateTime(DateTime.now().year + 10),
                  onDateChanged: (DateTime date) {
                    pickedDate = date;
                  },
                ),
              ),
              // actions: [
              //   SizedBox(
              //     width: double.infinity,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(
              //           child: TextButton(
              //             onPressed: () {
              //               Navigator.pop(context); // Đóng dialog
              //             },
              //             child: Container(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 50, vertical: 15),
              //               decoration: BoxDecoration(
              //                 color: AppColors.primary50,
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               child: Text(
              //                 "Đóng",
              //                 style: AppFonts.quicksandSemi600(
              //                   16,
              //                   AppColors.grey500,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         // SizedBox(
              //         //     width:
              //         //         10), // Khoảng cách giữa hai nút button
              //         Expanded(
              //           child: TextButton(
              //             onPressed: () async {
              //               // Xử lý khi người dùng nhấn nút OK
              //               Navigator.pop(context);
              //             },
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 gradient: const LinearGradient(
              //                   begin: Alignment.topLeft,
              //                   end: Alignment.bottomCenter,
              //                   colors: [
              //                     Color(0xFF4AACFF),
              //                     Color(0xFF1F92F1),
              //                   ],
              //                 ),
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 50, vertical: 15),
              //               child: Text(
              //                 "Tiếp",
              //                 style: AppFonts.quicksandSemi600(
              //                   16,
              //                   Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ],
            );
          },
        );
      },
    );
    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.tittle,
            style: AppFonts.quicksand600(
              16,
              AppColors.grey500,
            )),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onFieldSubmitted: (value) {}, // Submit form
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            labelText: widget.labelText,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppThemes.kPrimary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors.grey300,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
              ),
              child: InkWell(
                onTap: () async {
                  showCustomCalendar(context, DateTime.now());
                },
                child: Icon(
                  Icons.calendar_month_outlined,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
