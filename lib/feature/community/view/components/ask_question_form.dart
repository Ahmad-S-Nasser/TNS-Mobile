import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_text_field.dart';

class AskQuestionForm extends StatefulWidget {
  final Function(String, bool) onSubmit;

  const AskQuestionForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AskQuestionForm> createState() => _AskQuestionFormState();
}

class _AskQuestionFormState extends State<AskQuestionForm> {
  bool _isAnonymous = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'ما هو سؤالك؟',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        8.vS,
        AppTextField(
          controller: _controller,
          maxLine: 8,
          hint: 'اكتبي سؤالك بوضوح...',
        ),
        24.vS,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'إرسال بشكل مجهول',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Switch(
              value: _isAnonymous,
              onChanged: (v) => setState(() => _isAnonymous = v),
              activeThumbColor: AppColors.primaryBlue,
            ),
          ],
        ),
        32.vS,
        AppButton(
          text: 'إرسال السؤال',
          onPressed: () => widget.onSubmit(_controller.text, _isAnonymous),
        ),
      ],
    );
  }
}
