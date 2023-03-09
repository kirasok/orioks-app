import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:orioks/data/model/schedule.dart';
import 'package:orioks/data/model/timetable.dart';
import 'package:orioks/data/repository/schedule_repository.dart';
import 'package:orioks/data/repository/timetable_repository.dart';

import 'internet_cubit.dart';

abstract class ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  Timetable timetable;
  Schedule schedule;
  ScheduleLoaded({required this.timetable, required this.schedule});
}

class ScheduleLoading extends ScheduleState {}

class ScheduleFailed extends ScheduleState {
  Object e;
  ScheduleFailed(this.e) {
    Logger().e(e);
  }
}

class ScheduleCubit extends Cubit<ScheduleState> {
  final InternetCubit internetCubit;
  late StreamSubscription streamSubscription;

  ScheduleCubit({required this.internetCubit}) : super(ScheduleLoading()) {
    try {
      if (internetCubit.state is InternetConnected) {
        loadSchedule();
      } else {
        streamSubscription = internetCubit.stream.listen((internetState) {
          if (internetState is InternetConnected && state is! ScheduleLoaded) {
            loadSchedule();
          }
        });
      }
    } catch (e) {
      emit(ScheduleFailed(e));
    }
  }

  Future<void> loadSchedule() async {
    Future<Schedule> schedule = ScheduleRepository().get();
    Future<Timetable> timetable = TimetableRepository().get();
    Future.wait([timetable, schedule]).then((value) => {
          emit(ScheduleLoaded(
              timetable: value[0] as Timetable, schedule: value[1] as Schedule))
        });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
