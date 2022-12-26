import 'package:fight_app/navigation/main_navigation.dart';
import 'package:flutter/material.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final mainNavigation = MainNavigation();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey
        ),
      ),
      title: 'BAO Fight App',
      initialRoute:Screens.auth,
      routes: mainNavigation.routes,

    );
  }
}
