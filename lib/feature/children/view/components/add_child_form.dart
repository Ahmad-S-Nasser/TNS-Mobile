import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_input.dart';

class AddChildForm extends StatefulWidget {
  final VoidCallback onSubmit;

  const AddChildForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<AddChildForm> createState() => _AddChildFormState();
}

class _AddChildFormState extends State<AddChildForm> {
  String _selectedGender = '';

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
          const AppInput(
            label: 'اسم الطفل',
            hint: 'أدخل اسم الطفل',
            prefixIcon: Icon(Icons.person_outline),
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
          const AppInput(
            label: 'تاريخ الميلاد',
            hint: 'اختر تاريخ الميلاد',
            prefixIcon: Icon(Icons.calendar_today_outlined),
            keyboardType: TextInputType.datetime,
          ),
          20.vS,
          Text(
            'نوع الولادة',
            style: TextStyle(
                fontSize: 14.SP,
                fontWeight: FontWeight.w600,
                color: AppColors.gray600),
          ),
          8.vS,
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24.R)),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.W),
            ),
            items: const [
              DropdownMenuItem(value: 'natural', child: Text('طبيعية')),
              DropdownMenuItem(value: 'cesarean', child: Text('قيصرية')),
            ],
            onChanged: (v) {},
            hint: const Text('اختر نوع الولادة'),
          ),
          20.vS,
          const AppInput(
            label: 'مدة الحمل (بالأسابيع)',
            hint: 'مثال: 38',
            keyboardType: TextInputType.number,
          ),
          32.vS,
          AppButton(
            text: 'إضافة الطفل',
            onPressed: widget.onSubmit,
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
