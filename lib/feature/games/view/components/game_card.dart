import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/feature/games/data/model/game_model.dart';

class GameCard extends StatelessWidget {
  final GameModel game;
  final VoidCallback onTap;

  const GameCard({
    super.key,
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.H),
        padding: EdgeInsets.all(16.W),
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
              width: 80.W,
              height: 80.H,
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.circular(16.R),
              ),
              child: Center(
                child: Text(
                  game.illustration,
                  style: TextStyle(fontSize: 40.SP),
                ),
              ),
            ),
            16.hS,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.SP,
                    ),
                  ),
                  4.vS,
                  Text(
                    game.skill,
                    style: TextStyle(color: AppColors.gray600, fontSize: 12.SP),
                  ),
                  8.vS,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.W, vertical: 4.H),
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8.R),
                    ),
                    child: Text(
                      game.age,
                      style: TextStyle(
                        color: AppColors.gray600,
                        fontSize: 10.SP,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
