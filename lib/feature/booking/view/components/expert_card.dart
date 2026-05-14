import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/booking/data/model/doctor_model.dart';

class ExpertCard extends StatelessWidget {
  final DoctorModel doctor;
  final bool isSelected;
  final VoidCallback onTap;

  const ExpertCard({
    super.key,
    required this.doctor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.H),
        padding: EdgeInsets.all(20.W),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.R),
          border: Border.all(
              color: isSelected ? AppColors.primaryBlue : Colors.transparent,
              width: 2.W),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
          ],
        ),
        child: Row(
          children: [
            Text(doctor.avatar, style: TextStyle(fontSize: 40.SP)),
            16.hS,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.SP)),
                  Text(doctor.specialty,
                      style:
                          TextStyle(color: AppColors.gray500, fontSize: 14.SP)),
                  8.vS,
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16.W),
                      Text(doctor.rating,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.SP)),
                      const Spacer(),
                      Text(doctor.price,
                          style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.SP)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
