import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/di/service_locator.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/theme/app_colors.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/feature/emergency/data/model/emergency_model.dart';
import 'package:tips_n_steps/feature/emergency/logic/emergency_cubit.dart';
import 'package:tips_n_steps/feature/emergency/view/components/emergency_contact_card.dart';
import 'package:tips_n_steps/feature/emergency/view/components/emergency_disclaimer_card.dart';
import 'package:tips_n_steps/feature/emergency/view/components/emergency_kit_button.dart';
import 'package:tips_n_steps/feature/emergency/view/components/emergency_tip_card.dart';
import 'package:tips_n_steps/feature/emergency/view/emergency_tip_detail_view.dart';
import 'package:tips_n_steps/feature/emergency/view/first_aid_kit_view.dart';

class EmergencyView extends StatefulWidget {
  final bool showBottomNav;

  const EmergencyView({super.key, this.showBottomNav = true});

  @override
  State<EmergencyView> createState() => _EmergencyViewState();
}

class _EmergencyViewState extends State<EmergencyView> {
  String? _selectedTipId;
  bool _showFirstAidKit = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EmergencyCubit>(
      create: (_) => sl<EmergencyCubit>()..loadTips(),
      child: BlocBuilder<EmergencyCubit, EmergencyState>(
        builder: (context, state) {
          // First aid kit contents and emergency numbers are client-side
          // static lists (no matching Content section) — see emergency_model.dart.
          if (_showFirstAidKit) {
            return FirstAidKitView(
              kitItems: FirstAidKitItemModel.staticKit,
              onBack: () => setState(() => _showFirstAidKit = false),
            );
          }
          if (_selectedTipId != null) {
            final tip = state.tips.firstWhere(
              (t) => t.id == _selectedTipId,
              orElse: () => state.tips.first,
            );
            return EmergencyTipDetailView(
              tip: tip,
              onBack: () => setState(() => _selectedTipId = null),
            );
          }

          return AppLayout(
            showBottomNav: widget.showBottomNav,
            currentRoute: '/emergency',
            title: 'الطوارئ',
            subtitle: 'أرقام الطوارئ والإسعافات الأولية',
            useScrollContainer: false,
            body: ListView(
              padding: EdgeInsets.all(16.W),
              children: [
                _buildSectionHeader('أرقام الطوارئ'),
                12.vS,
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.H,
                  crossAxisSpacing: 12.W,
                  childAspectRatio: 0.85,
                  children: EmergencyNumberModel.staticNumbers
                      .map((number) => EmergencyContactCard(contact: number))
                      .toList(),
                ),
                24.vS,
                EmergencyKitButton(
                  onTap: () => setState(() => _showFirstAidKit = true),
                ),
                24.vS,
                _buildSectionHeader('دليل الإسعافات الأولية'),
                12.vS,
                if (state.status == EmergencyStatus.loading ||
                    state.status == EmergencyStatus.initial)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state.status == EmergencyStatus.error)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                          state.errorMessage ?? 'تعذر تحميل الإسعافات الأولية'),
                    ),
                  )
                else if (state.tips.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                        child: Text('لا توجد إسعافات أولية متاحة حالياً')),
                  )
                else
                  ...state.tips.map((tip) => EmergencyTipCard(
                        tip: tip,
                        onTap: () => setState(() => _selectedTipId = tip.id),
                      )),
                24.vS,
                const EmergencyDisclaimerCard(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(title,
        style: TextStyle(
            fontSize: 22.SP,
            fontWeight: FontWeight.bold,
            color: AppColors.gray800));
  }
}
