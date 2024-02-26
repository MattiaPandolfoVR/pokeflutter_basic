// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:pokemon_autoroute/model/pkmn.dart' as _i6;
import 'package:pokemon_autoroute/screens/screen_dex.dart' as _i1;
import 'package:pokemon_autoroute/screens/screen_home.dart' as _i2;
import 'package:pokemon_autoroute/screens/screen_pkmn.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    DexView.name: (routeData) {
      final args = routeData.argsAs<DexViewArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.DexView(
          key: args.key,
          pkmnItem: args.pkmnItem,
        ),
      );
    },
    HomeView.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
      );
    },
    PkmnView.name: (routeData) {
      final args = routeData.argsAs<PkmnViewArgs>();
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PkmnView(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.DexView]
class DexView extends _i4.PageRouteInfo<DexViewArgs> {
  DexView({
    _i5.Key? key,
    required List<_i6.Pkmn> pkmnItem,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          DexView.name,
          args: DexViewArgs(
            key: key,
            pkmnItem: pkmnItem,
          ),
          initialChildren: children,
        );

  static const String name = 'DexView';

  static const _i4.PageInfo<DexViewArgs> page = _i4.PageInfo<DexViewArgs>(name);
}

class DexViewArgs {
  const DexViewArgs({
    this.key,
    required this.pkmnItem,
  });

  final _i5.Key? key;

  final List<_i6.Pkmn> pkmnItem;

  @override
  String toString() {
    return 'DexViewArgs{key: $key, pkmnItem: $pkmnItem}';
  }
}

/// generated route for
/// [_i2.HomeView]
class HomeView extends _i4.PageRouteInfo<void> {
  const HomeView({List<_i4.PageRouteInfo>? children})
      : super(
          HomeView.name,
          initialChildren: children,
        );

  static const String name = 'HomeView';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PkmnView]
class PkmnView extends _i4.PageRouteInfo<PkmnViewArgs> {
  PkmnView({
    _i5.Key? key,
    required String id,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          PkmnView.name,
          args: PkmnViewArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'PkmnView';

  static const _i4.PageInfo<PkmnViewArgs> page =
      _i4.PageInfo<PkmnViewArgs>(name);
}

class PkmnViewArgs {
  const PkmnViewArgs({
    this.key,
    required this.id,
  });

  final _i5.Key? key;

  final String id;

  @override
  String toString() {
    return 'PkmnViewArgs{key: $key, id: $id}';
  }
}
