import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/widgets/app_layout.dart';
import 'package:tips_n_steps/feature/home/view/components/home_children_quick_access.dart';
import 'package:tips_n_steps/feature/home/view/components/home_services_grid.dart';

class HomeView extends StatefulWidget {
  final bool showBottomNav;

  const HomeView({super.key, this.showBottomNav = true});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showBottomNav: widget.showBottomNav,
      currentRoute: '/home',
      title: 'مرحباً بك 👋',
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeChildrenQuickAccess(),
          HomeServicesGrid(),
        ],
      ),
    );
  }
}
