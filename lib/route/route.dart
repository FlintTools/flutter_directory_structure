import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

import '/utils/ui.dart';
import '/view/user/login_page.dart';
import '/route/route_name.dart';
import '/route/route_branches.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/login", //'/translate',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    /// 登录
    GoRoute(path: '/${RouteName.login}', name: RouteName.login, builder: (context, state) => LoginPage()),

    /// 注册
    // GoRoute(path: '/${RouteName.register}', name: RouteName.register, builder: (context, state) => RegisterPage()),

    /// 找回密码
    // GoRoute(
    //     path: '/${RouteName.resetPassword}',
    //     name: RouteName.resetPassword,
    //     builder: (context, state) => ResetPassword()),

    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return RouteMenuPage(
          child: child,
          shellContext: _shellNavigatorKey.currentContext,
          state: state,
        );
      },
      branches: routeBranches,
    ),
  ],
);

class RouteMenuPage extends StatefulWidget {
  const RouteMenuPage({
    super.key,
    required this.child,
    required this.shellContext,
    required this.state,
  });

  final StatefulNavigationShell child;
  final BuildContext? shellContext;
  final GoRouterState state;

  @override
  State<RouteMenuPage> createState() => _RouteMenuPageState();
}

class _RouteMenuPageState extends State<RouteMenuPage> with AutomaticKeepAliveClientMixin {
  late FluentThemeData theme;

  late List<NavigationPaneItem> originalItems;
  late List<NavigationPaneItem> footerItems;

  int _calculateSelectedIndex(BuildContext context) {
    final location = router.location;
    int indexOriginal = originalItems
        .where((element) => element.key != null)
        .toList()
        .indexWhere((element) => element.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return originalItems.where((element) => element.key != null).toList().length + indexFooter;
    } else {
      return indexOriginal;
    }
  }

  @override
  void initState() {
    originalItems = [
      PaneItemHeader(header: const Text('常用功能')),
      PaneItem(
        key: Key('/${RouteName.translate}'),
        icon: const Icon(FluentIcons.translate),
        title: const Text('翻译'),
        body: const SizedBox.shrink(),
        onTap: () {
          if (router.location != '/${RouteName.translate}') {
            widget.child.goBranch(
              pcRouteTranslate,
              initialLocation: pcRouteTranslate == widget.child.currentIndex,
            );
          }
        },
      ),
      PaneItem(
        key: Key('/${RouteName.expressDelivery}'),
        icon: const Icon(FluentIcons.air_tickets),
        title: const Text('快递查询'),
        body: const SizedBox.shrink(),
        onTap: () {
          if (router.location != '/${RouteName.expressDelivery}') {
            widget.child.goBranch(
              pcRouteExpressDelivery,
              initialLocation: pcRouteExpressDelivery == widget.child.currentIndex,
            );
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    theme = FluentTheme.of(context);
    super.build(context);

    if (widget.shellContext != null) {
      if (router.canPop() == false) {
        setState(() {});
      }
    }
    return NavigationView(
      // key: viewKey,
      paneBodyBuilder: (item, child) {
        return widget.child;
      },
      pane: NavigationPane(
        size: NavigationPaneSize(openWidth: 240),
        selected: _calculateSelectedIndex(context),
        header: Container(
          width: 220,
          height: 120,
          decoration: BoxDecoration(
            color: Color(0xFFCFCFCF),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              // setButton(),
              SizedBox(height: 10),
              SizedBox(width: 50, height: 50, child: Image.asset("assets/logo.png")),
              SizedBox(height: 10),
              Column(
                children: [
                  Tooltip(
                    message: "能量值在使用功能时消耗，每日恢复2000值",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '能量值：2000',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400), //, color: menuTextColor
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        items: originalItems,
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
