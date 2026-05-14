import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/core/widgets/child_card.dart';
import 'package:tips_n_steps/core/widgets/empty_state.dart';
import 'package:tips_n_steps/feature/children/view/components/add_child_button.dart';

class ChildrenListView extends StatelessWidget {
  final bool showBottomNav;

  const ChildrenListView({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final children = [
      {
        'id': 1,
        'name': 'محمد أحمد',
        'gender': 'male',
        'age': '1 سنة و 8 أشهر',
        'emoji': '👦'
      },
      {
        'id': 2,
        'name': 'فاطمة أحمد',
        'gender': 'female',
        'age': '3 سنوات و 10 أشهر',
        'emoji': '👧'
      }
    ];

    return AppLayout(
      showBottomNav: showBottomNav,
      currentRoute: '/children',
      title: 'أطفالي',
      subtitle: '${children.length} طفل',
      useScrollContainer: false,
      body: children.isEmpty
          ? EmptyState(
              emoji: '👶',
              title: 'لا توجد أطفال',
              description: 'ابدأ بإضافة طفلك الأول',
              actionLabel: 'إضافة طفل',
              onAction: () => context.pushNamed('/add-child'),
            )
          : ListView(
              padding: EdgeInsets.all(16.W),
              children: [
                ...children.map((child) => Padding(
                      padding: EdgeInsets.only(bottom: 16.H),
                      child: ChildCard(
                        name: child['name'] as String,
                        age: child['age'] as String,
                        emoji: child['emoji'] as String,
                        gender: child['gender'] as String,
                        onGrowthClick: () =>
                            context.pushNamed('/growth-fields'),
                        onContentClick: () => context.pushNamed('/content'),
                      ),
                    )),
                8.vS,
                AddChildButton(
                  onTap: () => context.pushNamed('/add-child'),
                ),
                40.vS,
              ],
            ),
    );
  }
}
