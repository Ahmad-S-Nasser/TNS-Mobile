import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tips_n_steps/core/widgets/bottom_nav_bar.dart';
import 'package:tips_n_steps/core/widgets/main_layout_wrapper.dart';
import 'package:tips_n_steps/feature/children/view/children_list_view.dart';
import 'package:tips_n_steps/feature/content/view/content_view.dart';
import 'package:tips_n_steps/feature/emergency/view/emergency_view.dart';
import 'package:tips_n_steps/feature/home/view/home_view.dart';
import 'package:tips_n_steps/feature/main/logic/main_cubit.dart';
import 'package:tips_n_steps/feature/settings/view/settings_view.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  final List<Widget> _pages = const [
    SettingsView(showBottomNav: false), // Index 0
    ChildrenListView(showBottomNav: false), // Index 1
    EmergencyView(showBottomNav: false), // Index 2
    ContentView(showBottomNav: false), // Index 3
    HomeView(showBottomNav: false), // Index 4
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return MainLayoutWrapper(
            showOverlays: true,
            child: Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: List.generate(_pages.length, (index) {
                  final bool isSelected = state.index == index;
                  return AnimatedOpacity(
                    opacity: isSelected ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    child: IgnorePointer(
                      ignoring: !isSelected,
                      child: _pages[index],
                    ),
                  );
                }),
              ),
              bottomNavigationBar: BottomNavBar(
                selectedIndex: state.index,
                onTap: (index) => context.read<MainCubit>().changeIndex(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
