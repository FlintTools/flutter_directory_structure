import 'dart:io';

import 'package:get/get.dart';
import 'route/route.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main(List<String> args) async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(
        fontFamily: 'NotoSansSC-Regular',
      ),
      darkTheme: FluentThemeData(
        // accentColor: Colors.blue,
        fontFamily: 'NotoSansSC-Regular',
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
