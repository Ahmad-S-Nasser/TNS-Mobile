import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';
import 'package:tips_n_steps/core/widgets/app_header.dart';
import 'package:tips_n_steps/core/widgets/bottom_nav_bar.dart';

class AppLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Widget body;
  final bool showBottomNav;
  final String? currentRoute;
  final bool useScrollContainer;

  const AppLayout({
    super.key,
    required this.body,
    this.title,
    this.subtitle,
    this.showBackButton = false,
    this.onBack,
    this.actions,
    this.showBottomNav = true,
    this.currentRoute,
    this.useScrollContainer = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = body;

    if (useScrollContainer) {
      content = SingleChildScrollView(
        padding: EdgeInsets.only(bottom: showBottomNav ? 96.H : 24.H),
        child: body,
      );
    } else if (showBottomNav) {
      content = Padding(
        padding: EdgeInsets.only(bottom: 96.H),
        child: body,
      );
    }

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      bottomNavigationBar: showBottomNav
          ? BottomNavBar(
              selectedIndex: _getSelectedIndex(currentRoute),
              onTap: (index) {
                final route = _getRouteFromIndex(index);
                context.pushNamed(route);
              },
            )
          : null,
      body: Column(
        children: [
          if (title != null)
            AppHeader(
              title: title!,
              subtitle: subtitle,
              showBackButton: showBackButton,
              onBack: onBack,
              actions: actions,
            ),
          Expanded(child: content),
        ],
      ),
    );
  }

  int _getSelectedIndex(String? route) {
    switch (route) {
      case '/settings':
        return 0;
      case '/children':
        return 1;
      case '/emergency':
        return 2;
      case '/content':
        return 3;
      case '/home':
        return 4;
      default:
        return 4;
    }
  }

  String _getRouteFromIndex(int index) {
    switch (index) {
      case 0:
        return '/settings';
      case 1:
        return '/children';
      case 2:
        return '/emergency';
      case 3:
        return '/content';
      case 4:
        return '/home';
      default:
        return '/home';
    }
  }
}
