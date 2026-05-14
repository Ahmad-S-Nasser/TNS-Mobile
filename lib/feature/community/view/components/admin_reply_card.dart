import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class AdminReplyCard extends StatelessWidget {
  final String reply;
  final String? adminName;

  const AdminReplyCard({
    super.key,
    required this.reply,
    this.adminName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified, color: Colors.teal),
              8.hS,
              const Text(
                'رد الإدارة',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          12.vS,
          Text(
            reply,
            style: const TextStyle(height: 1.6),
          ),
          if (adminName != null) ...[
            12.vS,
            Text(
              adminName!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.SP),
            ),
          ],
        ],
      ),
    );
  }
}
