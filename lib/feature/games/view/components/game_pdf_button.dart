import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_button.dart';

class GamePdfButton extends StatelessWidget {
  final String gameId;

  const GamePdfButton({
    super.key,
    required this.gameId,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'تحميل كملف PDF',
      onPressed: () => context.pushNamed('/teaching-games/$gameId/pdf'),
    );
  }
}
