import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.R,
          backgroundColor: AppColors.primaryBlue,
          child: Icon(Icons.person, size: 60.W, color: Colors.white),
        ),
        24.vS,
      ],
    );
  }
}
