import 'package:bloc/bloc.dart';

import 'fight_event.dart';
import 'fight_state.dart';

class FightBloc extends Bloc<FightEvent, FightState> {
  FightBloc() : super(FightState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<FightState> emit) async {
    emit(state.clone());
  }
}
