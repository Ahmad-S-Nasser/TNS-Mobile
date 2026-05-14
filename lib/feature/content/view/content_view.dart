import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/feature/content/data/model/content_item.dart';
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
  String _selectedCategory = 'all';
  int? _selectedContentId;
  final Set<int> _savedItems = {2, 4, 7};

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'all',
      'name': 'الكل',
      'emoji': '📚',
      'color': const Color(0xFF1B59B2)
    },
    {
      'id': 'behavior',
      'name': 'السلوك',
      'emoji': '😤',
      'color': const Color(0xFFF37423)
    },
    {
      'id': 'nutrition',
      'name': 'التغذية',
      'emoji': '🍎',
      'color': const Color(0xFF23A99A)
    },
    {
      'id': 'growth',
      'name': 'النمو',
      'emoji': '📊',
      'color': const Color(0xFF1B59B2)
    },
    {'id': 'health', 'name': 'الصحة', 'emoji': '🏥', 'color': Colors.red},
    {
      'id': 'education',
      'name': 'التعليم',
      'emoji': '🎓',
      'color': const Color(0xFFF37423)
    },
  ];

  final List<ContentItem> _contentItems = [
    ContentItem(
      id: 1,
      type: 'video',
      title: 'كيفية التعامل مع نوبات الغضب',
      duration: '15 دقيقة',
      category: 'behavior',
      categoryName: 'السلوك',
      emoji: '😤',
      expert: 'د. سارة أحمد - أخصائية نفسية',
      views: '12.5k',
      rating: 4.8,
      description:
          'تعلم أفضل الطرق للتعامل مع نوبات الغضب عند الأطفال بطريقة صحية وبناءة',
      topics: ['السلوك', 'الانفعالات', 'التربية الإيجابية'],
    ),
    ContentItem(
      id: 2,
      type: 'article',
      title: 'التغذية السليمة للأطفال في عمر السنتين',
      duration: '5 دقائق قراءة',
      category: 'nutrition',
      categoryName: 'التغذية',
      emoji: '🍎',
      expert: 'د. منى خالد - أخصائية تغذية',
      views: '8.2k',
      rating: 4.9,
      description:
          'دليل شامل للتغذية الصحية والمتوازنة للأطفال في مرحلة السنتين',
      topics: ['التغذية', 'الوجبات', 'الفيتامينات'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_selectedContentId != null) {
      final item = _contentItems.firstWhere((c) => c.id == _selectedContentId);
      return ContentDetailView(
        item: item,
        isSaved: _savedItems.contains(item.id),
        onBack: () => setState(() => _selectedContentId = null),
      );
    }

    final filteredItems = _selectedCategory == 'all'
        ? _contentItems
        : _contentItems.where((i) => i.category == _selectedCategory).toList();

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
            categories: _categories,
            selectedCategory: _selectedCategory,
            onCategorySelected: (catId) =>
                setState(() => _selectedCategory = catId),
          ),
          16.vS,
          ContentStatsCard(
            availableCount: filteredItems.length,
            savedCount: _savedItems.length,
          ),
          16.vS,
          ...filteredItems.map((item) => ContentCard(
                item: item,
                isSaved: _savedItems.contains(item.id),
                onTap: () => setState(() => _selectedContentId = item.id),
              )),
          16.vS,
          const ContentWeeklyTip(),
        ],
      ),
    );
  }
}
