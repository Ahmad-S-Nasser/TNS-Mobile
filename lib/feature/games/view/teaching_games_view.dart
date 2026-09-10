import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/games/logic/games_cubit.dart';
import 'package:tips_n_steps/feature/games/view/components/game_card.dart';

class TeachingGamesView extends StatelessWidget {
  const TeachingGamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GamesCubit>(
      create: (_) => sl<GamesCubit>()..loadGames(),
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const AppHeader(
                title: 'ألعاب تعليمية',
                subtitle: 'اكتشفي ألعاب ممتعة لتطوير مهارات طفلك'),
            Expanded(
              child: BlocBuilder<GamesCubit, GamesState>(
                builder: (context, state) {
                  if (state.status == GamesStatus.loading ||
                      state.status == GamesStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == GamesStatus.error) {
                    return Center(
                        child: Text(state.errorMessage ?? 'تعذر تحميل الألعاب'));
                  }
                  if (state.games.isEmpty) {
                    return const Center(child: Text('لا توجد ألعاب متاحة حالياً'));
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(16.W),
                    itemCount: state.games.length,
                    itemBuilder: (context, index) {
                      final game = state.games[index];
                      // Real tapped item's id flows via route arguments —
                      // fixes the confirmed bug where every game opened
                      // identical hardcoded detail content.
                      return GameCard(
                        game: game,
                        onTap: () => context.pushNamed(
                          AppRoutes.gameDetail,
                          arguments: game.id,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
