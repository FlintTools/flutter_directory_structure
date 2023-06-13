import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui' as ui;

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluent_ui/fluent_ui.dart' show FluentThemeData, FluentTheme, TextBox, PasswordBox, PasswordRevealMode;

import '/view_model/user/login_viewmodel.dart';
import '/components/animated_background.dart';
import '/route/route_name.dart';
import '/components/particle/particle_widget.dart';
import "/config.dart";
// import '/utils/top_menu.dart';
import '/utils/ui.dart';

/**
 * 登录页
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  State createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> with LoginBLoC {
  final LoginViewmodel loginViewmodel = Get.put(LoginViewmodel());
  late FluentThemeData theme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    loginViewmodel.context = context;
    theme = FluentTheme.of(context);

    /// 触摸收起键盘
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          body: Column(
        children: [
          // TopMenu(),
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Stack(
                children: <Widget>[
                  // Positioned(top: 0,child: Container(height: 36,child: TopMenu(),)),
                  Positioned.fill(child: AnimatedBackground()),
                  Positioned.fill(child: ParticlesWidget(10)),
                  Center(
                    child: SafeArea(
                      ///同时弹出键盘不遮挡
                      child: SingleChildScrollView(
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          color: Colors.white,
                          margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Container(
                            height: 400,
                            width: 320,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                logoAndDescription(),

                                /// Logo与提示文字
                                _accountPasswdInput(),

                                /// 账号与密码输入框
                                _registerForget(),

                                /// 忘记密码与注册按钮
                                loginButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );

    // Scaffold(body: mainPage());
  }

  /// 登录按钮
  Widget loginButton() => Row(
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 28.0, left: 20, right: 20),
            child: ElevatedButton(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("登录", style: theme.typography.body?.copyWith(fontSize: 16, color: Colors.white)
                    ),
              ),
              onPressed: () {
                Map<String, dynamic> data = {
                  "phone": userController.text,
                  "passwd": pwController.text,
                };
                loginViewmodel.login(data);
              },
            ),
          ))
        ],
      );

  /// Logo与提示文字
  Widget logoAndDescription() {
    return Column(
      children: <Widget>[
        Container(
          transformAlignment: Alignment.center,
          width: 140,
          height: 80,
          child: const Image(
            image: AssetImage('assets/logo.png'),
          ),
        ),
        Text("欢迎使用火石工具",
            style: theme.typography.body?.copyWith(
              fontSize: 16,
              color: Color.fromRGBO(0, 0, 0, 0.55),
            )),
      ],
    );
  }

  /// 账号与密码输入框
  Widget _accountPasswdInput() {
    return Padding(
      padding: new EdgeInsets.only(left: 30.0, top: 16.0, right: 30.0, bottom: 0.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        SizedBox(
          height: 38,
          child: TextBox(
            prefix: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 6),
              width: 20,
              child: Icon(Icons.account_circle, color: UiColour.neutral_4, size: 20),
            ),
            controller: userController,
            placeholder: '账号(随便输入)',
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 38,
          child: PasswordBox(
            revealMode: PasswordRevealMode.peekAlways,
            controller: pwController,
            placeholder: '密码(随便输入)',
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ]),
    );
  }

  // 忘记密码与注册
  Widget _registerForget() {
    return SizedBox(
      height: 50,
      width: 250,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}

mixin LoginBLoC on State<LoginPage> {
  final TextEditingController userController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  String? _userName = "";
  String? _password = "";

  @override
  void initState() {
    super.initState();
    initParams();
  }

  @override
  void dispose() {
    super.dispose();
    userController.removeListener(_usernameChange);
    pwController.removeListener(_passwordChange);
  }

  _usernameChange() {
    _userName = userController.text;
  }

  _passwordChange() {
    _password = pwController.text;
  }

  initParams() async {
    userController.value = new TextEditingValue(text: _userName ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }
}
