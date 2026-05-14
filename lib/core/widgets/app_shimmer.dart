import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../helpers/extension.dart';

class AppShimmer extends StatelessWidget {
  final double? radius, height, width, padding;
  final bool? isCircle, isWhite;

  const AppShimmer(
      {super.key,
      this.radius,
      this.height,
      this.width,
      this.padding,
      this.isCircle,
      this.isWhite});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: isWhite == true ? Colors.grey[100]! : Colors.white30,
        highlightColor: Colors.grey[50]!,
        child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(padding ?? 15),
          decoration: BoxDecoration(
            borderRadius:
                isCircle == true ? null : BorderRadius.circular(radius ?? 6.R),
            shape: isCircle == true ? BoxShape.circle : BoxShape.rectangle,
            color: Colors.grey[50]!,
          ),
        ));
  }
}
