import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/content/data/model/content_item.dart';

class ContentCard extends StatelessWidget {
  final ContentItem item;
  final bool isSaved;
  final VoidCallback onTap;

  const ContentCard({
    super.key,
    required this.item,
    required this.isSaved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.H),
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: AppColors.gray100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 64.W,
              height: 64.H,
              decoration: BoxDecoration(
                color: const Color(0xFF1B59B2).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.R),
              ),
              child: Center(
                child: Text(
                  item.emoji,
                  style: TextStyle(fontSize: 32.SP),
                ),
              ),
            ),
            16.hS,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.W, vertical: 4.H),
                        decoration: BoxDecoration(
                          color: item.isVideo
                              ? Colors.red.withValues(alpha: 0.1)
                              : const Color(0xFF1B59B2).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10.R),
                        ),
                        child: Text(
                          item.isVideo ? 'فيديو' : 'مقالة',
                          style: TextStyle(
                            fontSize: 10.SP,
                            fontWeight: FontWeight.bold,
                            color:
                                item.isVideo ? Colors.red : const Color(0xFF1B59B2),
                          ),
                        ),
                      ),
                      8.hS,
                      if (isSaved)
                        Icon(Icons.bookmark,
                            size: 14.W, color: const Color(0xFFF37423)),
                    ],
                  ),
                  4.vS,
                  Text(item.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.SP)),
                  4.vS,
                  Row(
                    children: [
                      Icon(item.isVideo ? Icons.play_circle : Icons.book,
                          size: 14.W, color: AppColors.gray400),
                      4.hS,
                      Text('${item.formattedViewCount} مشاهدة',
                          style: TextStyle(
                              fontSize: 10.SP, color: AppColors.gray500)),
                      12.hS,
                      Icon(Icons.star, size: 14.W, color: Colors.amber),
                      4.hS,
                      Text(item.averageRating.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 10.SP, color: AppColors.gray500)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.gray400),
          ],
        ),
      ),
    );
  }
}
