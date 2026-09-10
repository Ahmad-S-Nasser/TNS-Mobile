part of 'qa_cubit.dart';

enum QaListStatus { initial, loading, loaded, error }

enum QaActionStatus { idle, submitting, success, error }

class QaState extends Equatable {
  final QaListStatus listStatus;
  final List<QuestionModel> questions;
  final String? listErrorMessage;

  final List<QaCategoryModel> categories;

  final QaActionStatus actionStatus;
  final String? actionErrorMessage;

  const QaState({
    required this.listStatus,
    this.questions = const [],
    this.listErrorMessage,
    this.categories = qaFallbackCategories,
    this.actionStatus = QaActionStatus.idle,
    this.actionErrorMessage,
  });

  const QaState.initial() : this(listStatus: QaListStatus.initial);

  /// There is no `GET /mobile/qa/questions/{id}` — a single question is
  /// resolved by scanning the already-loaded list.
  QuestionModel? findById(String id) {
    for (final question in questions) {
      if (question.id == id) return question;
    }
    return null;
  }

  QaState copyWith({
    QaListStatus? listStatus,
    List<QuestionModel>? questions,
    String? listErrorMessage,
    List<QaCategoryModel>? categories,
    QaActionStatus? actionStatus,
    String? actionErrorMessage,
  }) =>
      QaState(
        listStatus: listStatus ?? this.listStatus,
        questions: questions ?? this.questions,
        listErrorMessage: listErrorMessage,
        categories: categories ?? this.categories,
        actionStatus: actionStatus ?? this.actionStatus,
        actionErrorMessage: actionErrorMessage,
      );

  @override
  List<Object?> get props => [
        listStatus,
        questions,
        listErrorMessage,
        categories,
        actionStatus,
        actionErrorMessage,
      ];
}
