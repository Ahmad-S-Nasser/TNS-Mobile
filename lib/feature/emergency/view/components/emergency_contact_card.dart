import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';

class EmergencyContactCard extends StatelessWidget {
  final EmergencyNumberModel contact;

  const EmergencyContactCard({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: AppColors.gray200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.W),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [contact.colorStart, contact.colorEnd]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.R)),
            ),
            child: Center(
              child: Column(
                children: [
                  Text(contact.illustration, style: TextStyle(fontSize: 32.SP)),
                  Text(contact.number,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.SP)),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.W),
            child: Column(
              children: [
                Text(contact.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.SP)),
                4.vS,
                Text(contact.description,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: AppColors.gray500, fontSize: 10.SP)),
                8.vS,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.W, vertical: 4.H),
                  decoration: BoxDecoration(
                      color: const Color(0xFF23A99A),
                      borderRadius: BorderRadius.circular(10.R)),
                  child: Text(contact.available,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.SP,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
