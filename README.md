
# 火石工具之flutter桌面端MVVM项目目录结构


推荐下我的项目:[火石工具](http://flint-tools.guanshangyun.com/)

![火石工具](https://itools-1253225490.cos.ap-guangzhou.myqcloud.com/article/flutter_directory_structure/20230613152041.png)

` 在项目立项时，我们都会去规划项目的目录结构。在这里给大家介绍下火石工具的MVVM项目目录结构给大家参考；
火石工具主要以桌面端为主，在路由方面与手机端有一定的出入。`

示例Github链接：[flutter_directory_structure](https://github.com/FlintTools/flutter_directory_structure)

### 1. 项目目录搭建解决了我们什么问题？
在项目开发中，如果我们把`视图``逻辑``API请求`都写在一个文件里面，后期维护会给我们带来很大的麻烦，不利于维护及代码复用性不高。所以我们要将代码进行分层，`视图`只负责展示,`逻辑`只负责业务代码的逻辑部分，当我们后期维护需要修改时只需要找到对应的目录文件进行修改。

### 2. 项目主要使用的第三方库
1. getX：用于状态管理
2. go_router：用于路由管理
3. dio：API请求库
4. logger：日志库
5. shared_preferences：数据存储库
6. fluent_ui：windows风格的UI库

### 3. 项目目录结构 
```
根目录
│   README.md 
│   assets              # 用于存放静态资源，如图片、字体等
└───lib
│   │   main.dart       # 入口文件
│   │   config.dart     # 配置文件，可以在这里配置api链接域名及其他一些固定信息
│   │
│   └───api             # API地址
│   └───components      # 公用组件
│   └───models          # API返回的数据结构模型
│   └───route           # 路由
│   └───utils           # 存放一些工具函数类库
│   └───view            # 视图文件
│   └───view_model      # 业务处理
```

`assets` 目录主要放置静态资源，如图片、字体等。
`api` 在项目开发中，很多时候我们都需要与后端通过api进行交互，一个项目几十上百个api很正常，所以单独放置在一个目录下。目录下可以根据业务对文件区分，如登录、注册、修改密码相关的接口可以放在user.dart文件下。
`components` 放置项目公用的组件。
`models` 定义api返回的JSON数据结构（[火石工具](http://flint-tools.guanshangyun.com/)的`JSON转代码模型`功能可以轻松的将json转为代码模型）。
`view` 存放所有的展示页面，文件以`_page`结尾。
`view_model` 存放业务逻辑代码。当用户需要交互时，如登录，当输入账号密码时，在`view_model`校验账号密码格式是否符合规则，如果符合规则将请求api进行登录，api返回的结果使用`models`进行解析。文件以`_viewmodel`结尾。

### 4. 示例代码走读。
在GitHub的示例代码，有三个页面`登录页`、`翻译`、`快递查询`。

#### 4.1 `view`与`view_model`
在`view`与`view_model`目录下分别有两个文件夹及三个文件。可以看到除了后缀、前面的名称一一对应。
![代码图片](https://itools-1253225490.cos.ap-guangzhou.myqcloud.com/article/flutter_directory_structure/20230613202457.png)
我们使用GetX框架作为状态管理，所以需要在`view`下的文件进行注册viewmodel，如lib/view/user/login_page.dart文件：
```dart
final LoginViewmodel loginViewmodel = Get.put(LoginViewmodel());
...
Map<String, dynamic> data = {
  "phone": userController.text,
  "passwd": pwController.text,
};
loginViewmodel.login(data);
```
这样就可以在lib/view/user/login_page.dart文件下与lib/view_model/user/login_viewmodel.dart文件进行状态管理。

#### 4.2 注册路由
因为我的项目主要是桌面端，除了登录、注册等页面外，其他页面需要进行缓存保持页面的状态。所以路由在这里使用了两个方式。
我们可以在lib/route/route.dart文件看到这两种路由的注册方式，`登录页面`正常的切换页面，`功能页面`更新是flutter的`IndexedStack`组件。
```dart
/// 登录页面
GoRoute(path: '/${RouteName.login}', name: RouteName.login, builder: (context, state) => LoginPage()),
/// 功能页面
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
```
功能页面需要在lib/route/route_branches.dart文件下进行注册，还需要在lib/route/route.dart的originalItems变量中添加：
```dart
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
```

#### 4.3 初始化fluent_ui
在`main.dart`文件初始化`fluent_ui`库及加载路由。
```dart
import 'route/route.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
```

## 最后
这是我写的第一篇文章，逻辑不是很清晰，有兴趣的可以看下代码。水平有限，欢迎讨论；

示例Github链接：[flutter_directory_structure](https://github.com/FlintTools/flutter_directory_structure)