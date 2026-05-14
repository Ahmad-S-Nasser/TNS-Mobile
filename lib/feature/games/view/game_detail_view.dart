import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/games/view/components/game_pdf_button.dart';
import 'package:tips_n_steps/feature/games/view/components/game_step_item.dart';

class GameDetailView extends StatelessWidget {
  const GameDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
              title: 'لعبة تصنيف الألوان',
              subtitle: 'التمييز والتصنيف البصري',
              showBackButton: true),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.W),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الخطوات',
                      style: TextStyle(
                          fontSize: 18.SP, fontWeight: FontWeight.bold)),
                  16.vS,
                  const GameStepItem(
                    number: 1,
                    title: 'تحضير المواد',
                    desc:
                        'اجمعي المكعبات الملونة والأوراق. ضعي كل لون في مجموعة منفصلة.',
                  ),
                  const GameStepItem(
                    number: 2,
                    title: 'شرح اللعبة',
                    desc: 'اشرحي للطفل أننا سنصنف الأشياء حسب الألوان.',
                  ),
                  const GameStepItem(
                    number: 3,
                    title: 'البدء باللعب',
                    desc:
                        'اطلبي من الطفل وضع كل مكعب على الورقة التي تطابق لونه.',
                  ),
                  24.vS,
                  const GamePdfButton(gameId: '1'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
