import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? maxFontSize;
  final double? minFontSize;
  final TextAlign? textAlign;

  const NormalText(this.data,
      { Key? key, this.style, this.maxLines, this.overflow, this.maxFontSize, this.minFontSize, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data,
      style: style,
      maxLines: maxLines,
      overflow: overflow,
      maxFontSize: maxFontSize ?? style?.fontSize ?? double.infinity,
      minFontSize: minFontSize ?? ((style?.fontSize ?? 12) - 4) ?? 12,
      textAlign: textAlign,
    );
  }
}