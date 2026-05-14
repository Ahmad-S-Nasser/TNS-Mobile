import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class EmergencyKitButton extends StatelessWidget {
  final VoidCallback onTap;

  const EmergencyKitButton({
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
          gradient: const LinearGradient(
              colors: [Color(0xFF1B59B2), Color(0xFF0D3A7A)]),
          borderRadius: BorderRadius.circular(24.R),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF1B59B2).withValues(alpha: 0.3),
                blurRadius: 10)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('🏥', style: TextStyle(fontSize: 24.SP)),
            12.hS,
            Text('حقيبة الإسعافات الأولية',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.SP)),
          ],
        ),
      ),
    );
  }
}
