// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:base/app/ui/detail/detail_screen.dart' as _i1;
import 'package:base/app/ui/edit/edit_screen.dart' as _i2;
import 'package:base/app/ui/home/home_screen.dart' as _i3;
import 'package:base/domain/domain.dart' as _i6;
import 'package:flutter/material.dart' as _i5;

/// generated route for
/// [_i1.DetailScreen]
class DetailRoute extends _i4.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    _i5.Key? key,
    required _i6.Document document,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         DetailRoute.name,
         args: DetailRouteArgs(key: key, document: document),
         initialChildren: children,
       );

  static const String name = 'DetailRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailRouteArgs>();
      return _i1.DetailScreen(key: args.key, document: args.document);
    },
  );
}

class DetailRouteArgs {
  const DetailRouteArgs({this.key, required this.document});

  final _i5.Key? key;

  final _i6.Document document;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, document: $document}';
  }
}

/// generated route for
/// [_i2.EditScreen]
class EditRoute extends _i4.PageRouteInfo<EditRouteArgs> {
  EditRoute({
    _i5.Key? key,
    _i6.Document? document,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         EditRoute.name,
         args: EditRouteArgs(key: key, document: document),
         initialChildren: children,
       );

  static const String name = 'EditRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditRouteArgs>(
        orElse: () => const EditRouteArgs(),
      );
      return _i2.EditScreen(key: args.key, document: args.document);
    },
  );
}

class EditRouteArgs {
  const EditRouteArgs({this.key, this.document});

  final _i5.Key? key;

  final _i6.Document? document;

  @override
  String toString() {
    return 'EditRouteArgs{key: $key, document: $document}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}
