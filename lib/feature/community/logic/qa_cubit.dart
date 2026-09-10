import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/community/data/model/question_model.dart';
import 'package:tips_n_steps/feature/community/data/qa_repository.dart';

part 'qa_state.dart';

class QaCubit extends Cubit<QaState> {
  final QaRepository _repository;

  QaCubit(this._repository) : super(const QaState.initial());

  /// Loads the full question list. Also used by [QuestionDetailView] to
  /// resolve a single question by id — there is no `GET .../questions/{id}`
  /// endpoint, only the list one.
  Future<void> loadQuestions() async {
    emit(state.copyWith(listStatus: QaListStatus.loading));
    try {
      final questions = await _repository.getQuestions();
      emit(state.copyWith(
        listStatus: QaListStatus.loaded,
        questions: questions,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        listStatus: QaListStatus.error,
        listErrorMessage: e.userMessage,
      ));
    }
  }

  /// Refreshes the category catalog for the ask-a-question form. Failure is
  /// swallowed — [QaState.categories] already defaults to a static fallback
  /// list, so a flaky catalog fetch shouldn't block asking a question.
  Future<void> loadCategories() async {
    try {
      final categories = await _repository.getCategories();
      if (categories.isNotEmpty) {
        emit(state.copyWith(categories: categories));
      }
    } on AppException {
      // Keep the fallback categories already in state.
    }
  }

  Future<bool> askQuestion({
    required String category,
    required String questionTextAr,
    String? questionTextEn,
    bool isAnonymous = false,
  }) async {
    emit(state.copyWith(
      actionStatus: QaActionStatus.submitting,
      actionErrorMessage: null,
    ));
    try {
      await _repository.askQuestion(
        category: category,
        questionTextAr: questionTextAr,
        questionTextEn: questionTextEn,
        isAnonymous: isAnonymous,
      );
      emit(state.copyWith(actionStatus: QaActionStatus.success));
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(
        actionStatus: QaActionStatus.error,
        actionErrorMessage: e.userMessage,
      ));
      return false;
    }
  }

  Future<bool> answerQuestion({
    required String questionId,
    required String doctorId,
    required String answerText,
  }) async {
    emit(state.copyWith(
      actionStatus: QaActionStatus.submitting,
      actionErrorMessage: null,
    ));
    try {
      await _repository.answerQuestion(
        questionId: questionId,
        doctorId: doctorId,
        answerText: answerText,
      );
      // Refresh the list so the newly-answered question reflects its real
      // status/answer for whoever is looking at admin_questions_view.
      await loadQuestions();
      emit(state.copyWith(actionStatus: QaActionStatus.success));
      return true;
    } on AppException catch (e) {
      emit(state.copyWith(
        actionStatus: QaActionStatus.error,
        actionErrorMessage: e.userMessage,
      ));
      return false;
    }
  }
}
