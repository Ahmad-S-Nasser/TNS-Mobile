import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/feature/content/logic/content_cubit.dart';
import 'package:tips_n_steps/feature/content/view/components/content_card.dart';
import 'package:tips_n_steps/feature/content/view/components/content_category_filter.dart';
import 'package:tips_n_steps/feature/content/view/components/content_stats_card.dart';
import 'package:tips_n_steps/feature/content/view/components/content_weekly_tip.dart';
import 'package:tips_n_steps/feature/content/view/content_detail_view.dart';

class ContentView extends StatefulWidget {
  final bool showBottomNav;

  const ContentView({super.key, this.showBottomNav = true});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  late final ContentCubit _cubit;

  String? _selectedContentId;

  /// Purely local, session-only bookmark toggle. There is no backend
  /// saved/favorites endpoint, so this is intentionally not persisted
  /// (replaces the old hardcoded/mismatched `_savedItems` set).
  final Set<String> _savedIds = {};

  // Cosmetic-only lookup: the sections catalog only gives {id,name,slug},
  // not an emoji/color, so those are derived client-side by slug with a
  // generic fallback for any section not covered here.
  static const Map<String, Map<String, dynamic>> _sectionStyle = {
    'behavior': {'emoji': '😤', 'color': Color(0xFFF37423)},
    'nutrition': {'emoji': '🍎', 'color': Color(0xFF23A99A)},
    'growth': {'emoji': '📊', 'color': Color(0xFF1B59B2)},
    'health': {'emoji': '🏥', 'color': Colors.red},
    'education': {'emoji': '🎓', 'color': Color(0xFFF37423)},
  };
  static const Map<String, dynamic> _defaultStyle = {
    'emoji': '📚',
    'color': Color(0xFF1B59B2),
  };

  @override
  void initState() {
    super.initState();
    _cubit = sl<ContentCubit>();
    _cubit.loadSections();
    _cubit.loadContent();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _toggleSaved(String id) {
    setState(() {
      if (!_savedIds.remove(id)) _savedIds.add(id);
    });
  }

  void _openItem(String id) {
    setState(() => _selectedContentId = id);
    _cubit.loadDetail(id);
  }

  void _closeItem() {
    setState(() => _selectedContentId = null);
    _cubit.clearDetail();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContentCubit>.value(
      value: _cubit,
      child: Builder(builder: (context) {
        if (_selectedContentId != null) {
          return ContentDetailView(
            isSaved: _savedIds.contains(_selectedContentId),
            onToggleSaved: () => _toggleSaved(_selectedContentId!),
            onBack: _closeItem,
          );
        }

        return BlocBuilder<ContentCubit, ContentState>(
          builder: (context, state) {
            final categories = <Map<String, dynamic>>[
              {
                'id': 'all',
                'name': 'الكل',
                'emoji': '📚',
                'color': const Color(0xFF1B59B2),
              },
              ...state.sections.map((s) {
                final style = _sectionStyle[s.slug] ?? _defaultStyle;
                return {
                  'id': s.id.toString(),
                  'name': s.name,
                  'emoji': style['emoji'],
                  'color': style['color'],
                };
              }),
            ];

            return AppLayout(
              showBottomNav: widget.showBottomNav,
              currentRoute: '/content',
              title: 'المحتوى التعليمي',
              subtitle: 'مقالات وفيديوهات مفيدة لكي',
              useScrollContainer: false,
              body: ListView(
                padding: EdgeInsets.all(16.W),
                children: [
                  ContentCategoryFilter(
                    categories: categories,
                    selectedCategory: state.selectedSectionId?.toString() ?? 'all',
                    onCategorySelected: (catId) => _cubit.loadContent(
                      sectionId: catId == 'all' ? null : int.tryParse(catId),
                    ),
                  ),
                  16.vS,
                  ContentStatsCard(
                    availableCount: state.totalCount,
                    savedCount: _savedIds.length,
                  ),
                  16.vS,
                  ..._buildListSection(state),
                  16.vS,
                  const ContentWeeklyTip(),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  List<Widget> _buildListSection(ContentState state) {
    if (state.listStatus == ContentListStatus.loading) {
      return const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }
    if (state.listStatus == ContentListStatus.error) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Center(
            child: Text(state.listError ?? 'تعذر تحميل المحتوى'),
          ),
        ),
      ];
    }
    if (state.items.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Center(child: Text('لا يوجد محتوى متاح حالياً')),
        ),
      ];
    }
    return [
      ...state.items.map((item) => ContentCard(
            item: item,
            isSaved: _savedIds.contains(item.id),
            onTap: () => _openItem(item.id),
          )),
      if (state.hasMore)
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.H),
          child: Center(
            child: state.listStatus == ContentListStatus.loadingMore
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: () => _cubit.loadMore(),
                    child: const Text('تحميل المزيد'),
                  ),
          ),
        ),
    ];
  }
}
