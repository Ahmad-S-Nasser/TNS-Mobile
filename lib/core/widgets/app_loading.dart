import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';

import '../../../core/helpers/extension.dart';
import '../../../core/theme/app_colors.dart';

class AppLoading extends StatelessWidget {
  final Color? backgroundColor;

  const AppLoading({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: ColoredBox(
        color: backgroundColor ?? Colors.black26,
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(
                AppImages.hayahLogo,
                height: 70.H,
                width: 70.W,
              ),
              SizedBox(
                height: 80.H,
                width: 80.W,
                child: const CircularProgressIndicator(
                  color: AppColors.tealDark,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
