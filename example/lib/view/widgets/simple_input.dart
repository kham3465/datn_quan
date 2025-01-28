
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_colors.dart';
import 'package:flutter_background_geolocation_example/view/app_theme/app_theme.dart';
import 'package:flutter_background_geolocation_example/view/res/fonts/app_fonts.dart';
import 'package:flutter_background_geolocation_example/view/res/images/app_images.dart';

class SimpleInput extends StatefulWidget {
  SimpleInput(
      {super.key,
      required this.titleInput,
      this.isPassword = false,
      this.iconSuffix,
      this.obscureText = true,
      this.controller,
      this.nextFocusNode,
      this.onFieldSubmitted,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.colorIcon,
      this.onTap,
      this.style,
      this.hintText,
      this.dimen});
  final String titleInput;
  final bool isPassword;
  bool obscureText;
  final double? dimen;
  final Icon? iconSuffix;
  final String? hintText;
  final TextStyle? style;
  final TextEditingController? controller;
  final FocusNode? nextFocusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Color? colorIcon;
  final Function()? onTap;

  @override
  State<SimpleInput> createState() => _SimpleInputState();
}

class _SimpleInputState extends State<SimpleInput> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.nextFocusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.nextFocusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: 1,
          text: TextSpan(
            text: '',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            children: widget.titleInput.contains('*')
                ? [
                    TextSpan(
                      style: widget.style ??
                          AppFonts.quicksandSemi600(
                            16,
                            AppColors.grey500,
                          ),
                      text: widget.titleInput
                          .substring(0, widget.titleInput.indexOf('*')),
                    ),
                    const TextSpan(
                      text: '*',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppThemes.red0,
                      ),
                    ),
                    TextSpan(
                      text: widget.titleInput
                          .substring(widget.titleInput.indexOf('*') + 1),
                      style: widget.style ??
                          AppFonts.quicksandSemi600(
                            16,
                            AppColors.grey500,
                          ),
                    ),
                  ]
                : [
                    TextSpan(
                      text: widget.titleInput,
                      style: widget.style ??
                          AppFonts.quicksandSemi600(
                            16,
                            AppColors.grey500,
                          ),
                    ),
                  ],
          ),
        ),
        SizedBox(
          height: widget.dimen ?? 5,
        ),
        TextFormField(
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          focusNode: _focusNode,
          controller: widget.controller,
          onFieldSubmitted: (value) {
            if (widget.nextFocusNode != null) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            }

            if (widget.onFieldSubmitted != null) {
              widget.onFieldSubmitted!(value);
            }
          },
          obscureText: widget.isPassword ? widget.obscureText : false,
          decoration: InputDecoration(
            hintText: widget.hintText ?? "",
            hintStyle: AppFonts.quicksandMedium500(
              16,
              AppColors.grey300,
            ),
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppThemes.kPrimary),
            ),
            errorStyle: AppFonts.light(12, AppThemes.kPrimary).copyWith(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xffB8B8D2)),
            ),
            suffixIcon: widget.isPassword
                ? Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                      top: 16,
                      bottom: 16,
                    ),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.obscureText = !widget.obscureText;
                          });
                        },
                        child: Image.asset(
                          !widget.obscureText
                              ? AppImages.iconEye
                              : AppImages.iconEyeClose,
                          width: 18,
                          height: 16,
                          fit: BoxFit.fitWidth,
                          color: widget.colorIcon ?? const Color(0xff1F1F39),
                        )),
                  )
                : const SizedBox.shrink(),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 18,
              minHeight: 16,
            ),
            icon: widget.iconSuffix?? SizedBox.shrink(),
            contentPadding: const EdgeInsets.only(
              left: 20,
              bottom: 15,
              top: 15,
            ),
          ),
        ),
      ],
    );
  }
}
