import 'package:auto_route/src/matcher/route_match.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;

import '../../auto_route.dart';
import '../utils.dart';

@immutable
class PageRouteInfo {
  final String _key;
  final String path;
  final String _rawMatch;
  final List<PageRouteInfo> children;
  final RouteArgs args;

  const PageRouteInfo(
    this._key, {
    @required this.path,
    String match,
    this.children,
    this.args,
  }) : _rawMatch = match;

  String get routeKey => _key;

  factory PageRouteInfo.fromMatch(RouteMatch match) {
    assert(match != null);
    var children;
    if (match.hasChildren) {
      children = match.children.map((m) => PageRouteInfo.fromMatch(m)).toList(growable: false);
    }
    return PageRouteInfo(match.config.key,
        path: match.config.path, match: p.joinAll(match.segments), children: children, args: match.buildArgs());
  }

  // String get match => _rawMatch ?? _expand(path, pathParams);

  // String get fullPath => p.joinAll([match, if (hasChildren) children.last.fullPath]);

  bool get hasChildren => !listNullOrEmpty(children);

  // static String _expand(String template, Map<String, dynamic> params) {
  //   if (mapNullOrEmpty(params)) {
  //     return template;
  //   }
  //   var paramsRegex = RegExp(":(${params.keys.join('|')})");
  //   var path = template.replaceAllMapped(paramsRegex, (match) {
  //     return params[match.group(1)]?.toString() ?? '';
  //   });
  //   return path;
  // }

  PageRouteInfo copyWith({
    String key,
    String path,
    Map<String, dynamic> pathParams,
    Map<String, dynamic> queryParams,
    String fragment,
    List<PageRouteInfo> children,
    Object args,
  }) {
    return new PageRouteInfo(
      key ?? this._key,
      path: path ?? this.path,
      // match: match ?? this.match,
      children: children ?? this.children,
      args: args ?? this.args,
    );
  }

  @override
  String toString() {
    return 'route{path: $path, pathName: $path}';
  }

  @override
  bool operator ==(Object o) {
    var mapEquality = MapEquality();
    return identical(this, o) ||
        o is PageRouteInfo &&
            runtimeType == o.runtimeType &&
            _key == o._key &&
            path == o.path &&
            _rawMatch == o._rawMatch &&
            args == o.args &&
            ListEquality().equals(children, o.children);
  }

// maybe?
  Future<void> push(BuildContext context) {
    return context.router.push(this);
  }

  @override
  int get hashCode => _key.hashCode ^ path.hashCode ^ _rawMatch.hashCode ^ children.hashCode ^ args.hashCode;
}
