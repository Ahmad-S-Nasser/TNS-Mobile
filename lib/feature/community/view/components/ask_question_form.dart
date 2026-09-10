import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_text_field.dart';
import 'package:tips_n_steps/feature/community/data/qa_repository.dart';

class AskQuestionForm extends StatefulWidget {
  final List<QaCategoryModel> categories;
  final bool isSubmitting;

  /// `(category, questionTextAr, isAnonymous)`.
  final void Function(String category, String questionTextAr, bool isAnonymous)
      onSubmit;

  const AskQuestionForm({
    super.key,
    required this.categories,
    required this.onSubmit,
    this.isSubmitting = false,
  });

  @override
  State<AskQuestionForm> createState() => _AskQuestionFormState();
}

class _AskQuestionFormState extends State<AskQuestionForm> {
  bool _isAnonymous = false;
  final TextEditingController _controller = TextEditingController();
  late String _selectedCategory =
      widget.categories.isNotEmpty ? widget.categories.first.name : 'General';

  @override
  void didUpdateWidget(covariant AskQuestionForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The category catalog can arrive asynchronously after the fallback
    // list is already rendered — keep the current selection if it's still
    // valid, otherwise fall back to the first real entry.
    final stillValid =
        widget.categories.any((c) => c.name == _selectedCategory);
    if (!stillValid && widget.categories.isNotEmpty) {
      setState(() => _selectedCategory = widget.categories.first.name);
    }
  }

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
            'التصنيف',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        8.vS,
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.gray50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.R),
              borderSide: const BorderSide(color: AppColors.gray200),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.W, vertical: 4.H),
          ),
          items: widget.categories
              .map((c) => DropdownMenuItem(value: c.name, child: Text(c.label)))
              .toList(),
          onChanged: widget.isSubmitting
              ? null
              : (value) {
                  if (value != null) setState(() => _selectedCategory = value);
                },
        ),
        24.vS,
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
          isClickable: !widget.isSubmitting,
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
              onChanged: widget.isSubmitting
                  ? null
                  : (v) => setState(() => _isAnonymous = v),
              activeThumbColor: AppColors.primaryBlue,
            ),
          ],
        ),
        32.vS,
        AppButton(
          text: 'إرسال السؤال',
          isLoading: widget.isSubmitting,
          onPressed: () => widget.onSubmit(
            _selectedCategory,
            _controller.text,
            _isAnonymous,
          ),
        ),
      ],
    );
  }
}
