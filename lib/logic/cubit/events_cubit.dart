import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:orioks/data/model/event.dart';
import 'package:orioks/data/repository/events_repository.dart';

import 'internet_cubit.dart';

abstract class EventsState {}

class EventsLoaded extends EventsState {
  List<Event> events;
  EventsLoaded({required this.events});
}

class EventsLoading extends EventsState {}

class EventsFailed extends EventsState {
  Object e;
  EventsFailed(this.e) {
    Logger().e(e);
  }
}

class EventsCubit extends Cubit<EventsState> {
  int disciplineId;
  InternetCubit internetCubit;
  late StreamSubscription streamSubscription;

  EventsCubit({required this.disciplineId, required this.internetCubit})
      : super(EventsLoading()) {
    try {
      if (internetCubit.state is InternetConnected) {
        loadEvents(disciplineId);
      } else {
        streamSubscription = internetCubit.stream.listen((internetState) {
          if (internetState is InternetConnected && state is! EventsLoaded) {
            loadEvents(disciplineId);
          }
        });
      }
    } catch (e) {
      emit(EventsFailed(e));
    }
  }

  Future<void> loadEvents(int disciplineId) => EventsRepository()
      .get(disciplineId)
      .then((value) => emit(EventsLoaded(events: value)));

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
