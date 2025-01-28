
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class DropDownButtonV2 extends StatefulWidget {
  final List<String> items;
  final String? hint;
  final String? tittle;
  final Function(String?)? onChange;
  const DropDownButtonV2({
    super.key,
    required this.items,
    this.hint,
    this.onChange,
    this.tittle,
  });

  @override
  State<DropDownButtonV2> createState() => _DropDownButtonV2State();
}

class _DropDownButtonV2State extends State<DropDownButtonV2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Text(
            widget.tittle ?? "Quân",
            style: AppFonts.quicksandSemi600(
              16,
              AppColors.grey500,
            ),
          ),
        ),
        DropdownButtonFormField2(
          hint: Text(
            widget.hint ?? "Quân nè",
            style: AppFonts.quicksandMedium500(
              16,
              AppColors.grey500,
            ),
          ),
          items: widget.items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: AppFonts.quicksandMedium500(
                  16,
                  AppColors.grey500,
                ),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 0,
            ),
          ),
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                AppImages.iconArrowDown,
                width: 24,
                height: 24,
              ),
            ),
          ),
          onChanged: widget.onChange ??
              (String? newValue) {
                setState(() {
                  // dropdownvalue = newValue!;
                });
              },
        ),
      ],
    );
  }
}
