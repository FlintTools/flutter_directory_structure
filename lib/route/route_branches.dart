import 'package:go_router/go_router.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;

import '/route/route_name.dart';
import '/view/small_tools/translate_page.dart';
import '/view/small_tools/express_delivery_page.dart';

const int pcRouteTranslate = 0; // 翻译
const int pcRouteExpressDelivery = 1; // 快递查询


final GlobalKey<NavigatorState> _sectionANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final routeBranches = <StatefulShellBranch>[
  StatefulShellBranch(
    navigatorKey: _sectionANavigatorKey,
    routes: <RouteBase>[
      GoRoute(path: '/${RouteName.translate}', name: RouteName.translate, builder: (context, state) => TranslatePage()),
    ],
  ),
  StatefulShellBranch(
    routes: <RouteBase>[
      GoRoute(
          path: '/${RouteName.expressDelivery}',
          name: RouteName.expressDelivery,
          builder: (context, state) => ExpressDeliveryPage()),
    ],
  ),
];