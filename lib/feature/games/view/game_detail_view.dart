import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/games/logic/games_cubit.dart';
import 'package:tips_n_steps/feature/games/view/components/game_pdf_button.dart';
import 'package:tips_n_steps/feature/games/view/components/game_step_item.dart';

/// Fixes the confirmed bug: this used to be a zero-arg widget hardcoding
/// identical content ('لعبة تصنيف الألوان' + 3 fixed steps) regardless of
/// which game was tapped. Now requires the real [gameId] and fetches/renders
/// that specific item.
class GameDetailView extends StatelessWidget {
  final String gameId;

  const GameDetailView({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GamesCubit>(
      create: (_) => sl<GamesCubit>()..loadGameById(gameId),
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            BlocBuilder<GamesCubit, GamesState>(
              builder: (context, state) {
                final game = state.selectedGame;
                return AppHeader(
                  title: game?.title ?? 'تفاصيل اللعبة',
                  subtitle: game?.skill,
                  showBackButton: true,
                );
              },
            ),
            Expanded(
              child: BlocBuilder<GamesCubit, GamesState>(
                builder: (context, state) {
                  if (state.status == GamesStatus.loading ||
                      state.status == GamesStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == GamesStatus.error ||
                      state.selectedGame == null) {
                    return Center(
                        child:
                            Text(state.errorMessage ?? 'تعذر تحميل بيانات اللعبة'));
                  }
                  final game = state.selectedGame!;
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16.W),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (game.age.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.W, vertical: 4.H),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.circular(8.R),
                            ),
                            child: Text(game.age, style: TextStyle(fontSize: 11.SP)),
                          ),
                        16.vS,
                        Text('الخطوات',
                            style: TextStyle(
                                fontSize: 18.SP, fontWeight: FontWeight.bold)),
                        16.vS,
                        if (game.steps.isEmpty)
                          const Text('لا تتوفر خطوات تفصيلية لهذه اللعبة حالياً.')
                        else
                          ...game.steps.asMap().entries.map((e) => GameStepItem(
                                number: e.key + 1,
                                title: 'الخطوة ${e.key + 1}',
                                desc: e.value,
                              )),
                        24.vS,
                        GamePdfButton(gameId: gameId),
                      ],
                    ),
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
