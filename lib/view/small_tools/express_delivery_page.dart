import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:fluent_ui/fluent_ui.dart';

/// 快递查询
/// Date: 2023-03-18
class ExpressDeliveryPage extends StatefulWidget {
  @override
  _ExpressDeliveryPageState createState() => _ExpressDeliveryPageState();
}

class _ExpressDeliveryPageState extends State<ExpressDeliveryPage> with ExpressDeliveryPageBLoC {
  late FluentThemeData theme;

  @override
  Widget build(context) {
    theme = FluentTheme.of(context);

    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Text("快递查询页面"),
    ));
  }
}

mixin ExpressDeliveryPageBLoC on State<ExpressDeliveryPage> {}
