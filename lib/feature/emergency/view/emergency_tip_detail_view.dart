import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';

class EmergencyTipDetailView extends StatelessWidget {
  final EmergencyTipModel tip;
  final VoidCallback onBack;

  const EmergencyTipDetailView({
    super.key,
    required this.tip,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.H, bottom: 24.H, left: 20.W, right: 20.W),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [tip.colorStart, tip.colorEnd]),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(40.R)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: onBack,
                    ),
                    8.hS,
                    Text(
                      tip.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.SP,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.W),
              children: [
                AppButton(
                  text: 'اتصل بالإسعاف 123',
                  onPressed: () {
                    // Call logic here
                  },
                ),
                24.vS,
                _buildSectionTitle(tip.icon, 'خطوات الإسعافات الأولية'),
                16.vS,
                ...tip.steps
                    .asMap()
                    .entries
                    .map((entry) => _buildStepRow(entry.key + 1, entry.value)),
                24.vS,
                _buildWarningBox(tip.warning),
                24.vS,
                _buildPreventionSection(tip.prevention),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.red, size: 24.W),
        12.hS,
        Text(title,
            style: TextStyle(fontSize: 18.SP, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildStepRow(int number, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.H),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.W,
            height: 32.H,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.pink]),
              shape: BoxShape.circle,
            ),
            child: Center(
                child: Text('$number',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          16.hS,
          Expanded(
              child:
                  Text(text, style: TextStyle(fontSize: 14.SP, height: 1.5))),
        ],
      ),
    );
  }

  Widget _buildWarningBox(String text) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning, color: Colors.red, size: 28.W),
          12.hS,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تحذير مهم',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16.SP,
                  ),
                ),
                4.vS,
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.red, fontSize: 13.SP, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreventionSection(List<String> items) {
    return Container(
      padding: EdgeInsets.all(20.W),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(24.R),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('🛡️', style: TextStyle(fontSize: 24.SP)),
              12.hS,
              Text(
                'الوقاية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.SP),
              ),
            ],
          ),
          12.vS,
          ...items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 8.H),
                child: Row(
                  children: [
                    Text('• ',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.SP)),
                    Expanded(
                        child: Text(item, style: TextStyle(fontSize: 13.SP))),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
