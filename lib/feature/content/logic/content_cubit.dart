import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/network/api_exceptions.dart';
import 'package:tips_n_steps/feature/content/data/content_repository.dart';
import 'package:tips_n_steps/feature/content/data/model/content_item.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  final ContentRepository _repository;

  ContentCubit(this._repository) : super(const ContentState.initial());

  Future<void> loadSections() async {
    emit(state.copyWith(sectionsStatus: ContentSectionsStatus.loading));
    try {
      final sections = await _repository.getSections();
      emit(state.copyWith(
        sectionsStatus: ContentSectionsStatus.loaded,
        sections: sections,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        sectionsStatus: ContentSectionsStatus.error,
        sectionsError: e.userMessage,
      ));
    }
  }

  /// Loads the first page for the given section filter (`null` = all
  /// sections). Resets any previously loaded page/items.
  Future<void> loadContent({int? sectionId, String lang = 'ar'}) async {
    emit(state.copyWith(
      listStatus: ContentListStatus.loading,
      selectedSectionId: sectionId,
      clearSelectedSectionId: sectionId == null,
      page: 1,
    ));
    try {
      final result = await _repository.list(
        sectionId: sectionId,
        lang: lang,
        page: 1,
      );
      emit(state.copyWith(
        listStatus: ContentListStatus.loaded,
        items: result.items,
        page: result.page,
        pageSize: result.pageSize,
        totalCount: result.totalCount,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        listStatus: ContentListStatus.error,
        listError: e.userMessage,
      ));
    }
  }

  Future<void> loadMore({String lang = 'ar'}) async {
    if (state.listStatus == ContentListStatus.loadingMore || !state.hasMore) {
      return;
    }
    emit(state.copyWith(listStatus: ContentListStatus.loadingMore));
    try {
      final nextPage = state.page + 1;
      final result = await _repository.list(
        sectionId: state.selectedSectionId,
        lang: lang,
        page: nextPage,
        pageSize: state.pageSize,
      );
      emit(state.copyWith(
        listStatus: ContentListStatus.loaded,
        items: [...state.items, ...result.items],
        page: result.page,
        totalCount: result.totalCount,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        listStatus: ContentListStatus.loaded,
        listError: e.userMessage,
      ));
    }
  }

  Future<void> loadDetail(String id, {String lang = 'ar'}) async {
    emit(state.copyWith(detailStatus: ContentDetailStatus.loading));
    try {
      final item = await _repository.getById(id, lang: lang);
      emit(state.copyWith(
        detailStatus: ContentDetailStatus.loaded,
        detailItem: item,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(
        detailStatus: ContentDetailStatus.error,
        detailError: e.userMessage,
      ));
    }
  }

  void clearDetail() {
    emit(state.copyWith(
      detailStatus: ContentDetailStatus.initial,
      clearDetailItem: true,
    ));
  }
}
