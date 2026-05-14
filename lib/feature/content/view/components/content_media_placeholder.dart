import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class ContentMediaPlaceholder extends StatelessWidget {
  final String type;

  const ContentMediaPlaceholder({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.H,
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(24.R),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == 'video' ? Icons.play_circle : Icons.book_online,
              size: 48.W,
              color: AppColors.gray400,
            ),
            12.vS,
            Text(
              type == 'video' ? 'اضغط للتشغيل' : 'اضغط للقراءة',
              style: const TextStyle(
                color: AppColors.gray600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
