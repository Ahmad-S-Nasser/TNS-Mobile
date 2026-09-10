import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/hospitals/data/model/hospital_model.dart';

/// Fixes the confirmed bug: this card had no `onTap` at all (dead-end list).
/// `location`/`distance` were dropped (no backend equivalent); `rating` is
/// shown only when the real `averageRating` value is present.
class HospitalCard extends StatelessWidget {
  final HospitalModel hospital;
  final VoidCallback onTap;

  const HospitalCard({
    super.key,
    required this.hospital,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                  if (hospital.description.isNotEmpty) ...[
                    4.vS,
                    Text(
                      hospital.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.gray500, fontSize: 12.SP),
                    ),
                  ],
                  if (hospital.rating != null) ...[
                    8.vS,
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14.W),
                        4.hS,
                        Text(
                          hospital.rating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.SP,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.gray400),
          ],
        ),
      ),
    );
  }
}
