import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';
import 'package:tips_n_steps/feature/auth/data/auth_repository.dart';

/// A single-action screen backed directly by [AuthRepository] rather than a
/// dedicated cubit — this is a one-shot form with no list/stream state to
/// manage, so a full Cubit would be pure ceremony.
Future<void> showChangePasswordDialog(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _ChangePasswordSheet(),
  );
}

class _ChangePasswordSheet extends StatefulWidget {
  const _ChangePasswordSheet();

  @override
  State<_ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<_ChangePasswordSheet> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_newController.text.isEmpty || _currentController.text.isEmpty) {
      _showMessage('يرجى تعبئة جميع الحقول');
      return;
    }
    if (_newController.text != _confirmController.text) {
      _showMessage('كلمتا المرور الجديدتان غير متطابقتين');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await sl<AuthRepository>().changePassword(
        currentPassword: _currentController.text,
        newPassword: _newController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      _showMessage('تم تغيير كلمة المرور بنجاح');
    } on AppException catch (e) {
      _showMessage(e.userMessage);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.W,
        right: 24.W,
        top: 24.H,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.H,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.R),
        ),
        padding: EdgeInsets.all(20.W),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تغيير كلمة المرور',
              style: TextStyle(fontSize: 18.SP, fontWeight: FontWeight.bold),
            ),
            16.vS,
            AppInput(
              label: 'كلمة المرور الحالية',
              controller: _currentController,
              obscureText: true,
            ),
            12.vS,
            AppInput(
              label: 'كلمة المرور الجديدة',
              controller: _newController,
              obscureText: true,
            ),
            12.vS,
            AppInput(
              label: 'تأكيد كلمة المرور الجديدة',
              controller: _confirmController,
              obscureText: true,
            ),
            20.vS,
            AppButton(
              text: 'حفظ',
              isLoading: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
