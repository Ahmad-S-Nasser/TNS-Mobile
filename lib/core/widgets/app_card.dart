import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

enum AppCardVariant { defaultVariant, outlined, elevated }

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final Color? color;
  final BoxBorder? border;
  final List<BoxShadow>? shadow;
  final AppCardVariant variant;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.radius,
    this.color,
    this.border,
    this.shadow,
    this.variant = AppCardVariant.defaultVariant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    switch (variant) {
      case AppCardVariant.outlined:
        decoration = BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 24.R),
          border:
              border ?? Border.all(color: const Color(0xFFE5E7EB), width: 1.W),
        );
        break;
      case AppCardVariant.elevated:
        decoration = BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 24.R),
          boxShadow: shadow ??
              [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 15.R,
                  offset: Offset(0, 4.H),
                ),
              ],
        );
        break;
      case AppCardVariant.defaultVariant:
        decoration = BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 24.R),
          border: border,
          boxShadow: shadow ??
              [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10.R,
                  offset: Offset(0, 2.H),
                ),
              ],
        );
    }

    Widget content = Container(
      padding: padding ?? EdgeInsets.all(16.W),
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
