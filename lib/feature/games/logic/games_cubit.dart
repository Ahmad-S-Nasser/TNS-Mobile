import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/games/data/games_repository.dart';
import 'package:tips_n_steps/feature/games/data/model/game_model.dart';

part 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  final GamesRepository _repository;

  GamesCubit(this._repository) : super(const GamesState.initial());

  Future<void> loadGames() async {
    emit(state.copyWith(status: GamesStatus.loading));
    try {
      final games = await _repository.getGames();
      emit(state.copyWith(status: GamesStatus.loaded, games: games));
    } on AppException catch (e) {
      emit(state.copyWith(status: GamesStatus.error, errorMessage: e.userMessage));
    }
  }

  /// Used by both `GameDetailView` and `PDFPreviewView` — each screen owns
  /// its own `GamesCubit` instance (via DI factory) scoped to a single
  /// `gameId`, fixing the confirmed bug where both views hardcoded identical
  /// content regardless of which item was tapped.
  Future<void> loadGameById(String id) async {
    emit(state.copyWith(status: GamesStatus.loading));
    try {
      final game = await _repository.getGameById(id);
      emit(state.copyWith(status: GamesStatus.loaded, selectedGame: game));
    } on AppException catch (e) {
      emit(state.copyWith(status: GamesStatus.error, errorMessage: e.userMessage));
    }
  }
}
