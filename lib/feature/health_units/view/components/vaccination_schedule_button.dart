import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class VaccinationScheduleButton extends StatelessWidget {
  final VoidCallback onTap;

  const VaccinationScheduleButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.W),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.purple, Colors.pink]),
          borderRadius: BorderRadius.circular(20.R),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withValues(alpha: 0.3),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_month, color: Colors.white),
            12.hS,
            Text(
              'عرض جدول التطعيمات الكامل',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.SP,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
