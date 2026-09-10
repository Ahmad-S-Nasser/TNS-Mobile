import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/routing/app_routes.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/core/widgets/child_card.dart';
import 'package:tips_n_steps/core/widgets/empty_state.dart';
import 'package:tips_n_steps/feature/children/data/model/child_model.dart';
import 'package:tips_n_steps/feature/children/logic/children_cubit.dart';
import 'package:tips_n_steps/feature/children/view/components/add_child_button.dart';

class ChildrenListView extends StatelessWidget {
  final bool showBottomNav;

  const ChildrenListView({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChildrenCubit>(
      create: (_) => sl<ChildrenCubit>()..loadChildren(),
      child: _ChildrenListBody(showBottomNav: showBottomNav),
    );
  }
}

class _ChildrenListBody extends StatelessWidget {
  final bool showBottomNav;

  const _ChildrenListBody({required this.showBottomNav});

  Future<void> _confirmDelete(BuildContext context, ChildModel child) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف الطفل'),
        content: Text('هل أنت متأكد من حذف "${child.fullName}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('حذف', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final success = await context.read<ChildrenCubit>().deleteChild(child.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(success ? 'تم حذف الطفل بنجاح' : 'تعذر حذف الطفل'),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChildrenCubit, ChildrenState>(
      listenWhen: (previous, current) =>
          current.errorMessage != null &&
          current.errorMessage != previous.errorMessage,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      builder: (context, state) {
        final children = state.children;
        final isInitialLoad =
            state.status == ChildrenStatus.loading && children.isEmpty;

        return AppLayout(
          showBottomNav: showBottomNav,
          currentRoute: '/children',
          title: 'أطفالي',
          subtitle: '${children.length} طفل',
          useScrollContainer: false,
          body: isInitialLoad
              ? const Center(child: CircularProgressIndicator())
              : children.isEmpty
                  ? EmptyState(
                      emoji: '👶',
                      title: 'لا توجد أطفال',
                      description: 'ابدأ بإضافة طفلك الأول',
                      actionLabel: 'إضافة طفل',
                      onAction: () => context.pushNamed(AppRoutes.addChild),
                    )
                  : ListView(
                      padding: EdgeInsets.all(16.W),
                      children: [
                        ...children.map((child) => Padding(
                              padding: EdgeInsets.only(bottom: 16.H),
                              child: Stack(
                                children: [
                                  ChildCard(
                                    name: child.fullName,
                                    age: child.age,
                                    emoji: child.emoji,
                                    gender: child.gender,
                                    onGrowthClick: () => context
                                        .pushNamed(AppRoutes.growthFields),
                                    onContentClick: () =>
                                        context.pushNamed(AppRoutes.content),
                                  ),
                                  Positioned(
                                    top: 12.H,
                                    left: 12.W,
                                    child: Row(
                                      children: [
                                        _CardIconButton(
                                          icon: Icons.edit_outlined,
                                          color: AppColors.primaryBlue,
                                          onTap: () => context.pushNamed(
                                            AppRoutes.addChild,
                                            arguments: child,
                                          ),
                                        ),
                                        8.hS,
                                        _CardIconButton(
                                          icon: Icons.delete_outline,
                                          color: AppColors.error,
                                          onTap: () =>
                                              _confirmDelete(context, child),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        8.vS,
                        AddChildButton(
                          onTap: () => context.pushNamed(AppRoutes.addChild),
                        ),
                        40.vS,
                      ],
                    ),
        );
      },
    );
  }
}

class _CardIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CardIconButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.W),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 4.R,
            ),
          ],
        ),
        child: Icon(icon, size: 16.SP, color: color),
      ),
    );
  }
}
