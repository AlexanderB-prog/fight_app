import 'package:flutter/material.dart';

class ErrorPageWidget extends StatelessWidget {
  const ErrorPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 30,
        title: const Text('Битва!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text('Не выбрана атака или защита'),
          const SizedBox(height: 15,),
          TextButton(onPressed: () =>Navigator.pop(context), child: const Text('Назад'))
        ],),
      ),
    );
  }
}
