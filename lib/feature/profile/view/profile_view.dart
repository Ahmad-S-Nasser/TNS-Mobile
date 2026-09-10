import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/profile/logic/profile_cubit.dart';
import 'package:tips_n_steps/feature/profile/view/components/profile_avatar.dart';
import 'package:tips_n_steps/feature/profile/view/components/profile_form.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => sl<ProfileCubit>()..loadMe(),
      child: Scaffold(
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
              child: BlocConsumer<ProfileCubit, ProfileState>(
                listenWhen: (previous, current) =>
                    current.errorMessage != null,
                listener: (context, state) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                },
                builder: (context, state) {
                  if (state.status == ProfileStatus.loading ||
                      state.status == ProfileStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.user == null) {
                    return const Center(child: Text('تعذر تحميل الملف الشخصي'));
                  }
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.W),
                    child: Column(
                      children: [
                        const ProfileAvatar(),
                        ProfileForm(user: state.user!),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
