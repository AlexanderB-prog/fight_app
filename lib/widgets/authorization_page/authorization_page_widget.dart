import 'package:fight_app/entity/user.dart';
import 'package:fight_app/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class AuthorizationPageWidget extends StatelessWidget {
  const AuthorizationPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 50),
              const Text(
                'Победи противника!',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 80),
              const Icon(
                Icons.man,
                size: 50,
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (text) {
                    User.nameUser = text;
                  },
                  autofocus: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    labelText: "Ввести логин",
                    labelStyle: TextStyle(fontSize: 25, color: Colors.black),
                    hintText: "Логин",
                  ),
                ),
              ),

            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Screens.main);
                    },
                    child: const Text('Начать битву')),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
