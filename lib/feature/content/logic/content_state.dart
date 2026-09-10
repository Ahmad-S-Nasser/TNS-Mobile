part of 'content_cubit.dart';

enum ContentSectionsStatus { initial, loading, loaded, error }

enum ContentListStatus { initial, loading, loadingMore, loaded, error }

enum ContentDetailStatus { initial, loading, loaded, error }

class ContentState extends Equatable {
  final ContentSectionsStatus sectionsStatus;
  final List<ContentSection> sections;
  final String? sectionsError;

  final ContentListStatus listStatus;
  final List<ContentItem> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final int? selectedSectionId;
  final String? listError;

  final ContentDetailStatus detailStatus;
  final ContentItem? detailItem;
  final String? detailError;

  const ContentState({
    this.sectionsStatus = ContentSectionsStatus.initial,
    this.sections = const [],
    this.sectionsError,
    this.listStatus = ContentListStatus.initial,
    this.items = const [],
    this.page = 1,
    this.pageSize = 20,
    this.totalCount = 0,
    this.selectedSectionId,
    this.listError,
    this.detailStatus = ContentDetailStatus.initial,
    this.detailItem,
    this.detailError,
  });

  const ContentState.initial() : this();

  bool get hasMore => items.length < totalCount;

  ContentState copyWith({
    ContentSectionsStatus? sectionsStatus,
    List<ContentSection>? sections,
    String? sectionsError,
    ContentListStatus? listStatus,
    List<ContentItem>? items,
    int? page,
    int? pageSize,
    int? totalCount,
    int? selectedSectionId,
    bool clearSelectedSectionId = false,
    String? listError,
    ContentDetailStatus? detailStatus,
    ContentItem? detailItem,
    bool clearDetailItem = false,
    String? detailError,
  }) =>
      ContentState(
        sectionsStatus: sectionsStatus ?? this.sectionsStatus,
        sections: sections ?? this.sections,
        sectionsError: sectionsError,
        listStatus: listStatus ?? this.listStatus,
        items: items ?? this.items,
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        totalCount: totalCount ?? this.totalCount,
        selectedSectionId: clearSelectedSectionId
            ? null
            : (selectedSectionId ?? this.selectedSectionId),
        listError: listError,
        detailStatus: detailStatus ?? this.detailStatus,
        detailItem: clearDetailItem ? null : (detailItem ?? this.detailItem),
        detailError: detailError,
      );

  @override
  List<Object?> get props => [
        sectionsStatus,
        sections,
        sectionsError,
        listStatus,
        items,
        page,
        pageSize,
        totalCount,
        selectedSectionId,
        listError,
        detailStatus,
        detailItem,
        detailError,
      ];
}
