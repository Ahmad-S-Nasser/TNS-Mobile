import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_card.dart';

class ChildCard extends StatelessWidget {
  final String name;
  final String age;
  final String emoji;
  final String gender; // 'male' or 'female'
  final VoidCallback onGrowthClick;
  final VoidCallback onContentClick;

  const ChildCard({
    super.key,
    required this.name,
    required this.age,
    required this.emoji,
    required this.gender,
    required this.onGrowthClick,
    required this.onContentClick,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMale = gender.toLowerCase() == 'male';
    final Color accentColor = isMale ? AppColors.primaryBlue : AppColors.teal;

    return AppCard(
      padding: EdgeInsets.all(20.W),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 64.W,
                height: 64.H,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    emoji,
                    style: TextStyle(fontSize: 32.SP),
                  ),
                ),
              ),
              16.hS,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.SP,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray900,
                      ),
                    ),
                    4.vS,
                    Text(
                      age,
                      style: TextStyle(
                        fontSize: 14.SP,
                        color: AppColors.gray600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          20.vS,
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  label: 'مجالات النمو',
                  icon: Icons.auto_graph,
                  color: AppColors.primaryBlue,
                  onTap: onGrowthClick,
                ),
              ),
              12.hS,
              Expanded(
                child: _buildActionButton(
                  label: 'محتوى الطفل',
                  icon: Icons.book_outlined,
                  color: AppColors.teal,
                  onTap: onContentClick,
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.1, end: 0, curve: Curves.easeOutQuad);
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return _AnimatedActionButton(
      label: label,
      icon: icon,
      color: color,
      onTap: onTap,
    );
  }
}

class _AnimatedActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AnimatedActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  State<_AnimatedActionButton> createState() => _AnimatedActionButtonState();
}

class _AnimatedActionButtonState extends State<_AnimatedActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.H),
          decoration: BoxDecoration(
            color: widget.color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.R),
            border: Border.all(
                color: widget.color.withValues(alpha: 0.1), width: 1.W),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 18.SP, color: widget.color),
              8.hS,
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13.SP,
                  fontWeight: FontWeight.bold,
                  color: widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
