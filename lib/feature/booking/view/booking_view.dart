import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/core/widgets/app_text_field.dart';
import 'package:tips_n_steps/core/widgets/success_state.dart';
import 'package:tips_n_steps/feature/booking/data/model/doctor_model.dart';
import 'package:tips_n_steps/feature/booking/view/components/expert_card.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

enum BookingStep { select, slot, confirm }

class _BookingViewState extends State<BookingView> {
  BookingStep _currentStep = BookingStep.select;
  int? _selectedDoctorId;
  int _selectedDateIndex = 0;
  String? _selectedTime;
  final TextEditingController _reasonController = TextEditingController();

  final List<DoctorModel> _doctors = [
    DoctorModel(
        id: 1,
        name: 'د. سارة أحمد',
        specialty: 'طب الأطفال وحديثي الولادة',
        rating: '4.9',
        price: '200 جنيه',
        avatar: '👩‍⚕️'),
    DoctorModel(
        id: 2,
        name: 'د. محمد العيد',
        specialty: 'نمو وتطور الطفل',
        rating: '4.8',
        price: '250 جنيه',
        avatar: '👨‍⚕️'),
    DoctorModel(
        id: 3,
        name: 'د. نورا حسن',
        specialty: 'أخصائية تخاطب وتنمية',
        rating: '4.9',
        price: '180 جنيه',
        avatar: '👩‍⚕️'),
    DoctorModel(
        id: 4,
        name: 'د. أحمد كريم',
        specialty: 'طب الأطفال العام',
        rating: '4.7',
        price: '150 جنيه',
        avatar: '👨‍⚕️'),
  ];

  final List<Map<String, String>> _dates = [
    {'label': 'اليوم', 'value': '14 أبريل'},
    {'label': 'غداً', 'value': '15 أبريل'},
    {'label': 'الأربعاء', 'value': '16 أبريل'},
    {'label': 'الخميس', 'value': '17 أبريل'},
    {'label': 'السبت', 'value': '19 أبريل'},
  ];

  final List<String> _timeSlots = [
    '9:00 ص',
    '10:00 ص',
    '11:00 ص',
    '12:00 م',
    '1:00 م',
    '3:00 م',
    '4:00 م',
    '5:00 م',
    '5:30 م',
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentStep == BookingStep.confirm) {
      final doctor = _doctors.firstWhere((d) => d.id == _selectedDoctorId);
      return SuccessState(
        title: 'تم الحجز! 🎉',
        description:
            'موعدك مع ${doctor.name} في ${_dates[_selectedDateIndex]['value']} الساعة $_selectedTime',
        actionLabel: 'العودة للرئيسية',
        onAction: () => context.pushReplacementNamed('/home'),
      );
    }

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.gray50,
      body: Column(
        children: [
          AppHeader(
            title: _currentStep == BookingStep.select
                ? 'حجز استشارة طبية'
                : 'اختر الموعد',
            subtitle: _currentStep == BookingStep.select
                ? 'اختر الطبيب المناسب لطفلك'
                : 'حدد الوقت والتاريخ المناسب',
            showBackButton: true,
            onBack: _currentStep == BookingStep.slot
                ? () => setState(() => _currentStep = BookingStep.select)
                : null,
          ),
          Expanded(
            child: _currentStep == BookingStep.select
                ? _buildDoctorList()
                : _buildSlotSelection(),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.W),
      itemCount: _doctors.length,
      itemBuilder: (context, index) {
        final doctor = _doctors[index];
        return ExpertCard(
          doctor: doctor,
          isSelected: _selectedDoctorId == doctor.id,
          onTap: () {
            setState(() {
              _selectedDoctorId = doctor.id;
              _currentStep = BookingStep.slot;
            });
          },
        );
      },
    );
  }

  Widget _buildSlotSelection() {
    final doctor = _doctors.firstWhere((d) => d.id == _selectedDoctorId);
    return ListView(
      padding: EdgeInsets.all(16.W),
      children: [
        ExpertCard(doctor: doctor, isSelected: true, onTap: () {}),
        24.vS,
        _buildSectionHeader('📅  اختر التاريخ'),
        12.vS,
        SizedBox(
          height: 100.H,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _dates.length,
            itemBuilder: (context, index) {
              final date = _dates[index];
              final isSelected = _selectedDateIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedDateIndex = index),
                child: Container(
                  width: 80.W,
                  margin: EdgeInsets.only(left: 12.W),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryBlue : Colors.white,
                    borderRadius: BorderRadius.circular(20.R),
                    border: Border.all(
                        color: isSelected
                            ? AppColors.primaryBlue
                            : AppColors.gray200,
                        width: 2.W),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(date['label']!,
                          style: TextStyle(
                              fontSize: 12.SP,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.gray600)),
                      4.vS,
                      Text(date['value']!.split(' ')[0],
                          style: TextStyle(
                              fontSize: 16.SP,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.gray800)),
                      Text(date['value']!.split(' ')[1],
                          style: TextStyle(
                              fontSize: 12.SP,
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.gray500)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        24.vS,
        _buildSectionHeader('🕐  اختر الوقت'),
        12.vS,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.H,
            crossAxisSpacing: 10.W,
            childAspectRatio: 2.2,
          ),
          itemCount: _timeSlots.length,
          itemBuilder: (context, index) {
            final slot = _timeSlots[index];
            final isSelected = _selectedTime == slot;
            return GestureDetector(
              onTap: () => setState(() => _selectedTime = slot),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryBlue : Colors.white,
                  borderRadius: BorderRadius.circular(16.R),
                  border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlue
                          : AppColors.gray200,
                      width: 2.W),
                ),
                alignment: Alignment.center,
                child: Text(slot,
                    style: TextStyle(
                        fontSize: 14.SP,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : AppColors.gray700)),
              ),
            );
          },
        ),
        24.vS,
        _buildSectionHeader('📝  سبب الزيارة'),
        12.vS,
        AppTextField(
          controller: _reasonController,
          maxLine: 3,
          hint: 'اذكر سبب الزيارة أو أي ملاحظات للطبيب...',
        ),
        32.vS,
        AppButton(
          text: '✅  تأكيد الحجز',
          onPressed: _selectedTime != null
              ? () => setState(() => _currentStep = BookingStep.confirm)
              : null,
        ),
        80.vS,
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: TextStyle(
            fontSize: 18.SP,
            fontWeight: FontWeight.bold,
            color: AppColors.gray800));
  }
}
