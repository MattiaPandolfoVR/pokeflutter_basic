// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:pokemon_autoroute/screens/screen_home.dart' as _i1;
import 'package:pokemon_autoroute/screens/screen_pkmn.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeView.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeView(),
      );
    },
    PkmnView.name: (routeData) {
      final args = routeData.argsAs<PkmnViewArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.PkmnView(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeView]
class HomeView extends _i3.PageRouteInfo<void> {
  const HomeView({List<_i3.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.PkmnView]
class PkmnView extends _i3.PageRouteInfo<PkmnViewArgs> {
  PkmnView({
    _i4.Key? key,
    required String id,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          PkmnView.name,
          args: PkmnViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'PkmnView';

  static const _i3.PageInfo<PkmnViewArgs> page =
      _i3.PageInfo<PkmnViewArgs>(name);
}

class PkmnViewArgs {
  const PkmnViewArgs({
    this.key,
    required this.id,
  });

  final _i4.Key? key;

  final String id;

  @override
  String toString() {
    return 'PkmnViewArgs{key: $key, id: $id}';
  }
}
