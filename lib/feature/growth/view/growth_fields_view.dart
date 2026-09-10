import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/core/widgets/info_card.dart';
import 'package:tips_n_steps/feature/growth/logic/growth_cubit.dart';
import 'package:tips_n_steps/feature/growth/view/components/growth_field_card.dart';
import 'package:tips_n_steps/feature/growth/view/growth_field_detail_view.dart';

class GrowthFieldsView extends StatelessWidget {
  const GrowthFieldsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GrowthCubit>(
      create: (_) => sl<GrowthCubit>()..loadFields(),
      child: const _GrowthFieldsBody(),
    );
  }
}

class _GrowthFieldsBody extends StatelessWidget {
  const _GrowthFieldsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GrowthCubit, GrowthState>(
      builder: (context, state) {
        if (state.detailStatus == GrowthStatus.loaded &&
            state.selectedField != null) {
          return GrowthFieldDetailView(
            field: state.selectedField!,
            onBack: () => context.read<GrowthCubit>().clearSelection(),
          );
        }

        return AppLayout(
          currentRoute: '/growth-fields',
          title: 'مجالات النمو',
          subtitle: 'تابع نمو طفلك في جميع المجالات',
          showBackButton: true,
          onBack: () => context.pop(),
          useScrollContainer: false,
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, GrowthState state) {
    if (state.fieldsStatus == GrowthStatus.loading ||
        state.fieldsStatus == GrowthStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.fieldsStatus == GrowthStatus.error) {
      return Center(child: Text(state.errorMessage ?? 'حدث خطأ ما'));
    }
    if (state.detailStatus == GrowthStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: EdgeInsets.all(16.W),
      children: [
        const InfoCard(
          emoji: '📊',
          title: 'متابعة شاملة للنمو',
          description:
              'اضغط على أي مجال لعرض التفاصيل الكاملة والمعالم التطورية والنصائح',
        ),
        16.vS,
        ...state.fields.map((field) => GrowthFieldCard(
              field: field,
              onTap: () => context.read<GrowthCubit>().selectField(field.id),
            )),
      ],
    );
  }
}
