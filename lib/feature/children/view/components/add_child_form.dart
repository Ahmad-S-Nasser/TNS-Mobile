import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';
import 'package:tips_n_steps/feature/children/data/model/child_model.dart';

/// Payload the form hands back on submit. Fixes the previous bug where the
/// form's controllers/date-picker/gender-selector were never read before
/// calling a bare `VoidCallback`.
typedef AddChildSubmit = void Function({
  required String fullName,
  required DateTime dateOfBirth,
  required String gender,
  String? bloodType,
});

const List<String> _bloodTypes = [
  'A+',
  'A-',
  'B+',
  'B-',
  'AB+',
  'AB-',
  'O+',
  'O-',
];

class AddChildForm extends StatefulWidget {
  /// When non-null, the form pre-fills from this child — the same widget
  /// is reused for both "add" (null) and "edit" (existing child) flows.
  final ChildModel? existingChild;
  final AddChildSubmit onSubmit;
  final bool isSubmitting;

  const AddChildForm({
    super.key,
    this.existingChild,
    required this.onSubmit,
    this.isSubmitting = false,
  });

  @override
  State<AddChildForm> createState() => _AddChildFormState();
}

class _AddChildFormState extends State<AddChildForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _dateController;
  String _selectedGender = 'male';
  String? _selectedBloodType;
  DateTime? _dateOfBirth;
  String? _validationError;

  @override
  void initState() {
    super.initState();
    final existing = widget.existingChild;
    _nameController = TextEditingController(text: existing?.fullName ?? '');
    _selectedGender = existing?.gender ?? 'male';
    _selectedBloodType = existing?.bloodType;
    _dateOfBirth = existing?.dateOfBirth;
    _dateController = TextEditingController(text: _formatDate(_dateOfBirth));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(now.year - 1, now.month, now.day),
      firstDate: DateTime(now.year - 18),
      lastDate: now,
    );
    if (picked == null) return;
    setState(() {
      _dateOfBirth = picked;
      _dateController.text = _formatDate(picked);
    });
  }

  void _handleSubmit() {
    final name = _nameController.text.trim();
    if (name.isEmpty || _dateOfBirth == null || _selectedGender.isEmpty) {
      setState(() =>
          _validationError = 'يرجى تعبئة اسم الطفل، النوع، وتاريخ الميلاد');
      return;
    }
    setState(() => _validationError = null);
    widget.onSubmit(
      fullName: name,
      dateOfBirth: _dateOfBirth!,
      gender: _selectedGender,
      bloodType: _selectedBloodType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.W),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.R),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppInput(
            label: 'اسم الطفل',
            hint: 'أدخل اسم الطفل',
            controller: _nameController,
            prefixIcon: const Icon(Icons.person_outline),
          ),
          20.vS,
          Text(
            'النوع',
            style: TextStyle(
                fontSize: 14.SP,
                fontWeight: FontWeight.w600,
                color: AppColors.gray600),
          ),
          8.vS,
          Row(
            children: [
              Expanded(
                child: _buildGenderButton('ذكر', 'male', AppColors.primaryBlue,
                    Colors.blue.withValues(alpha: 0.05)),
              ),
              12.hS,
              Expanded(
                child: _buildGenderButton('أنثى', 'female', Colors.pink,
                    Colors.pink.withValues(alpha: 0.05)),
              ),
            ],
          ),
          20.vS,
          GestureDetector(
            onTap: _pickDate,
            child: AbsorbPointer(
              child: AppInput(
                label: 'تاريخ الميلاد',
                hint: 'اختر تاريخ الميلاد',
                prefixIcon: const Icon(Icons.calendar_today_outlined),
                controller: _dateController,
                keyboardType: TextInputType.datetime,
              ),
            ),
          ),
          20.vS,
          Text(
            'فصيلة الدم (اختياري)',
            style: TextStyle(
                fontSize: 14.SP,
                fontWeight: FontWeight.w600,
                color: AppColors.gray600),
          ),
          8.vS,
          DropdownButtonFormField<String>(
            value: _selectedBloodType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.R)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.W),
            ),
            items: _bloodTypes
                .map((type) =>
                    DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (v) => setState(() => _selectedBloodType = v),
            hint: const Text('اختر فصيلة الدم'),
          ),
          if (_validationError != null) ...[
            12.vS,
            Text(
              _validationError!,
              style: TextStyle(color: AppColors.error, fontSize: 13.SP),
            ),
          ],
          32.vS,
          AppButton(
            text:
                widget.existingChild != null ? 'حفظ التعديلات' : 'إضافة الطفل',
            isLoading: widget.isSubmitting,
            onPressed: _handleSubmit,
          ),
        ],
      ),
    );
  }

  Widget _buildGenderButton(
      String label, String value, Color color, Color bgColor) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = value),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.H),
        decoration: BoxDecoration(
          color: isSelected ? bgColor : Colors.white,
          borderRadius: BorderRadius.circular(24.R),
          border: Border.all(
            color: isSelected ? color : AppColors.gray300,
            width: 2.W,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.SP,
              fontWeight: FontWeight.bold,
              color: isSelected ? color : AppColors.gray700,
            ),
          ),
        ),
      ),
    );
  }
}
