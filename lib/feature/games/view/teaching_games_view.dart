import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/games/data/model/game_model.dart';
import 'package:tips_n_steps/feature/games/view/components/game_card.dart';

class TeachingGamesView extends StatelessWidget {
  const TeachingGamesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<GameModel> games = [
      GameModel(
          title: 'لعبة تصنيف الألوان',
          skill: 'التمييز والتصنيف',
          age: '3-5 سنوات',
          illustration: '🎨'),
      GameModel(
          title: 'لعبة القفز على الأشكال',
          skill: 'التوازن والتنسيق',
          age: '4-6 سنوات',
          illustration: '🏃'),
    ];

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const AppHeader(
              title: 'ألعاب تعليمية',
              subtitle: 'اكتشفي ألعاب ممتعة لتطوير مهارات طفلك'),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.W),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return GameCard(
                  game: game,
                  onTap: () => context.pushNamed('/teaching-games/1'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
