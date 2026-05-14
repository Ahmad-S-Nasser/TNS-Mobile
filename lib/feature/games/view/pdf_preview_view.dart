import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';

class PDFPreviewView extends StatelessWidget {
  const PDFPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
              title: 'معاينة PDF',
              subtitle: 'لعبة تصنيف الألوان',
              showBackButton: true),
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(24.W),
                padding: EdgeInsets.all(24.W),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.gray300),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10)
                    ]),
                child: Column(
                  children: [
                    Text('لعبة تصنيف الألوان',
                        style: TextStyle(
                            fontSize: 20.SP, fontWeight: FontWeight.bold)),
                    Divider(height: 32.H),
                    const Text(
                        'هذه معاينة لملف PDF الذي سيتم تحميله على هاتفك.'),
                    const Spacer(),
                    Text('تم إنشاء الملف من تطبيق "حياة كرمة"',
                        style: TextStyle(
                            color: AppColors.gray400, fontSize: 10.SP)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.W),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white),
                        child: const Text('تحميل'))),
                12.hS,
                Expanded(
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text('مشاركة'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
