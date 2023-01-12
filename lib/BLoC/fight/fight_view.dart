import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fight_bloc.dart';
import 'fight_event.dart';
import 'fight_state.dart';

class FightPage extends StatelessWidget {
  const FightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FightBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<FightBloc>(context);

    return Container();
  }
}

