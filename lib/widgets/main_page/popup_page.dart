import 'package:fight_app/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Screens.auth,);
            },
            child: const Text("Сменить пользователя"),
          ),
          PopupMenuItem(
            value: 2,
            onTap: () {},
            child: const Text("2"),
          )
        ]
    );
  }
}