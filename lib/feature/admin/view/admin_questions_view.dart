import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/admin/view/components/admin_question_card.dart';

class AdminQuestionsView extends StatelessWidget {
  const AdminQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
            title: '[ADMIN] إدارة الأسئلة',
            subtitle: 'واجهة إدارة استفسارات الأمهات',
            showBackButton: true,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.W),
              children: [
                _buildSectionHeader('بانتظار الرد (2)'),
                AdminQuestionCard(
                  author: 'سارة محمد',
                  text: 'متى يجب أن أبدأ بتعليم طفلي الحروف؟',
                  time: 'منذ 6 ساعات',
                  onReply: () {},
                ),
                AdminQuestionCard(
                  author: 'أم مجهولة',
                  text: 'طفلي لا يحب اللعب مع الآخرين',
                  time: 'منذ يوم',
                  onReply: () {},
                ),
                24.vS,
                _buildSectionHeader('تم الرد عليها'),
                const AdminQuestionCard(
                  author: 'منى أحمد',
                  text: 'تأخر النطق عند 3 سنوات',
                  time: 'منذ يومين',
                  isAnswered: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.H),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryBlue,
        ),
      ),
    );
  }
}
