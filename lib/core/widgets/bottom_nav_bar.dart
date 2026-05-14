import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tips_n_steps/core/helpers/app_assets.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';

class NavItem {
  final String label;
  final String iconPath;
  final String route;

  NavItem({required this.label, required this.iconPath, required this.route});
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<NavItem> items = [
      NavItem(
          label: 'الإعدادات', iconPath: AppIcons.settings, route: '/settings'),
      NavItem(label: 'الأطفال', iconPath: AppIcons.users, route: '/children'),
      NavItem(label: 'الطوارئ', iconPath: AppIcons.alert, route: '/emergency'),
      NavItem(label: 'المحتوى', iconPath: AppIcons.book, route: '/content'),
      NavItem(label: 'الرئيسية', iconPath: AppIcons.home, route: '/home'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.gray200, width: 1.W)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.R,
            offset: Offset(0, -2.H),
          ),
        ],
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: 8.H, bottom: 24.H, left: 16.W, right: 16.W),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isActive = selectedIndex == index;
            return GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.W, vertical: 8.H),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primaryBlue.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16.R),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      item.iconPath,
                      width: 24.W,
                      height: 24.H,
                      colorFilter: ColorFilter.mode(
                        isActive ? AppColors.primaryBlue : AppColors.gray500,
                        BlendMode.srcIn,
                      ),
                    ),
                    4.vS,
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 11.SP,
                        fontWeight: FontWeight.bold,
                        color: isActive
                            ? AppColors.primaryBlue
                            : AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
