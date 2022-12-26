import 'package:fight_app/widgets/authorization_page/authorization_page_widget.dart';
import 'package:fight_app/widgets/error_page/error_page_widget.dart';
import 'package:fight_app/widgets/main_page/main_page_widget.dart';
import 'package:flutter/material.dart';

abstract class Screens {
  static const auth = '/';
  static const main = '/main';
    static const errorPage = '/main/errorPage';
}


class MainNavigation {
  Map<String, WidgetBuilder> get routes => {
    Screens.auth: (context) => const AuthorizationPageWidget(),
    Screens.main: (context) => const MainPageWidget(),
    Screens.errorPage: (context) => const ErrorPageWidget(),

  };

}

