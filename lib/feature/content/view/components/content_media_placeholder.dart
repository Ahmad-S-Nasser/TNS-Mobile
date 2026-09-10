import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class ContentMediaPlaceholder extends StatelessWidget {
  final String type;
  final String? thumbnailUrl;

  const ContentMediaPlaceholder({
    super.key,
    required this.type,
    this.thumbnailUrl,
  });

  bool get _isVideo => type.toLowerCase() == 'video';

  @override
  Widget build(BuildContext context) {
    final hasThumbnail = thumbnailUrl != null && thumbnailUrl!.isNotEmpty;
    return Container(
      height: 200.H,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(24.R),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (hasThumbnail)
            Image.network(
              thumbnailUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          if (!hasThumbnail || _isVideo)
            Container(
              color: hasThumbnail ? Colors.black.withValues(alpha: 0.25) : null,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isVideo ? Icons.play_circle : Icons.book_online,
                      size: 48.W,
                      color: hasThumbnail ? Colors.white : AppColors.gray400,
                    ),
                    if (!hasThumbnail) ...[
                      12.vS,
                      Text(
                        _isVideo ? 'اضغط للتشغيل' : 'اضغط للقراءة',
                        style: const TextStyle(
                          color: AppColors.gray600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
