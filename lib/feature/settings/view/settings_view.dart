import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/feature/settings/view/components/change_password_dialog.dart';
import 'package:tips_n_steps/feature/settings/view/components/logout_button.dart';
import 'package:tips_n_steps/feature/settings/view/components/settings_section.dart';

class SettingsView extends StatelessWidget {
  final bool showBottomNav;

  const SettingsView({super.key, this.showBottomNav = true});

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('هذه الميزة قيد التطوير')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showBottomNav: showBottomNav,
      currentRoute: '/settings',
      title: 'الإعدادات',
      subtitle: 'تخصيص تجربة التطبيق الخاصة بك',
      useScrollContainer: false,
      body: ListView(
        padding: EdgeInsets.all(16.W),
        children: [
          SettingsSection(title: 'الحساب', items: [
            SettingsItem(
                icon: Icons.person,
                label: 'الملف الشخصي',
                onTap: () => context.pushNamed(AppRoutes.profile)),
            SettingsItem(
                icon: Icons.lock,
                label: 'تغيير كلمة المرور',
                onTap: () => showChangePasswordDialog(context)),
          ]),
          16.vS,
          SettingsSection(title: 'التطبيق', items: [
            SettingsItem(
                icon: Icons.language,
                label: 'اللغة',
                onTap: () => _showComingSoon(context),
                trailing: 'العربية'),
          ]),
          16.vS,
          SettingsSection(title: 'الدعم', items: [
            SettingsItem(
                icon: Icons.message,
                label: 'إرسال ملاحظات',
                onTap: () => _showComingSoon(context)),
            SettingsItem(
                icon: Icons.info,
                label: 'حول التطبيق',
                onTap: () => _showComingSoon(context)),
          ]),
          32.vS,
          const LogoutButton(),
        ],
      ),
    );
  }
}
