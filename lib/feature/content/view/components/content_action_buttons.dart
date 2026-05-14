import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class ContentActionButtons extends StatelessWidget {
  final bool isSaved;
  final VoidCallback? onSave;
  final VoidCallback? onLike;
  final VoidCallback? onShare;

  const ContentActionButtons({
    super.key,
    required this.isSaved,
    this.onSave,
    this.onLike,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          icon: Icons.bookmark,
          label: 'حفظ',
          bgColor: isSaved ? const Color(0xFFF37423) : Colors.white,
          onTap: onSave,
        ),
        _buildActionButton(
          icon: Icons.thumb_up,
          label: 'إعجاب',
          bgColor: Colors.white,
          onTap: onLike,
        ),
        _buildActionButton(
          icon: Icons.share,
          label: 'مشاركة',
          bgColor: Colors.white,
          onTap: onShare,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color bgColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60.W,
            height: 60.H,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16.R),
              border: Border.all(color: AppColors.gray200),
            ),
            child: Icon(
              icon,
              color: bgColor == Colors.white ? AppColors.gray700 : Colors.white,
            ),
          ),
          4.vS,
          Text(
            label,
            style: TextStyle(fontSize: 10.SP, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
