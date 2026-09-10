import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';
import 'package:tips_n_steps/feature/profile/data/model/user_model.dart';
import 'package:tips_n_steps/feature/profile/logic/profile_cubit.dart';

class ProfileForm extends StatefulWidget {
  final UserModel user;

  const ProfileForm({super.key, required this.user});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _phoneController = TextEditingController(text: widget.user.phoneNumber ?? '');
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final success = await context.read<ProfileCubit>().save(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(success ? 'تم حفظ التغييرات بنجاح' : 'تعذر حفظ التغييرات'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current.status == ProfileStatus.saving ||
          previous.status == ProfileStatus.saving,
      builder: (context, state) {
        final isSaving = state.status == ProfileStatus.saving;
        return Column(
          children: [
            AppInput(
              label: 'الاسم الأول',
              hint: 'أدخل اسمك الأول',
              controller: _firstNameController,
            ),
            16.vS,
            AppInput(
              label: 'اسم العائلة',
              hint: 'أدخل اسم العائلة',
              controller: _lastNameController,
            ),
            16.vS,
            // Email is not editable via PUT /mobile/users/me — display only,
            // its value is never included in the save payload.
            AppInput(
              label: 'البريد الإلكتروني',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            16.vS,
            AppInput(
              label: 'رقم الهاتف',
              hint: 'أدخل رقم هاتفك',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            32.vS,
            AppButton(
              text: 'حفظ التغييرات',
              isLoading: isSaving,
              onPressed: _handleSave,
            ),
          ],
        );
      },
    );
  }
}
