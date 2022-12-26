import 'dart:math';

import 'package:fight_app/entity/user.dart';
import 'package:fight_app/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

enum StatusButton { attack, defence }
enum BodyPart { head, torso, legs }



BodyPart convertToBodyPart(int number) {
  switch (number) {
    case 0:
      return BodyPart.head;
    case 1:
      return BodyPart.torso;
    case 2:
      return BodyPart.legs;
    default:
      return BodyPart.legs;
  }
}

class MainPageWidgetModel extends ChangeNotifier {
  User user = User('Alex', Image.asset('lib/assets/images/cat.webp'), 5);
  User bot = User('Bot', Image.asset('lib/assets/images/bot1.jpg'), 5);
  int _battleRaund = 0;
  List<Widget> logHistory = [];
  Map<BodyPart, bool> buttonStatusAttack = {
    BodyPart.head: true,
    BodyPart.torso: true,
    BodyPart.legs: true,
  };
  Map<BodyPart, bool> buttonStatusDefence = {
    BodyPart.head: true,
    BodyPart.torso: true,
    BodyPart.legs: true,
  };



  String text(BodyPart bodyPart) {
    switch (bodyPart) {
      case BodyPart.head:
        return 'Голова';
      case BodyPart.torso:
        return 'Тело';
      case BodyPart.legs:
        return 'Ноги';
    }
  }

  _createLogHistory({
    required BodyPart userAttack,
    required BodyPart userDefence,
    required BodyPart botAttack,
    required BodyPart botDefence,
  }) {
    _battleRaund +=1;
    logHistory.add(const Text(''));
    logHistory.add(Text('Раунд $_battleRaund'));
    if (userAttack == botDefence) {
      logHistory.add(Text('Твой удар заблокирован. (${text(userAttack)})',style: const TextStyle(color: Colors.brown,fontSize: 18),));
    } else {
      logHistory.add(Text('Ты попал! (${text(userAttack)})',style: const TextStyle(color: Colors.red,fontSize: 18),));
    }
    if (botAttack == userDefence) {
      logHistory.add(Text('Ты заблокировал удар. (${text(botAttack)})',style: const TextStyle(color: Colors.brown,fontSize: 18),));
    } else {
      logHistory.add(Text('В тебя попали! (${text(botAttack)})',style: const TextStyle(color: Colors.red,fontSize: 18),));
    }

  }


  void onStartButtonPress(BuildContext context) {
    if ((user.hp == 0) || (bot.hp == 0)) {} else {
      BodyPart botAttack = convertToBodyPart(Random().nextInt(3));
      BodyPart botDefence = convertToBodyPart(Random().nextInt(3));
      BodyPart userAttack;
      BodyPart userDefence;
      if (!buttonStatusAttack[BodyPart.head]!) {
        userAttack = BodyPart.head;
      } else if (!buttonStatusAttack[BodyPart.torso]!) {
        userAttack = BodyPart.torso;
      } else if (!buttonStatusAttack[BodyPart.legs]!) {
        userAttack = BodyPart.legs;
      } else {
        Navigator.pushNamed(context, Screens.errorPage);
        return;
      }
      if (!buttonStatusDefence[BodyPart.head]!) {
        userDefence = BodyPart.head;
      } else if (!buttonStatusDefence[BodyPart.torso]!) {
        userDefence = BodyPart.torso;
      } else if (!buttonStatusDefence[BodyPart.legs]!) {
        userDefence = BodyPart.legs;
      } else {
        Navigator.pushNamed(context, Screens.errorPage);
        return;
      }

      if (userAttack != botDefence) {
        bot.hp = bot.hp - 1;
      }
      if (botAttack != userDefence) {
        user.hp = user.hp - 1;
      }
      _createLogHistory(
        botAttack: botAttack,
        botDefence: botDefence,
        userAttack: userAttack, userDefence: userDefence,
      );
      notifyListeners();
    }
  }

  Widget? endGame(BuildContext context) {
    if ((user.hp == 0) & (bot.hp == 0)) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('НИЧЬЯ'),
            content: const Text('Боевая ничтья. Поторить?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, Screens.main, (route) => false),
                child: const Text('Да'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Нет'),
              ),
            ],
          );
        },
      );
    } else if (user.hp == 0) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ПРОИГРАЛ'),
            content: const Text(
                'Победа Bot. Ты проиграл. Не растраивайся. Повезет в другой раз. Поторить?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, Screens.main, (route) => false),
                child: const Text('Да'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Нет'),
              ),
            ],
          );
        },
      );
    } else if (bot.hp == 0) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ПОБЕДА'),
            content: const Text('Ура. Поздравляю. Ты победил! Поторить?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, Screens.main, (route) => false),
                child: const Text('Да'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Нет'),
              ),
            ],
          );
        },
      );
    }
    return null;
  }

  MaterialStateProperty<Color> backgroundColor(
      StatusButton statusButton, BodyPart bodyPart) {
    if (statusButton == StatusButton.attack) {
      return buttonStatusAttack[bodyPart]!
          ? MaterialStateProperty.all(Colors.brown)
          : MaterialStateProperty.all(Colors.grey);
    } else {
      return buttonStatusDefence[bodyPart]!
          ? MaterialStateProperty.all(Colors.brown)
          : MaterialStateProperty.all(Colors.grey);
    }
  }

  void onButtonPress(StatusButton statusButton, BodyPart bodyPart) {
    if (statusButton == StatusButton.attack) {
      if (bodyPart == BodyPart.head) {
        buttonStatusAttack[BodyPart.head] = !buttonStatusAttack[BodyPart.head]!;
        buttonStatusAttack[BodyPart.torso] = true;
        buttonStatusAttack[BodyPart.legs] = true;
      }
      if (bodyPart == BodyPart.torso) {
        buttonStatusAttack[BodyPart.head] = true;
        buttonStatusAttack[BodyPart.torso] =
            !buttonStatusAttack[BodyPart.torso]!;
        buttonStatusAttack[BodyPart.legs] = true;
      }
      if (bodyPart == BodyPart.legs) {
        buttonStatusAttack[BodyPart.head] = true;
        buttonStatusAttack[BodyPart.torso] = true;
        buttonStatusAttack[BodyPart.legs] = !buttonStatusAttack[BodyPart.legs]!;
      }
    } else {
      if (bodyPart == BodyPart.head) {
        buttonStatusDefence[BodyPart.head] =
            !buttonStatusDefence[BodyPart.head]!;
        buttonStatusDefence[BodyPart.torso] = true;
        buttonStatusDefence[BodyPart.legs] = true;
      }
      if (bodyPart == BodyPart.torso) {
        buttonStatusDefence[BodyPart.head] = true;
        buttonStatusDefence[BodyPart.torso] =
            !buttonStatusDefence[BodyPart.torso]!;
        buttonStatusDefence[BodyPart.legs] = true;
      }
      if (bodyPart == BodyPart.legs) {
        buttonStatusDefence[BodyPart.head] = true;
        buttonStatusDefence[BodyPart.torso] = true;
        buttonStatusDefence[BodyPart.legs] =
            !buttonStatusDefence[BodyPart.legs]!;
      }
    }
    notifyListeners();
  }
}

class MainPageWidgetModelProvider extends InheritedNotifier {
  final MainPageWidgetModel model;

  const MainPageWidgetModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static MainPageWidgetModelProvider of(BuildContext context) {
    final MainPageWidgetModelProvider? result = context
        .dependOnInheritedWidgetOfExactType<MainPageWidgetModelProvider>();
    assert(result != null, 'No MainPageWidgetModelProvider found in context');
    return result!;
  }
}
