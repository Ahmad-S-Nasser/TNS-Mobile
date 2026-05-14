import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_assets.dart';

/// App Padding ///

EdgeInsetsGeometry appPadding = EdgeInsets.symmetric(
  horizontal: 20.W,
  vertical: 15.H,
);
EdgeInsetsGeometry appContainerPadding = const EdgeInsets.all(5);

extension CustomPadding on Widget {
  /// padding all ///
  addAllPadding(double val) => Padding(
        padding: EdgeInsets.all(val),
        child: this,
      );

  /// padding symmetric ///
  addSymmetricPadding({double? hVal, double? vVal}) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: hVal ?? 0, vertical: vVal ?? 0),
        child: this,
      );

  /// padding only ///
  addOnlyPadding({double? tVal, double? bVal, double? lVal, double? rVal}) =>
      Padding(
        padding: EdgeInsets.only(
            top: tVal ?? 0,
            bottom: bVal ?? 0,
            left: lVal ?? 0,
            right: rVal ?? 0),
        child: this,
      );
}

/// APP SIZE EXTENSION ///
extension SizeExtension on num {
  double get W => ScreenUtil().setWidth(this);

  double get H => ScreenUtil().setHeight(this);

  // ignore: non_constant_identifier_names
  double get SP => ScreenUtil().setSp(this);

  double get R => ScreenUtil().radius(this);

  Widget get hS => SizedBox(width: W);

  Widget get vS => SizedBox(height: H);
}

/// app navigate Extension ///
extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

/// context extension ///
final GlobalKey<NavigatorState> nK = GlobalKey<NavigatorState>();

extension GlobalContextExt on BuildContext {
  static BuildContext? get globalContext => nK.currentContext;
}

/// platform extension ///
extension PlatformCheck on BuildContext {
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;

  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
}

/// Extension to provide direct access to asset path methods ///
extension AssetPathExtension on String {
  String get svgIcon => AssetPaths.svgIcon(this);

  String get pngImage => AssetPaths.pngImage(this);

  String get pngIcon => AssetPaths.pngIcon(this);

  String get jsonFile => AssetPaths.jsonFile(this);
}

/// Extension for custom scrollview ///
extension SliverExtension on Widget {
  // sliver without any thing //
  SliverToBoxAdapter toSliverToBoxAdapter() => SliverToBoxAdapter(child: this);

  // sliver with padding //
  SliverToBoxAdapter toSliverWithPadding(EdgeInsets padding) =>
      SliverToBoxAdapter(child: Padding(padding: padding, child: this));

  // sliver with key //
  SliverToBoxAdapter toSliverWithKey(Key key) =>
      SliverToBoxAdapter(key: key, child: this);

  // sliver with animation //
  SliverToBoxAdapter toSliverWithAnimation(
          {required Animation<double> animation}) =>
      SliverToBoxAdapter(
          child: FadeTransition(
        opacity: animation,
        child: this,
      ));

  // sliver with condition //
  SliverToBoxAdapter? toSliverWithCondition(bool condition) =>
      condition ? toSliverToBoxAdapter() : null;

  // sliver with safeArea //
  SliverToBoxAdapter toSliverWithSafeArea(
          {bool top = true,
          bool bottom = true,
          bool left = true,
          bool right = true}) =>
      SliverToBoxAdapter(
          child: SafeArea(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: this,
      ));
}
