import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/feature/games/logic/games_cubit.dart';

/// Descoped per plan: no `pdf`/`printing` package exists in the project and
/// none is added this pass. The old "Download/Share PDF" stub buttons
/// (`onPressed: () {}`) are replaced with a single "عرض المحتوى كاملاً"
/// action that pops back to `GameDetailView` (already the previous screen on
/// the nav stack, reached via `GamePdfButton`), which shows the same real
/// body/steps. Also fixes the same hardcoded-content bug as
/// `game_detail_view.dart` by requiring the real [gameId].
class PDFPreviewView extends StatelessWidget {
  final String gameId;

  const PDFPreviewView({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GamesCubit>(
      create: (_) => sl<GamesCubit>()..loadGameById(gameId),
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<GamesCubit, GamesState>(
          builder: (context, state) {
            final game = state.selectedGame;
            final loading = state.status == GamesStatus.loading ||
                state.status == GamesStatus.initial;
            return Column(
              children: [
                AppHeader(
                  title: 'معاينة المحتوى',
                  subtitle: game?.title,
                  showBackButton: true,
                ),
                Expanded(
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: Container(
                            margin: EdgeInsets.all(24.W),
                            padding: EdgeInsets.all(24.W),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColors.gray300),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(game?.title ?? 'تعذر تحميل اللعبة',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20.SP,
                                        fontWeight: FontWeight.bold)),
                                Divider(height: 32.H),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      game != null && game.description.isNotEmpty
                                          ? game.description
                                          : 'لا يوجد محتوى متاح لهذه اللعبة حالياً.',
                                      style:
                                          TextStyle(fontSize: 13.SP, height: 1.6),
                                    ),
                                  ),
                                ),
                                8.vS,
                                Text('تطبيق "حياة كرمة"',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: AppColors.gray400, fontSize: 10.SP)),
                              ],
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.W),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.H,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white),
                      child: const Text('عرض المحتوى كاملاً'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
