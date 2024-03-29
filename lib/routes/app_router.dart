import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeView.page,
          initial: true,
        ),
        AutoRoute(
          page: DexView.page,
        ),
        AutoRoute(
          page: PkmnView.page,
        ),
      ];
}
