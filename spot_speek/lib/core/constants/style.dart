import 'dart:ui';
import 'package:spot_speek/core/constants/app_colors.dart';

TextStyle _primaryTextStyle(
    {required double size, FontWeight? weight, Color? color}) {
  return TextStyle(color: color, fontWeight: weight);
}

TextStyle customLargeStyle({required double size, Color? color}) {
  return _primaryTextStyle(
      size: size, weight: FontWeight.w700, color: color ?? AppColors.primary);
}
