import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Color? enabledColor, fillColor, hintColor, focusColor, controllerColor;
  final double? tPadding, hintSize, bPadding;
  final double? borderRadius;
  final TextInputType? type;
  final Function()? onTap;
  final dynamic Function(dynamic)? onFieldSubmitted;
  final Function(String)? onChanged;
  final bool? isPassword;
  final int? maxLine, hintMaxLine;
  final String? Function(String?)? validate;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final Function()? suffixPressed;
  final bool? isClickable;
  final bool? autocorrect, isFill;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final bool? enabled;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;

  const AppTextField({
    super.key,
    this.borderRadius,
    this.maxLine,
    this.textAlign,
    this.controller,
    this.type,
    this.focusNode,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.textStyle,
    this.isPassword,
    this.validate,
    this.hint,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.isClickable,
    this.autocorrect,
    this.focusColor,
    this.enabledColor,
    this.tPadding,
    this.enabled,
    this.isFill,
    this.inputFormatters,
    this.fillColor,
    this.hintColor,
    this.hintSize,
    this.bPadding,
    this.onEditingComplete,
    this.controllerColor,
    this.hintMaxLine,
    this.fontWeight,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onEditingComplete: onEditingComplete,
        cursorColor: AppColors.primaryBlue,
        style: TextStyle(
            color: controllerColor ?? AppColors.gray900,
            fontSize: 14.SP,
            fontWeight: fontWeight ?? FontWeight.w400),
        textAlign: textAlign ?? TextAlign.start,
        decoration: InputDecoration(
          errorMaxLines: 5,
          filled: isFill ?? true,
          fillColor: fillColor ?? AppColors.gray50,
          errorStyle: TextStyle(fontSize: 10.SP, color: AppColors.error),
          contentPadding: EdgeInsets.only(
              left: 15.W,
              right: 15.W,
              top: tPadding ?? 10.H,
              bottom: bPadding ?? 10.H),
          disabledBorder: (enabled == true)
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: enabledColor ?? AppColors.gray200,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 16.R),
                  borderSide: BorderSide(
                    color: enabledColor ?? AppColors.gray200,
                  ),
                ),
          focusedBorder: (enabled == true)
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: focusColor ?? AppColors.primaryBlue,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 16.R),
                  borderSide: BorderSide(
                    color: focusColor ?? AppColors.primaryBlue,
                  ),
                ),
          enabledBorder: (enabled == true)
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: enabledColor ?? AppColors.gray200,
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 16.R),
                  borderSide: BorderSide(
                    color: enabledColor ?? AppColors.gray200,
                  ),
                ),
          border: (enabled == true)
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 16.R),
                  borderSide: const BorderSide(),
                ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.R),
            borderSide: const BorderSide(color: AppColors.error),
          ),
          hintText: hint,
          hintMaxLines: hintMaxLine,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: hintSize ?? 12.SP,
            color: hintColor ?? AppColors.gray400,
          ),
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
        controller: controller,
        keyboardType: type,
        obscureText: isPassword ?? false,
        enabled: isClickable ?? true,
        focusNode: focusNode,
        onTap: onTap,
        validator: validate,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        maxLines: (isPassword ?? false) ? 1 : maxLine,
        inputFormatters: inputFormatters,
        autofillHints: autofillHints,
        scrollPhysics: const AlwaysScrollableScrollPhysics());
  }
}
