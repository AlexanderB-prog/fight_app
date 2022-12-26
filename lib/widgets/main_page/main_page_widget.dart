import 'package:fight_app/entity/user.dart';
import 'package:fight_app/model/main_page_model/main_page_model.dart';
import 'package:fight_app/navigation/main_navigation.dart';
import 'package:fight_app/widgets/main_page/popup_page.dart';
import 'package:flutter/material.dart';

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageWidgetModelProvider(
      model: MainPageWidgetModel(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // toolbarHeight: 30,
            title: const Text('Битва!'),
            actions: [IconButton(onPressed: () => Navigator.of(context).pushReplacementNamed(Screens.auth), icon: const Icon(Icons.logout))],
          ),
          body: Column(
            children: const [
              MainScreenWidget(),
              ActionScreenWidget(),
              LogScreenWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = MainPageWidgetModelProvider.of(context).model;
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.black12,
        child: Row(
          children: [
            Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex:1,
                      child: SizedBox(
                          height: 30,
                          child: Text(
                            User.nameUser,
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Expanded(flex:5,child: Image.asset('assets/images/cat.webp',height: 100,)),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          model.user.hp > 0
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          model.user.hp > 1
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          model.user.hp > 2
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          model.user.hp > 3
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          model.user.hp > 4
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex:1,
                child: Column(
                  children: [
                    Expanded(
                      flex:1,
                      child: SizedBox(
                          height: 30,
                          child: Text(
                            model.bot.name,
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                    ),
                    Expanded(flex:5,child: Image.asset('assets/images/bot1.jpg',height: 100,)),
                    Expanded(
                      flex:1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          model.bot.hp > 0
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          model.bot.hp > 1
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          model.bot.hp > 2
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          model.bot.hp > 3
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                          model.bot.hp > 4
                              ? const Icon(Icons.star)
                              : const Icon(Icons.star_border),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class ActionButtonWidget extends StatelessWidget {
  final BodyPart bodyPart;
  final StatusButton statusButton;

  const ActionButtonWidget({
    Key? key,
    required this.bodyPart,
    required this.statusButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = MainPageWidgetModelProvider.of(context).model;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: model.backgroundColor(statusButton, bodyPart),
            overlayColor: MaterialStateProperty.all(Colors.grey),
          ),
          onPressed: () => model.onButtonPress(statusButton, bodyPart),
          child: Text(model.text(bodyPart)),
        ),
      ),
    );
  }
}

class ActionScreenWidget extends StatelessWidget {
  const ActionScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: const [
          Expanded(
            child: Text(
              'АТАКА',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'ЗАЩИТА',
              textAlign: TextAlign.center,
            ),
          ),
        ]),
        Row(children: const [
          ActionButtonWidget(
            statusButton: StatusButton.attack,
            bodyPart: BodyPart.head,
          ),
          ActionButtonWidget(
            statusButton: StatusButton.defence,
            bodyPart: BodyPart.head,
          )
        ]),
        Row(children: const [
          ActionButtonWidget(
            statusButton: StatusButton.attack,
            bodyPart: BodyPart.torso,
          ),
          ActionButtonWidget(
            statusButton: StatusButton.defence,
            bodyPart: BodyPart.torso,
          )
        ]),
        Row(children: const [
          ActionButtonWidget(
            statusButton: StatusButton.attack,
            bodyPart: BodyPart.legs,
          ),
          ActionButtonWidget(
            statusButton: StatusButton.defence,
            bodyPart: BodyPart.legs,
          )
        ]),
        ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width / 2, 36)),
              backgroundColor: MaterialStateProperty.all(Colors.green),
            ),
            onPressed: () {
              MainPageWidgetModelProvider.of(context)
                  .model
                  .onStartButtonPress(context);

              MainPageWidgetModelProvider.of(context).model.endGame(context);
            },
            child: const Text('СТАРТ')),
      ],
    );
  }
}

class LogScreenWidget extends StatelessWidget {
  const LogScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Card(
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('История ударов'),
              ],
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white70,
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: MainPageWidgetModelProvider.of(context)
                          .model
                          .logHistory,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
