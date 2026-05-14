import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class ServiceCard extends StatefulWidget {
  final String title;
  final String? image;
  final String? iconPath;
  final String? emoji;
  final LinearGradient gradient;
  final Color accentColor;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    this.image,
    this.iconPath,
    this.emoji,
    required this.gradient,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.R),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: widget.gradient,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.R),
                      topRight: Radius.circular(24.R),
                    ),
                  ),
                  padding: EdgeInsets.all(16.W),
                  child: Center(
                    child: widget.image != null
                        ? Image.asset(widget.image!, fit: BoxFit.contain)
                        : widget.iconPath != null
                            ? SvgPicture.asset(widget.iconPath!,
                                width: 48.W,
                                height: 48.H,
                                colorFilter: ColorFilter.mode(
                                    widget.accentColor, BlendMode.srcIn))
                            : Text(
                                widget.emoji ?? '',
                                style: TextStyle(fontSize: 48.SP),
                              ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.W),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 14.SP,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF374151),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    6.vS,
                    Container(
                      width: 28.W,
                      height: 2.H,
                      decoration: BoxDecoration(
                        color: widget.accentColor.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(99.R),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(
        begin: const Offset(0.9, 0.9),
        end: const Offset(1, 1),
        curve: Curves.easeOutBack);
  }
}
