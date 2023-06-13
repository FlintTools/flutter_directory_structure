import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:fluent_ui/fluent_ui.dart';


import '/utils/ui.dart';
import '/view_model/small_tools/translate_viewmodel.dart';


/// 翻译页
/// Date: 2023-03-12
class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> with TranslatePageBLoC {
  late FluentThemeData theme;

  @override
  Widget build(context) {
    theme = FluentTheme.of(context);

    return Scaffold(
        body:Container(
          alignment: Alignment.center,
          child: Text("翻译页面"),
        )
    );



  }

}

mixin TranslatePageBLoC on State<TranslatePage> {

}
