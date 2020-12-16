import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

import '../auto_route_guard.dart';
import '../matcher/route_matcher.dart';

typedef ArgsBuilder = RouteArgs Function(RouteMatch match);

@immutable
class RouteConfig {
  final String key;
  final String path;
  final bool fullMatch;
  final Type page;
  final RoutesCollection _children;
  final String redirectTo;
  final List<AutoRouteGuard> guards;
  final ArgsBuilder argsBuilder;

  RouteConfig(
    this.key, {
    @required this.path,
    this.page,
    this.guards = const [],
    this.fullMatch = false,
    this.redirectTo,
    this.argsBuilder,
    List<RouteConfig> children,
  })  : assert(page == null || redirectTo == null),
        assert(fullMatch != null),
        assert(guards != null),
        assert(page == null || redirectTo == null),
        _children = children != null ? RoutesCollection.from(children) : null;

  bool get isSubTree => _children != null;

  RoutesCollection get children => _children;

  bool get isRedirect => redirectTo != null;
}
