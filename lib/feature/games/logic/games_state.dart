part of 'games_cubit.dart';

enum GamesStatus { initial, loading, loaded, error }

class GamesState extends Equatable {
  final GamesStatus status;
  final List<GameModel> games;
  final GameModel? selectedGame;
  final String? errorMessage;

  const GamesState({
    required this.status,
    this.games = const [],
    this.selectedGame,
    this.errorMessage,
  });

  const GamesState.initial() : this(status: GamesStatus.initial);

  GamesState copyWith({
    GamesStatus? status,
    List<GameModel>? games,
    GameModel? selectedGame,
    String? errorMessage,
  }) =>
      GamesState(
        status: status ?? this.status,
        games: games ?? this.games,
        selectedGame: selectedGame ?? this.selectedGame,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [status, games, selectedGame, errorMessage];
}
