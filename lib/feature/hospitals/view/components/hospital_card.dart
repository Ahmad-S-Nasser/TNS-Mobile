import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/hospitals/data/model/hospital_model.dart';

class HospitalCard extends StatelessWidget {
  final HospitalModel hospital;

  const HospitalCard({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.H),
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: AppColors.gray200, width: 2.W),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56.W,
            height: 56.H,
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(16.R),
            ),
            child: Center(
              child: Text(
                hospital.illustration,
                style: TextStyle(fontSize: 24.SP),
              ),
            ),
          ),
          16.hS,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hospital.name,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.SP),
                ),
                Text(
                  hospital.location,
                  style: TextStyle(color: AppColors.gray500, fontSize: 12.SP),
                ),
                8.vS,
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14.W),
                        Text(
                          hospital.rating,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.SP,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.W, vertical: 4.H),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(20.R),
                      ),
                      child: Text(
                        hospital.distance,
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 10.SP,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
