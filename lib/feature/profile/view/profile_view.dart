import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/profile/view/components/profile_avatar.dart';
import 'package:tips_n_steps/feature/profile/view/components/profile_form.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
            title: 'الملف الشخصي',
            subtitle: 'إدارة معلوماتك الشخصية',
            showBackButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.W),
              child: const Column(children: [ProfileAvatar(), ProfileForm()]),
            ),
          ),
        ],
      ),
    );
  }
}
